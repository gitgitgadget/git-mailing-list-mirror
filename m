From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Documentation: mention ORIG_HEAD in am, merge, and rebase
Date: Tue, 8 Jul 2008 15:28:22 -0400
Message-ID: <4104DCD7-23D2-436E-8599-B2EB95EBD926@silverinsanity.com>
References: <35BBB0D4-B3E1-4097-AF11-E0F6223125EA@silverinsanity.com> <1215490342-46590-1-git-send-email-benji@silverinsanity.com> <7vmykstc1h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 21:29:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGIsN-0003Yi-PX
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 21:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbYGHT2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 15:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbYGHT2Z
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 15:28:25 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:45034 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbYGHT2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 15:28:25 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 8FF3F1FFC023;
	Tue,  8 Jul 2008 19:28:17 +0000 (UTC)
In-Reply-To: <7vmykstc1h.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87790>


On Jul 8, 2008, at 3:23 PM, Junio C Hamano wrote:

> Brian Gernhardt <benji@silverinsanity.com> writes:
>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git- 
>> rebase.txt
>> index f3459c7..37382c4 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -26,7 +26,8 @@ of commits that would be shown by `git log  
>> <upstream>..HEAD`.
>>
>> The current branch is reset to <upstream>, or <newbase> if the
>> --onto option was supplied.  This has the exact same effect as
>> -`git reset --hard <upstream>` (or <newbase>).
>> +`git reset --hard <upstream>` (or <newbase>).  This includes setting
>> +ORIG_HEAD to the pre-rebase tip of the branch.
>>
>> The commits that were previously saved into the temporary area are
>> then reapplied to the current branch, one by one, in order. Note that
>
> I found the above "This includes" part very hard to understand ---  
> it took
> me three re-reads to connect "This" and "the exact same effect".  Is  
> it
> just me?

I thought it perfectly easy to understand.   ;-)  But of course, I  
wrote it.  I also wrote it immediately after reading the git-reset  
manual, which is why I phrased it that way.  On a fresh read, it's  
less obvious.

> I wonder if this is easier to understand:
>
>        The current branch is reset to <upstream>, or <newbase> if the
>        --onto option was supplied.  This has the exact same effect as
>        `git reset --hard <upstream>` (or <newbase>).  ORIG_HEAD is set
>        to point at the tip of the branch before this resetting  
> happens.

I might say "before the reset" instead of "before this resetting  
happens", as I find the latter slightly awkward.  But that's a minor nit

~~ Brian
