From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH 1/3] command-list.txt: group common commands by theme
Date: Fri, 08 May 2015 20:43:21 +0200
Message-ID: <554D03C9.9030406@gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>	<b89d3fec640cb6fb01aa32ad50bae4e064528220.1430770308.git.sebastien.guimmara@gmail.com>	<CAPig+cTHQikgOvPrjxikUNjQoWCv2hdubJ55OG0SqpGUs_3Pow@mail.gmail.com>	<554A8084.10506@gmail.com> <CAPig+cQ2e4c5hYsRbZhgyvLcMPsqshqRUZGNLwhJd57YP9JEFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Eric Sunshine <sunshine@sunshineco.com>,
	Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 08 20:43:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqnFB-0005vV-6c
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 20:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbbEHSn1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 14:43:27 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33718 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbbEHSnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 14:43:25 -0400
Received: by wgin8 with SMTP id n8so80285508wgi.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=M1eUFSnrqWQ4d7Q4W8M83A6ja/ZVq0+MewiiWR64Fxw=;
        b=ta9qPXsSBUTHi7QFRQQkc6k9s8rX1nIWz0sXXvAVorIUS1jo52Gs5Kbd2thgU80tmL
         fjuGNJaQHqCxaFkMWz67XDyiyTqUSzLa7asoiJ9tfJ5flXjerQwBIJQsUmQT1i1AYhiZ
         vqSctoRTVlh8E05Evo7XN98ku6OhGxWXY93p3xTmPmHA/eDOrKsKFyJixQP6TLQhdq2E
         TiFo6sswwxC4cCDnAgyuu+hrVJpCA1XNDgBQ8jcZCWhKorHpxk7coyd7+Sayyi/ARTFk
         F7ifrETo8YgUFBsAXa7+6CE+E/4kP24eeSK0FKIiGK2h9Lw+6lt2FY9+/68zYzdye4Pu
         mDbw==
X-Received: by 10.180.90.236 with SMTP id bz12mr354955wib.33.1431110604059;
        Fri, 08 May 2015 11:43:24 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id e2sm31893wix.15.2015.05.08.11.43.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 11:43:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cQ2e4c5hYsRbZhgyvLcMPsqshqRUZGNLwhJd57YP9JEFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268642>

On 05/07/2015 06:50 PM, Eric Sunshine wrote:
> On Wed, May 6, 2015 at 4:58 PM, S=C3=A9bastien Guimmara
> <sebastien.guimmara@gmail.com> wrote:
>> On 05/06/2015 08:57 AM, Eric Sunshine wrote:
>>> On Mon, May 4, 2015 at 4:28 PM, S=C3=A9bastien Guimmara
>>> <sebastien.guimmara@gmail.com> wrote:
>>>> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.c=
om>
>>>> ---
>>>> diff --git a/command-list.txt b/command-list.txt
>>>> index f1eae08..64394ca 100644
>>>> --- a/command-list.txt
>>>> +++ b/command-list.txt
>>>> @@ -1,29 +1,39 @@
>>>>    # List of known git commands.
>>>> -# command name                         category [deprecated] [com=
mon]
>>>> -git-add                                 mainporcelain common
>>>> +# only add group information for common commands
>>>
>>> Perhaps mention also that the order of groups here is the order in
>>> which they are output by 'git help'?
>>
>> It wouldn't be necessary if we reorder alphabetically the content of
>> each group, no ?
>
> I'm not sure to what you are referring here? (Perhaps my comment was
> unclear, or perhaps I'm misreading your response.)
>

I was mistaken, I thought you wanted to reorder the commands
alphabetically, which was unnecessary since they were sorted in
help.c anyway. But yes, I shall add a comment in command-list.txt

> I meant only that the comment above [groups] should say that the orde=
r
> of the items in [groups] is the order in which the groups themselves
> are output by "git help".
>
>>>> +[groups]
>>>
>>> Thinking on this a bit more, perhaps [groups] is too generic. Maybe
>>> [common] or [commongroups] would be more descriptive?
>>>
>>>> +init                   starting a working area
>>>> +worktree               working on the current change
>>>> +remote                 working with others
>>>
>>> "collaborating with others" perhaps?
>>
>> Yes, "groups" has been itching a bit. I thought about "theme", but
>> common just does the job too. "collaborating with others" sounds
>> redundant to me (but I'm being a grammar nazi here).
>
> I also think "collaborating" itself is best, but changed it at the
> last second before sending the email.
>
>>>> -git-fast-export                                ancillarymanipulat=
ors
>>>> -git-fast-import                                ancillarymanipulat=
ors
>>>> -git-fetch                               mainporcelain common
>>>> +git-fast-export                         ancillarymanipulators
>>>> +git-fast-import                         ancillarymanipulators
>>>
>>> Unintended whitespace changes for fast-export and fast-import lines=
? I
>>> wouldn't have expected to see these lines change in this patch.
>>
>> All whitespace changes were intended to align the commands on the sa=
me
>> column. I realize this should be the object of a separate patch.
>
> Strange. In my editor, all columns are already aligned. Perhaps your
> tab with setting is incorrect? (It should be set to 8.)
>

Actually I only removed the few tabs that were wandering in some lines
to replace them by spaces (almost all lines were space aligned, only a =
few
were tab aligned).

>>>> -git-grep                                mainporcelain common
>>>> +git-grep                                mainporcelain
>>>
>>> This change isn't mentioned anywhere, not even in the cover letter.
>>> Did you intend to drop 'grep' from the common command list?
>>
>> It's a mistake in the cover letter. I indeed intended to propose to
>> remove grep and tag from the common commands.
>
> I personally consider "grep" an important beginner command, but that'=
s
> an issue to be argued separately; and it's also why it's a good idea
> to put the removals in their own patch, so people can argue about it
> without holding up the rest of the patches.
>
>>>>    [...]
>>>> -git-write-tree                          plumbingmanipulators
>>>> +git-write-tree                          plumbingmanipulators
>>>> \ No newline at end of file
>>>
>>> Your editor is perhaps dropping the final newline in the file? This=
 is
>>> an undesirable change. Patch 2/3 exhibits the same problem.
>>
>> As for the final newline, it was deliberately removed. I was not awa=
re it
>> was necessary in text files. I'll correct this.
>
> Historically, many Unix tools incorrectly handled files lacking that
> final newline; sometimes by dropping the line altogether, sometimes
> mis-processing it in some way or another. Misbehaviors still exist
> today, often in BSD tools. In fact, just a few days ago, such a
> problem was reported for git-filter-branch[1]. Consequently, retainin=
g
> newline is good insurance against misbehaving tools.
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/267828/fo=
cus=3D267957
>
