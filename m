From: Steven Michalske <smichalske@gmail.com>
Subject: Re: permissions
Date: Wed, 9 Jun 2010 03:39:24 -0700
Message-ID: <586C928F-9EB5-44C3-A4AE-814AC5E11E91@gmail.com>
References: <4C0A19FE.1020802@wpursell.net> <m27hmdn704.fsf@igel.home> <4C0A9615.4090307@wpursell.net> <AANLkTileRHwUuJpvKJbivRiM9Prn9wJ0zH6abExBgcq0@mail.gmail.com> <4C0B6C32.1090700@wpursell.net> <7vvd9wvswy.fsf@alter.siamese.dyndns.org> <4C0E1AB1.2030702@wpursell.net> <AANLkTimAmSxq8dC-4bnpLsvN3JabQeTO6pDTh9ds7D0D@mail.gmail.com> <7vtypds09x.fsf@alter.siamese.dyndns.org> <4C0EC3D0.6060509@wpursell.net> <AANLkTikGpbeP1ba0y0oUsWGQXsrL8Z-GKjybCB83W_FJ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: William Pursell <bill.pursell@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 12:39:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMIhB-0002iv-V6
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 12:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757528Ab0FIKj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 06:39:29 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56403 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475Ab0FIKj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 06:39:29 -0400
Received: by pvg16 with SMTP id 16so2411318pvg.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 03:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=x1J00xd9aDac+W/CmnOv7fs0FBXLhS0fdqkqeysTm+I=;
        b=jykQ3Qpbh7Cx7fsiHPqFUoGwciluI27tfh5xOohUaxj2Psn2hlz9Y2jxPp+kb52CDr
         Kh97RLjFYcYq8Qs7whr7iTmiFrzQi2Ofn7KkKaTrm8HUoqUDU4GEboZdQ9PT2hx+7IVv
         EUvWTtQ0SRTkv3RNJTpXI8sKMz7SVliyaT+Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=KiAkGqhvR5pGtMjMtGkiy/2oneNy2rKL9J8+33dyTgSSOn8zh7q0w6RBF0tV4OMJry
         670rBu2XAffpLJD7nuOCASgLbDZKgXnim52yE1/io6KFxuC2HyWz3XnmM0McmwMvSbNk
         eIdGkpYpCcs2dpHZ9pcnI5vIZX+Fo14OdoTLY=
Received: by 10.114.214.33 with SMTP id m33mr2455613wag.107.1276079967946;
        Wed, 09 Jun 2010 03:39:27 -0700 (PDT)
Received: from [192.168.1.105] (c-98-234-104-87.hsd1.ca.comcast.net [98.234.104.87])
        by mx.google.com with ESMTPS id d16sm62686246wam.12.2010.06.09.03.39.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Jun 2010 03:39:26 -0700 (PDT)
In-Reply-To: <AANLkTikGpbeP1ba0y0oUsWGQXsrL8Z-GKjybCB83W_FJ@mail.gmail.com>
X-Mailer: Apple Mail (2.1068)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148761>


On Jun 9, 2010, at 12:20 AM, Alex Riesen wrote:

> On Wed, Jun 9, 2010 at 00:27, William Pursell  
> <bill.pursell@gmail.com> wrote:
>> Junio C Hamano wrote:
>>> Alex Riesen <raa.lkml@gmail.com> writes:
>>>
>>>> On Tue, Jun 8, 2010 at 12:25, William Pursell <bill.pursell@gmail.com 
>>>> > wrote:
>>>>> Here's a patch.  This doesn't address the issue of a damaged
>>>>> repository, but just catches access errors and permissions.
>>>> The change looks fishy.
>>>>
>>>> The patch moves the function is_git_directory at the level of user
>>>> interface where it wasn't before: it now complains and die.
>>>> Not all callers of the function call it only to die if it fails.
>>>
>>> Thanks for shooting it down before I had to look at it ;-)
>>
>> The point of the patch is that it now complains and dies.
>
> At wrong point. Points, actually. There are many callers of the
> function you modified. You should have looked at them all.
>
Should the other functions not fail in this case?  Looking at the uses  
3 in setup.c and not exported for use in other code.  Only once case  
looked like it could cause an issue would be if the file did not  
exist, and he excluded that case, lines 408 and 409 of setup.c  Where  
the environment variable is passed into the function.

Well that's a good question,  William made a valid assumption that if  
you were checking a directory  that is suspected to be a git directory  
and it couldn't be read you should let the user know that something is  
funky.  Now this looks like the right place for catching that access  
violation, but it looks like it night not the right place to report  
the error.....

So return another error code for catching it up stream.  But, we can't  
because this function can be true many ways and false only one.  This  
is where the shell convention that 0 is ok and errors are not 0 really  
shines, but doesn't work for the name of this function.



>> Perhaps I'm being obtuse, but can you describe a situation
>> in which this causes git to terminate inappropriately?
>
> Maybe. BTW, can you? (if you try, I mean). But your questions
> misses the point of my complaint about your patch:
>
And this point was not clearly explained on your part.... I had to  
read your complaint a few times to understand what you meant.

Something mentioned this way might have been more insightful.
The patch should pass error up to calling function and not terminate  
in the function.

And offer a suggestion of how you would prefer it to be implemented.

> The patch makes the function you modified act not as one
> can guess from its other uses. Imagine someone replaced
> open(2) implementation to kill your program everytime you
> tried to open /etc/passwd. How'd you like that?
>
Your analogy is subtly off.

Because if you tried to open /etc/passwd and could not open it for  
reading your application should fail.  That works because open allows  
for the return of an error code, but is_git_directory does not, so  
patching at the level that will correctly detect this erroneous case  
is difficult to report upstream.

> That alone is reason enough to dislike the change and put
> you personally into a list of persons to be careful with (as
> you don't seem to care about what happens with the code
> after you changed it).

Honestly it is not, he was asking what he did wrong, and probably  
didn't follow your line of reasoning.

Steve
