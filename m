Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C436F1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 08:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfBAIDC (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 03:03:02 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:40600 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfBAIDB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 03:03:01 -0500
Received: by mail-it1-f174.google.com with SMTP id h193so8516184ita.5
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 00:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ifzTaaNi2+AWUXX0d1bVqLxN0g+bcuiFjfvvVxq0F4g=;
        b=QxxQXAMG5YUcSPSmbwh+TSWcZn0PsM0h5UOcs+WQOtZ0JjQA6ubJR3cTmMpLJmWou2
         HU2ozrGgFKaTmeln7iofYSforEK7MIgaux9EeH3TxSyMgH63nJhWDj23CpbMJ6TpU8am
         o6HkJcr+yLQ/Z/VT+V36v6chwX108zFVxaufYqOk2LS1PlyX14gH9IIZ574/pEEVVsc4
         +OjxpgNpSIoVfhPRPvVvCVw0THphI9DJ4d0/ttkx6mrln3ONxIP/BXgqALGxrZsx+9wA
         wx2/TM5V8AyOz3/FeWizcQJEOutnE7JP3yhAdwE4DkjrOJPieZWfTGvhVdw+h83R8fkz
         B6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ifzTaaNi2+AWUXX0d1bVqLxN0g+bcuiFjfvvVxq0F4g=;
        b=nO/78qiEz+k6Y/MPuEsE3KJL3mQoyOC0tw1GI36zsJcKqCHS7+bGsk7hdWK0J+qnsN
         vkdmH4HoIEoXZGiGL53jFutnigVnetVPaEOBAsYb79izCqUT1mgau6d94/PZwaku1iNr
         SpQ6HV9qtWszmQTkj2LuKp8amuJlbhD22T6U3W/MD8O+s4UAehGmI1mH09FmtbhiU2eD
         Im5N7WRcySJ37PRXgedYUW8KBIS+/ZYI/zc7R7ruSUkFsuA8rKeGxzuECJg9bTxPyhSR
         ygfqu1mtXFG9nZiY3YrgfR6PRfY4SO4L9ZNsoU/bMCyC/7ZOToDPQdAElHwblgpwA52T
         SnZw==
X-Gm-Message-State: AHQUAuZOSrgjKmVIoHzhuDjJFDdtgsGfGtZ/x/jSTyxRHSiSMAetitLU
        5lWGHQdeA7jIh967+2Ce4QGFeX3I0wb+TGjTAUSFFPTB
X-Google-Smtp-Source: AHgI3IbPNdZmFCDj7m4uGejJmu8/J3zrwFLpLykmWLh94NOovcYAhXpJ8Txehj1Y8BKXVQZc26D7ubTWEtKqwkk049M=
X-Received: by 2002:a24:af07:: with SMTP id t7mr581325ite.168.1549008180456;
 Fri, 01 Feb 2019 00:03:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHYHVP+ty7i7a_abT-th_HR2X-8X6mLmpHPR_3VXv5LpWUsrhQ@mail.gmail.com>
 <CAHYHVP+Dvbq_aOMy1_Kq0LHJsd4r+4GiP3N3R4A9ouAoJ4gw9g@mail.gmail.com> <20190131203447.aovalz2vzsjpdjdv@tb-raspi4>
In-Reply-To: <20190131203447.aovalz2vzsjpdjdv@tb-raspi4>
From:   Angelo Melonas <angelomelonas@gmail.com>
Date:   Fri, 1 Feb 2019 10:02:50 +0200
Message-ID: <CAHYHVPJdbEOPaAoyAhOtJ+wkeXZdowAVqe1Tp_=LOKzuuzA+wQ@mail.gmail.com>
Subject: Re: Possible minor bug in Git
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Torsten,

Thank you so much for getting back to me.

Unfortunately, I believe there is a misunderstanding, as I may have
explained what I found to be a possible bug incorrectly.
The file that is originally added (and then later modified) is never
renamed or moved.
As you will see below, when a user attempts to add a file, but with
the incorrect case, the Git CLI responds the same way it would if a
file was correctly added (i.e., by displaying nothing).
However, in the above case, when you enter "git status", you find that
the file was never actually added, and remains unstaged.
A possible solution to this can be a simple error message similar to
attempting to add a file with its name misspelt.

Using your example, I have illustrated this in the text below:

    C:\Example>git init
    Initialized empty Git repository in C:/Example/.git/

    C:\Example>echo AAA > AA.txt

    C:\Example>git add AA.txt

    C:\Example>git commit -m AA.txt
    [master (root-commit) d550af0] AA.txt
     1 file changed, 1 insertion(+)
     create mode 100644 AA.txt

    C:\Example>echo BB > AA.txt

    C:\Example>git status
    On branch master
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working direct=
ory)

            modified:   AA.txt

    no changes added to commit (use "git add" and/or "git commit -a")

    C:\Example>git add Aa.txt

    C:\Example>git status
    On branch master
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git checkout -- <file>..." to discard changes in working direct=
ory)

            modified:   AA.txt

    no changes added to commit (use "git add" and/or "git commit -a")

    C:\Example>git add A.txt
    fatal: pathspec 'A.txt' did not match any files

    C:\Example>git add AA.txt

    C:\Example>git status
    On branch master
    Changes to be committed:
      (use "git reset HEAD <file>..." to unstage)

            modified:   AA.txt

I am looking forward to hearing from you again.

Kind regards,
Angelo Melonas

On Thu, Jan 31, 2019 at 10:34 PM Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>
> On Thu, Jan 31, 2019 at 09:29:28AM +0200, Angelo Melonas wrote:
> > Just to clarify, I made a mistake above. Instead of "untracked", I
> > meant "unstaged".
> > I apologise for the confusion.
> >
> > On Thu, Jan 31, 2019 at 9:01 AM Angelo Melonas <angelomelonas@gmail.com=
> wrote:
> > >
> > > Good day,
> > >
> > > I found a potential bug in Git for Windows. The bug can be reproduced
> > > as follows:
> > >
> > > 1. Modify a file so that it shows up as "untracked" when executing th=
e
> > > "git status" command.
> > > 2. Attempt to "git add" the file, but change the case of a single
> > > letter. The command executes but no warning or error is displayed.
> > > 3. Execute "git status" again and it still shows the file as "untrack=
ed".
> > >
> > > Please let me know if I am mistaken. I also have a screenshot
> > > demonstrating the "bug" which I cannot attach to this email, but whic=
h
> > > can be requested.
> > >
> > > Have a great day.
> > >
> > > Kind regards,
> > > Angelo Melonas
>
> See the example below, Git tracks AA.txt, so you must run
> git add AA.txt
>
> After a commit, you can tell Git that the file was renamed:
> git mv AA.txt Aa.txt
> (and then a commit)
>
>
>
> ------------------------------
>
> user@mac:/tmp/tt2> git init
> Initialized empty Git repository in /private/tmp/tt2/.git/
> user@mac:/tmp/tt2> echo AAA > AA.txt
> user@mac:/tmp/tt2> git add AA.txt
> user@mac:/tmp/tt2> git commit -m AA.txt
> [master (root-commit) f102760] AA.txt
>  1 file changed, 1 insertion(+)
>   create mode 100644 AA.txt
>   user@mac:/tmp/tt2> echo BB >AA.txt
>   user@mac:/tmp/tt2> mv AA.txt  Aa.txt
>   user@mac:/tmp/tt2> git status
>   On branch master
>   Changes not staged for commit:
>     (use "git add <file>..." to update what will be committed)
>       (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
>
>         modified:   AA.txt
>
> no changes added to commit (use "git add" and/or "git commit -a")
> user@mac:/tmp/tt2> git add AA.txt
> user@mac:/tmp/tt2> git status
> On branch master
> Changes to be committed:
>   (use "git reset HEAD <file>..." to unstage)
>
>         modified:   AA.txt
>
> user@mac:/tmp/tt2>
