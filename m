From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2] log-tree: use custom line terminator in line termination mode
Date: Tue, 01 May 2012 09:29:54 +0200
Message-ID: <m2mx5snytp.fsf@linux-m68k.org>
References: <7vaa1tf1w8.fsf@alter.siamese.dyndns.org>
	<1335817705-24718-1-git-send-email-jk@jk.gs>
	<7vd36oesjr.fsf@alter.siamese.dyndns.org> <m2ehr4sq1q.fsf@igel.home>
	<7v62cgenn4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 09:30:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP7XL-0005JC-In
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 09:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab2EAHaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 03:30:06 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54668 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab2EAHaF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 03:30:05 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VhZ5M3MTHz4LDf8;
	Tue,  1 May 2012 09:29:59 +0200 (CEST)
Received: from linux.local (ppp-88-217-105-159.dynamic.mnet-online.de [88.217.105.159])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VhZ5M2Hlfz4KK34;
	Tue,  1 May 2012 09:29:59 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id B51881E560C; Tue,  1 May 2012 09:29:55 +0200 (CEST)
X-Yow: This TOPS OFF my partygoing experience!  Someone I DON'T LIKE
 is talking to me about a HEART-WARMING European film..
In-Reply-To: <7v62cgenn4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 30 Apr 2012 17:43:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196665>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Having said that, are we sure that
>>>
>>> 	printf "add bar\0initial"
>>>
>>> works per specification, or merely works by accident in some
>>> implementation?
>>
>> Since the backslash is not followed by $ ` " \ <newline> it is not
>> special to the shell.
>
> Yeah, but I wasn't worried about what shell does in the first place. I was
> worried about what printf(1) does.

Oh, I was confused becaused you mentioned the C case where the \NNN
interpretation is done by the compiler, not printf(3).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
