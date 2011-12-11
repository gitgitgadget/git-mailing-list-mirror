From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Sun, 11 Dec 2011 21:30:20 +0100
Message-ID: <m2d3bu7swz.fsf@igel.home>
References: <jbvj5o$skt$1@dough.gmane.org>
	<20111211022218.GA22749@sita-lt.atc.tcs.com>
	<jc2l2a$som$1@dough.gmane.org> <m3ehwbge8f.fsf@localhost.localdomain>
	<4EE50B5A.3000706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 11 21:30:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZq2W-0002qC-Ea
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 21:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab1LKUaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 15:30:23 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:38124 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab1LKUaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 15:30:22 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id A0B63188B588;
	Sun, 11 Dec 2011 21:30:20 +0100 (CET)
X-Auth-Info: XbhFIVllVcjO1qoRbvBpgR82tv54S+l27KT+z6dU8Eo=
Received: from igel.home (ppp-88-217-99-15.dynamic.mnet-online.de [88.217.99.15])
	by mail.mnet-online.de (Postfix) with ESMTPA id 1190F1C00056;
	Sun, 11 Dec 2011 21:30:21 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 83AF5CA29C; Sun, 11 Dec 2011 21:30:20 +0100 (CET)
X-Yow: I'm working under the direct orders of WAYNE NEWTON to deport
 consenting adults!
In-Reply-To: <4EE50B5A.3000706@gmail.com> (Gelonida N.'s message of "Sun, 11
	Dec 2011 20:58:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186814>

Gelonida N <gelonida@gmail.com> writes:

> On 12/11/2011 07:22 PM, Jakub Narebski wrote:
>> You can use 'upstream' field name in git-for-each-ref invocation,
>> for example
>> 
>>   git for-each-ref '--format=%(refname:short) %(upstream:short)' refs/heads |
>>   	grep -e ' [^ ]' |
>>   	sed  -e 's/ .*$//
>>  
> Thanks
>
>
>
>> This could probably be done using only sed -- grep is not necessary.
> I think the equivalent would be:
> sed '/ [^ ]/ s/ .*$//'

You need to suppress printing the non-matching lines.

  sed -n '/ [^ ]/ s/ .*$//p'

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
