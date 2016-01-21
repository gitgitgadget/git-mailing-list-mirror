From: Lars Vogel <lars.vogel@vogella.com>
Subject: Re: [PATCH] Consistent usage of working tree in the git-add help
Date: Thu, 21 Jan 2016 10:56:18 +0100
Message-ID: <CACA4a_FtcJEPPEKDRqHFn_vtnPQfcFqN9uPChug=Fwh8B5bM3Q@mail.gmail.com>
References: <1453229636-16269-1-git-send-email-Lars.Vogel@vogella.com>
	<xmqqr3hb22zu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Vogel <lars.vogel@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 10:57:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMBz1-0004n7-J9
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 10:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759335AbcAUJ4l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jan 2016 04:56:41 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38217 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759280AbcAUJ4U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2016 04:56:20 -0500
Received: by mail-wm0-f41.google.com with SMTP id b14so71479356wmb.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 01:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vogella-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Rc4xTOp+8slTZ3bA9L4L6rfRh2g52Gp4BF/D7IrJkTc=;
        b=YTrP2nBKfRJ5h9tbqFb4aNRy2PN6BfjoFey4v3xOvzVWHWaNPZjt5+1zHYgturZIku
         pJOHchS97gl3r7W4TykmdBWyCfm2bhFR67sUvioxur7dxnUsbDbFEhbdTQhIX4qUTLHl
         Cx8NzdTSPdbBRUfz3/HB/37ha/H0FQ6Y+Idhn3nyJfy/oMVUxkO9Jt+xIU7Ctze5qgl2
         rTRcR+vL/sMx/wnq9zUJhDdZX9maCp0egRPA2zj1uiUHzJfT3M+P1ex2FtaE25pGZ99t
         iNPO8lc/kOy9V9mCUetjkOsJOoa32DlstlHzUPkDBwYzWHSpW8p/ohVEkP2t7Uni/+iw
         QBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Rc4xTOp+8slTZ3bA9L4L6rfRh2g52Gp4BF/D7IrJkTc=;
        b=G83VgIwQtE/rkOaJxMfAlVZo41r6Rr7Z+SccHBdKXveVLo7q4CFELuoehQMfwNh/5j
         8zN1gkNNs1Qg7jLc2GETCos6l70wZSGC/v1V2wDJst8L3+CZ+jAHcCoFdc0Gnk7RDfex
         cE7r+TF3tJ3p8rplyvB7/KRae7LZhR17Gc9+MDR9KmM2L34uESUjilgG6KxWIawccFTv
         ibxGCX6VXjOt4hLIAUT3G5cdTWfdvTSiNsXR55XXsQDd9dVC/EUcO/bkUFUMSjCSmSFF
         b2voOhCcnN4tpTf0ttwba54MAGueOc5NYAJODlGxpMrSwlb73C4E5B0/J/F4LVpToeek
         conA==
X-Gm-Message-State: AG10YOS/E4Zjd7nNEPJQvAK8KNCM+wBd14FvYvQ0+wKyxOolWk0TtfPu813eAb0U7FnvLyxl1urB1TILgBILVg==
X-Received: by 10.28.195.138 with SMTP id t132mr8861134wmf.61.1453370178910;
 Thu, 21 Jan 2016 01:56:18 -0800 (PST)
Received: by 10.28.216.73 with HTTP; Thu, 21 Jan 2016 01:56:18 -0800 (PST)
In-Reply-To: <xmqqr3hb22zu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284509>

Thanks Junio for the feedback. I send a new patch with only the first c=
hange.

On Thu, Jan 21, 2016 at 1:24 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Lars Vogel <lars.vogel@gmail.com> writes:
>
>> The usage of working directory is inconsistent in the git add help.
>> Also http://git-scm.com/docs/giit-clone speaks only about working tr=
ee.
>> Remaining entry found by "git grep -B1 '^directory' git-add.txt" rea=
lly
>> relates to a directory.
>>
>> Signed-off-by: Lars Vogel <Lars.Vogel@vogella.com>
>> ---
>>  Documentation/git-add.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
>> index fe5282f..cfef77b 100644
>> --- a/Documentation/git-add.txt
>> +++ b/Documentation/git-add.txt
>> @@ -24,7 +24,7 @@ remove paths that do not exist in the working tree=
 anymore.
>>
>>  The "index" holds a snapshot of the content of the working tree, an=
d it
>>  is this snapshot that is taken as the contents of the next commit. =
 Thus
>> -after making any changes to the working directory, and before runni=
ng
>> +after making any changes to the working tree, and before running
>>  the commit command, you must use the `add` command to add any new o=
r
>>  modified files to the index.
>>
>> @@ -85,7 +85,7 @@ OPTIONS
>>  -p::
>>  --patch::
>>       Interactively choose hunks of patch between the index and the
>> -     work tree and add them to the index. This gives the user a cha=
nce
>> +     working tree and add them to the index. This gives the user a =
chance
>>       to review the difference before adding modified contents to th=
e
>>       index.
>>  +
>
> Thanks.  While the first hunk looks to me a definite improvement, I
> am lukewarm about s/work tree/working tree/ change.  Both terms are
> used fairly commonly in our documentation set.  "Work tree" has ~70
> hits vs ~350 for "working tree" (ignoring the case where these words
> are split across lines, i.e. "work/working" at the end of the line
> followed by a line that begins with "tree").



--=20
Eclipse Platform UI and e4 project co-lead
CEO vogella GmbH

Haindaalwisch 17a, 22395 Hamburg
Amtsgericht Hamburg: HRB 127058
Gesch=C3=A4ftsf=C3=BChrer: Lars Vogel, Jennifer Nerlich de Vogel
USt-IdNr.: DE284122352
=46ax (040) 5247 6322, Email: lars.vogel@vogella.com, Web: http://www.v=
ogella.com
