From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: recent cygwin breakage
Date: Sun, 23 Nov 2014 23:06:44 +0000
Message-ID: <54726884.5070902@ramsay1.demon.co.uk>
References: <5470B9F9.2060008@ramsay1.demon.co.uk> <xmqqr3wtyed6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 00:07:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsgFC-0000wE-Vx
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 00:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbaKWXGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 18:06:55 -0500
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:34933 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752089AbaKWXGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 18:06:54 -0500
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 718EE6F8F4B;
	Sun, 23 Nov 2014 23:06:29 +0000 (GMT)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 2F0A66F8F4D;
	Sun, 23 Nov 2014 23:06:29 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sun, 23 Nov 2014 23:06:28 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqr3wtyed6.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260107>

On 23/11/14 18:13, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> Just a quick heads-up on a recent cygwin breakage.
>>
>> I updated my (64-bit) cygwin installation yesterday and (along
>> with many other packages) I noticed a new version of gcc (and
>> presumably libc) was installed (gcc v4.8.3-5 x86-64).
>> ...
>> However, I haven't run any tests yet. Also, I would need to check
>> this out on 32-bit cygwin (I haven't booted that laptop into Win XP
>> for quite some time!).
>>
>> Hmm, I don't really know if this is an unintended side-effect of a
>> recent change to cygwin (or a bug), but I couldn't see any mention
>> of this on the cygwin mailing list. (I don't intend to report this
>> to that mailing list; I don't want to subscribe to (yet another)
>> busy list). :(
> 
> Thanks.
> 
> I wonder if it is safe to unconditionally drop XOPEN_SOURCE; would
> it cause problems for older Cygwin to those who have not updated to
> the recent one yet?  The proposed change looks trivially correct
> otherwise.

I honestly don't know. I have never attempted to rollback an update
to cygwin. (I guess it is possible, but I really don't know how ...)

However, ...

ATB,
Ramsay Jones
