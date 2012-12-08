From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] sh-setup: work around "unset IFS" bug in some shells
Date: Sat, 08 Dec 2012 10:25:10 +0100
Message-ID: <m2vcccc2vd.fsf@linux-m68k.org>
References: <50C22B15.1030607@xiplink.com>
	<7vvccdhhod.fsf@alter.siamese.dyndns.org>
	<50C22F72.6010701@xiplink.com>
	<7vwqwtfzis.fsf@alter.siamese.dyndns.org> <50C24ED7.90000@xiplink.com>
	<7vsj7hfw6q.fsf@alter.siamese.dyndns.org>
	<50C25539.9010206@xiplink.com>
	<7vobi5fu3c.fsf@alter.siamese.dyndns.org>
	<7va9tpfq46.fsf_-_@alter.siamese.dyndns.org>
	<m2fw3h8oja.fsf@igel.home> <7v624dfp1e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 10:25:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThGfN-00022E-3R
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 10:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab2LHJZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2012 04:25:26 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:39748 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab2LHJZY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2012 04:25:24 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3YJQBQ2gbcz4KK3G;
	Sat,  8 Dec 2012 10:25:15 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3YJQBM1MHRzbbnj;
	Sat,  8 Dec 2012 10:25:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id zGQ-iKvl_xTF; Sat,  8 Dec 2012 10:25:14 +0100 (CET)
X-Auth-Info: sa8i88aTHPu6OK4gT1NmN4Jcq7vl7nQY7qpvs7pRllQ=
Received: from linux.local (ppp-88-217-119-49.dynamic.mnet-online.de [88.217.119.49])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat,  8 Dec 2012 10:25:14 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id 5EFB314E11A; Sat,  8 Dec 2012 10:25:11 +0100 (CET)
X-Yow: I OWN six pink HIPPOS!!
In-Reply-To: <7v624dfp1e.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 07 Dec 2012 14:58:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211209>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> +# Similarly for IFS, but some shells (e.g. FreeBSD 7.2) are buggy and
>>> +# do not equate an unset IFS with IFS with the default, so here is
>>> +# an explicit SP HT LF.
>>> +IFS=' 	
>>> +'
>>
>> Trailing whitespace can easily get lost
>
> The comment above the assingment spell the character names out for
> that exact reason.  Honestly, I think

That won't help if you don't look for it.  The loss can easily happen
while you are in a different part of the file.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
