From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [RFC/PATCH] Add the NO_SENTINEL build variable
Date: Wed, 17 Jul 2013 18:55:12 +0200
Message-ID: <87sizd3z4f.fsf@igel.home>
References: <51E4338E.4090003@ramsay1.demon.co.uk>
	<7v38rd8925.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 18:55:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzV0i-00017q-6n
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 18:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756410Ab3GQQzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 12:55:24 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:34171 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab3GQQzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 12:55:23 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3bwPjc0Vl9z3hhnD;
	Wed, 17 Jul 2013 18:55:15 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3bwPjb2LNwzbbg9;
	Wed, 17 Jul 2013 18:55:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 40HlBIrEZUFW; Wed, 17 Jul 2013 18:55:12 +0200 (CEST)
X-Auth-Info: aEyogSO/Rl+6Hpw2zpF6Q9TZim+rZLsIQMjRNLIi/ac=
Received: from igel.home (ppp-88-217-121-223.dynamic.mnet-online.de [88.217.121.223])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed, 17 Jul 2013 18:55:12 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 2DF25E4250; Wed, 17 Jul 2013 18:55:12 +0200 (CEST)
X-Yow: I want you to organize my PASTRY trays...  my TEA-TINS are gleaming in
 formation like a ROW of DRUM MAJORETTES --
 please don't be FURIOUS with me --
In-Reply-To: <7v38rd8925.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 17 Jul 2013 09:06:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230633>

Junio C Hamano <gitster@pobox.com> writes:

> Also do we know what version of GCC started supporting this
> attribute?  http://gcc.gnu.org/gcc-4.0/changes.html mentions it in
> "New Languages and Language specific improvements" section, but the
> page also says "The latest release in the 4.0 release series is GCC
> 4.0.4", so it is not clear if 4.0 had it, or it was added somewhere
> between 4.0 and 4.0.4 to me.

Generally, gcc doesn't get new features added within the same minor
version, only bug fixes.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
