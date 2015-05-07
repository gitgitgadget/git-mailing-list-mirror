From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] command-list.txt: group common commands by theme
Date: Thu, 7 May 2015 12:50:29 -0400
Message-ID: <CAPig+cQ2e4c5hYsRbZhgyvLcMPsqshqRUZGNLwhJd57YP9JEFA@mail.gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<b89d3fec640cb6fb01aa32ad50bae4e064528220.1430770308.git.sebastien.guimmara@gmail.com>
	<CAPig+cTHQikgOvPrjxikUNjQoWCv2hdubJ55OG0SqpGUs_3Pow@mail.gmail.com>
	<554A8084.10506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 18:50:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqP0N-00043y-TD
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbbEGQub convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2015 12:50:31 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33193 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbEGQua convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2015 12:50:30 -0400
Received: by iepj10 with SMTP id j10so40970765iep.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=6s4EkdR4UIZvnh/h6AaOXqRRqPtaDf6Oj3v5/6zma5s=;
        b=Hmush4vgZyZ126p2708pk0+rz9aW3IhWj2qGXedTn+L/H6lhH1FTiByWP8ihM0hpU1
         /kirO1zo/J61qcFzc07D7mi0IXiJ98qZLjP78raGMeojN7XmdDYjayGZ22hZr42MbrRx
         9Q4rSw7frmoxT6an5kTQ/4+iX8QSWnuQY58WCwqKGbkgWfoBdQca+XW1UnHuJ2ZH3pYI
         QYGwdFNpaUxu205y713+S+rfN/kkD0kgRq07O4EUcOmGG8jSTT5fJKr4O/PBfPna1PD+
         uKJEa4u2Mc9hqfMJnxPIM5suHmvCS8U6Fi2y9tCxdlwnVs3pxtHHiE1oOnF4NS8jE3Us
         KREQ==
X-Received: by 10.50.43.227 with SMTP id z3mr15886539igl.22.1431017429814;
 Thu, 07 May 2015 09:50:29 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 7 May 2015 09:50:29 -0700 (PDT)
In-Reply-To: <554A8084.10506@gmail.com>
X-Google-Sender-Auth: 0BbiDwp1aJTARNJjGeqwIlbVG64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268549>

On Wed, May 6, 2015 at 4:58 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> On 05/06/2015 08:57 AM, Eric Sunshine wrote:
>> On Mon, May 4, 2015 at 4:28 PM, S=C3=A9bastien Guimmara
>> <sebastien.guimmara@gmail.com> wrote:
>>> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.co=
m>
>>> ---
>>> diff --git a/command-list.txt b/command-list.txt
>>> index f1eae08..64394ca 100644
>>> --- a/command-list.txt
>>> +++ b/command-list.txt
>>> @@ -1,29 +1,39 @@
>>>   # List of known git commands.
>>> -# command name                         category [deprecated] [comm=
on]
>>> -git-add                                 mainporcelain common
>>> +# only add group information for common commands
>>
>> Perhaps mention also that the order of groups here is the order in
>> which they are output by 'git help'?
>
> It wouldn't be necessary if we reorder alphabetically the content of
> each group, no ?

I'm not sure to what you are referring here? (Perhaps my comment was
unclear, or perhaps I'm misreading your response.)

I meant only that the comment above [groups] should say that the order
of the items in [groups] is the order in which the groups themselves
are output by "git help".

>>> +[groups]
>>
>> Thinking on this a bit more, perhaps [groups] is too generic. Maybe
>> [common] or [commongroups] would be more descriptive?
>>
>>> +init                   starting a working area
>>> +worktree               working on the current change
>>> +remote                 working with others
>>
>> "collaborating with others" perhaps?
>
> Yes, "groups" has been itching a bit. I thought about "theme", but
> common just does the job too. "collaborating with others" sounds
> redundant to me (but I'm being a grammar nazi here).

I also think "collaborating" itself is best, but changed it at the
last second before sending the email.

>>> -git-fast-export                                ancillarymanipulato=
rs
>>> -git-fast-import                                ancillarymanipulato=
rs
>>> -git-fetch                               mainporcelain common
>>> +git-fast-export                         ancillarymanipulators
>>> +git-fast-import                         ancillarymanipulators
>>
>> Unintended whitespace changes for fast-export and fast-import lines?=
 I
>> wouldn't have expected to see these lines change in this patch.
>
> All whitespace changes were intended to align the commands on the sam=
e
> column. I realize this should be the object of a separate patch.

Strange. In my editor, all columns are already aligned. Perhaps your
tab with setting is incorrect? (It should be set to 8.)

>>> -git-grep                                mainporcelain common
>>> +git-grep                                mainporcelain
>>
>> This change isn't mentioned anywhere, not even in the cover letter.
>> Did you intend to drop 'grep' from the common command list?
>
> It's a mistake in the cover letter. I indeed intended to propose to
> remove grep and tag from the common commands.

I personally consider "grep" an important beginner command, but that's
an issue to be argued separately; and it's also why it's a good idea
to put the removals in their own patch, so people can argue about it
without holding up the rest of the patches.

>>>   [...]
>>> -git-write-tree                          plumbingmanipulators
>>> +git-write-tree                          plumbingmanipulators
>>> \ No newline at end of file
>>
>> Your editor is perhaps dropping the final newline in the file? This =
is
>> an undesirable change. Patch 2/3 exhibits the same problem.
>
> As for the final newline, it was deliberately removed. I was not awar=
e it
> was necessary in text files. I'll correct this.

Historically, many Unix tools incorrectly handled files lacking that
final newline; sometimes by dropping the line altogether, sometimes
mis-processing it in some way or another. Misbehaviors still exist
today, often in BSD tools. In fact, just a few days ago, such a
problem was reported for git-filter-branch[1]. Consequently, retaining
newline is good insurance against misbehaving tools.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/267828/focu=
s=3D267957
