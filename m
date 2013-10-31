From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 03/16] pull: cleanup documentation
Date: Thu, 31 Oct 2013 15:15:24 -0600
Message-ID: <CAMP44s0VTfz5OpVqLbyTSSWVtOkTV5hVn0ofDcA16qDjWFfyhw@mail.gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-4-git-send-email-felipe.contreras@gmail.com>
	<xmqqiowd71kv.fsf@gitster.dls.corp.google.com>
	<CAMP44s3AKnZUJy0O0Hg+G=ER2bRn1nHMBeoJQ=ugCzO4d2WZ-g@mail.gmail.com>
	<xmqqob655kqi.fsf@gitster.dls.corp.google.com>
	<CAMP44s1-pVDoLrEC9m0J+fRCxnvMb+P0ANMxS7vzBhFub_Yv6Q@mail.gmail.com>
	<xmqqr4b1425c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 22:15:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbzaa-0008Kv-9J
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 22:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab3JaVP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 17:15:26 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:51916 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab3JaVP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 17:15:26 -0400
Received: by mail-wg0-f54.google.com with SMTP id c11so3250814wgh.21
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4VycQpGCP7hVakgAW0hj5THoue/TZBuIOZX2UmZEuS8=;
        b=qThZ4NoIxXT2HY+L937R4pTQOx79S/Yx1beV87RMImt75ra7gd9zMpYGdpjXQhxjXQ
         tnZCzQ/2tnq41+IILMMgft+duRAz2cKvkBKFpuoy8lgAIIxBhYUUNXbS48AI0kvvBgxd
         WQPoDH26bfTCpAe6QlImF1Js8JV5zRpIXCFPjfvbIDDjUKI14dcvyNnALg6b1pxajwD2
         zw5vz+QkTE/RmszP6no2R52ih2ukK4n34qF50TFyHJWncZ3LafnQ9JjRQnIkcylhRA16
         BXtptnsBKMU7vGiAB+R1K/LS+bAIYiqauN+913rvPTwERi0kv7lR6uUeMbhtJ8oRoAbR
         fYrg==
X-Received: by 10.180.99.3 with SMTP id em3mr93613wib.4.1383254124777; Thu, 31
 Oct 2013 14:15:24 -0700 (PDT)
Received: by 10.194.242.167 with HTTP; Thu, 31 Oct 2013 14:15:24 -0700 (PDT)
In-Reply-To: <xmqqr4b1425c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237184>

On Thu, Oct 31, 2013 at 2:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Oct 31, 2013 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> On Thu, Oct 31, 2013 at 12:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>>>> --- a/Documentation/git-pull.txt
>>>>>> +++ b/Documentation/git-pull.txt
>>>>>> @@ -39,7 +39,7 @@ Assume the following history exists and the current branch is
>>>>>>  "`master`":
>>>>>>
>>>>>>  ------------
>>>>>> -       A---B---C master on origin
>>>>>> +       A---B---C origin/master
>>>>>>        /
>>>>>>      D---E---F---G master
>>>>>>  ------------
>>>>>
>>>>> This change is wrong; the illustration depicts the distributed world
>>>>> (i.e. a fetch has not happened yet).
>>>>
>>>> That is an irrelevant implementation detail, specially at this high
>>>> level. In the user's mind origin/master means master on origin.
>>>
>>> You are wrong.  In the user's mind, origin/master means the commit
>>> that used to be at master on origin, and the point of this
>>> illustration is to make them understand that they live in a
>>> distributed world, where their last observation will go stale over
>>> time.
>>
>> Wrong. That would make sense in 'git fetch', but here the point of the
>> illustration is to make them understand what 'git pull' will do,
>> namely a merge.
>>
>> Which refs point to C at which points in time irrelevant information,
>> the user wants to know that 'git pull' will create a merge.
>
> Merge with what,

Merge with C.

> and how do the users know what will be merged?

They don't, not after they run 'git pull' anyway.

> The users need to learn that origin/master they were told to use
> with "git log origin/master.." etc. trails reality,

Yes, but they don't *need* to learn it *right now*. All they need to
learn is that 'git pull' will do a merge with 'master' from 'origin',
AKA 'origin/master'.

-- 
Felipe Contreras
