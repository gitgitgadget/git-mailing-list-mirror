From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Mon, 17 Dec 2012 21:03:39 +0100
Message-ID: <m21ueo78f8.fsf@igel.home>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
	<7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
	<20121212094432.6e1e48c8@chalon.bertin.fr>
	<7v38zb3ux0.fsf@alter.siamese.dyndns.org>
	<877goht6eu.fsf@pctrast.inf.ethz.ch>
	<20121217114058.449cbc3c@chalon.bertin.fr>
	<CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yann Dirson <dirson@bertin.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:04:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkgv1-0005i1-7F
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 21:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab2LQUDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 15:03:48 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:55243 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab2LQUDr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 15:03:47 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3YQCws0DCBz4KK5n;
	Mon, 17 Dec 2012 21:03:40 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3YQCwr6fXHzbc0B;
	Mon, 17 Dec 2012 21:03:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id ZMUADyFreYTj; Mon, 17 Dec 2012 21:03:40 +0100 (CET)
X-Auth-Info: LccJlnEv7HAE3DZOMvOD82y0psdhlfKcfSn8UOM0WcU=
Received: from igel.home (ppp-93-104-139-188.dynamic.mnet-online.de [93.104.139.188])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 17 Dec 2012 21:03:40 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id D3054CA2B2; Mon, 17 Dec 2012 21:03:39 +0100 (CET)
X-Yow: ..  are the STEWED PRUNES still in the HAIR DRYER?
In-Reply-To: <CAP8UFD2pkotNy=t5wTxDH-pMivQsTz-kw2y8Y7rWY42YKabp7g@mail.gmail.com>
	(Christian Couder's message of "Mon, 17 Dec 2012 14:43:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211698>

Christian Couder <christian.couder@gmail.com> writes:

> Yeah, at one point I wanted to have a command that created to craft a
> new commit based on an existing one.

This isn't hard to do, you only have to resort to plumbing:

$ git cat-file commit fef11965da875c105c40f1a9550af1f5e34a6e62 | sed s/bfae342c973b0be3c9e99d3d86ed2e6b152b4a6b/790c83cda92f95f1b4b91e2ddc056a52a99a055d/ | git hash-object -t commit --stdin -w
bb45cc6356eac6c7fa432965090045306dab7026

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
