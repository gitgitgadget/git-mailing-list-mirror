From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Make sure to use Araxis' "compare" and not e.g. ImageMagick's
Date: Mon, 23 Jul 2012 23:26:22 +0200
Message-ID: <m2zk6qxj7l.fsf@igel.home>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
	<500CFB19.6010905@gmail.com> <7vmx2qmnfw.fsf@alter.siamese.dyndns.org>
	<500DA7F3.3000403@gmail.com> <7v4noykxvm.fsf@alter.siamese.dyndns.org>
	<CAHGBnuOz94YR9wx_goL5YaWzPt5Z9c3gBB9CtyfcE40F5amrXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:26:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StQ9A-0006Kj-H3
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 23:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755081Ab2GWV00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 17:26:26 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:46373 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918Ab2GWV00 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 17:26:26 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Wgwk75Rsmz4KK2D;
	Mon, 23 Jul 2012 23:26:23 +0200 (CEST)
X-Auth-Info: a4LnCZ3iT7taEBuqybxfFpQU7UKsblJBdnp5cmP3WeU=
Received: from igel.home (ppp-93-104-133-102.dynamic.mnet-online.de [93.104.133.102])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3Wgwk753gmzbbgl;
	Mon, 23 Jul 2012 23:26:23 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 23BF0CA2A3; Mon, 23 Jul 2012 23:26:22 +0200 (CEST)
X-Yow: Edwin Meese made me wear CORDOVANS!!
In-Reply-To: <CAHGBnuOz94YR9wx_goL5YaWzPt5Z9c3gBB9CtyfcE40F5amrXw@mail.gmail.com>
	(Sebastian Schuberth's message of "Mon, 23 Jul 2012 23:09:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201987>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Please feel free to ignore the patch if you feel the heuristics is not
> sufficiently safe. I'm currently unable to come up with a safer
> solution while maintaining portability, i.e. not use "which" or doing
> rather laborious string parsing on the output of "type".

How about looking at "compare --version"?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
