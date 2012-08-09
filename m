From: demerphq <demerphq@gmail.com>
Subject: Re: Sync production with Git
Date: Thu, 9 Aug 2012 06:25:29 +0200
Message-ID: <CANgJU+VLFPb8xm-qqk5m0WhzEEgtJAjq9xzcunWe5ShVLyNG=Q@mail.gmail.com>
References: <1344431484059-7564617.post@n2.nabble.com>
	<CANgJU+VNA-Rz_MqfowKjTYQWFeYdfbwJZKvQdfv+Qbu0J6YudQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: kiranpyati <kiran.pyati@infobeans.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 06:25:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzKJT-0003ej-Os
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 06:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986Ab2HIEZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 00:25:31 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44144 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797Ab2HIEZa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 00:25:30 -0400
Received: by obbuo13 with SMTP id uo13so50485obb.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 21:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=81fZ9wSx8Q7942U/KtXheEbicWlLeJ3CKXYk/AUf/RY=;
        b=YH9immAJnyqEMdR0F3CacL3Dh6guHEsvmjZHvQYO5RuwZX0f1nvuIFjo8E9jHoiwXa
         b3SqPc3JxXfww64x2djT11IqKcdiQNILOK/6xD0ijPqnReU6s0qPzAlXKlPkqC+iGvuY
         pvDUKUPRfcV8uuuJdx03pZi/s4xCiYuKrrfpgPeZGQDtP6WnumyPaqVOat+kronbVWqo
         WLfLsmxeihM/KkyasE2CzRfsJJUeA/Gpuz2GwfxH3E1bwIR/forRyE4pEAgpqxA2G9VE
         ii8g8f/3T/PPHPnFI0OItUuFJVtPYP7cUdXqPdurO41Lo4DM4Sv7/GotSDdqBbhP3TQT
         mwdQ==
Received: by 10.60.24.4 with SMTP id q4mr974522oef.50.1344486329920; Wed, 08
 Aug 2012 21:25:29 -0700 (PDT)
Received: by 10.76.87.68 with HTTP; Wed, 8 Aug 2012 21:25:29 -0700 (PDT)
In-Reply-To: <CANgJU+VNA-Rz_MqfowKjTYQWFeYdfbwJZKvQdfv+Qbu0J6YudQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203148>

On 9 August 2012 06:21, demerphq <demerphq@gmail.com> wrote:
> On 8 August 2012 15:11, kiranpyati <kiran.pyati@infobeans.com> wrote:
>> I am new to github,
>>
>> Earlier we used to manually upload files on the production through FTP
>> although git was present on the production. Due to this now git status shows
>> many modified and untrack files.
>>
>> To sync that with git we have downloaded all files from production and
>> committed to git. Now git has all files same as production.
>>
>> We have not pulled on production since last 6 months and because of this it
>> shows modified and untracked files.
>>
>> Now if we pull on the production there any 100% chances of the conflict
>> happened on all modified files. As there are hundreds of modified files
>> since last since month. Git pull will show conflict to all those files. In
>> that case site will get down and we can not afford this.
>>
>> We want a way to seamlessly sync production and Git.
>>
>> Can anybody please help me on this?
>>
>> Thanks in advance..!!
>
> Try git-deploy.
>
> https://github.com/git-deploy
>
> It contains a full work flow management for handling rollouts from git.

Better link:

https://github.com/git-deploy/git-deploy

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
