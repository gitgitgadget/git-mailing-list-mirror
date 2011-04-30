From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Sat, 30 Apr 2011 11:09:47 +0200
Message-ID: <m21v0kw1es.fsf@igel.home>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net>
	<20110429223433.GA3434@sigill.intra.peff.net>
	<m2k4ecy6rv.fsf@igel.home> <7vfwp0uwu4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 11:10:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QG6Br-0005eL-H0
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 11:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397Ab1D3JJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2011 05:09:52 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40256 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab1D3JJv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2011 05:09:51 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 5DD7C188A17C;
	Sat, 30 Apr 2011 11:09:47 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 220701C00102;
	Sat, 30 Apr 2011 11:09:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id DLIiTPQoii9J; Sat, 30 Apr 2011 11:09:48 +0200 (CEST)
Received: from igel.home (ppp-88-217-96-216.dynamic.mnet-online.de [88.217.96.216])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat, 30 Apr 2011 11:09:47 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 47AABCA29C; Sat, 30 Apr 2011 11:09:47 +0200 (CEST)
X-Yow: I will SHAVE and buy JELL-O and bring my MARRIAGE MANUAL!!
In-Reply-To: <7vfwp0uwu4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 29 Apr 2011 22:33:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172519>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> It also conflicts a little with the shell's "~user" syntax, though
>>> presumably you don't have users named "1" and "2".
>>
>> Well, you sorta do if you did use pushd.
>
> Yeah, I was also worried about that.  Or some arcane system
> misinterpreting "~0" as the home directory of root ;-)

On non-arcane systems ~0 is expanded to the current directory.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
