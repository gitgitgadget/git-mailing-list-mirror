Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 651061F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 04:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbfJ2EsC (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 00:48:02 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:33669 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfJ2EsB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 00:48:01 -0400
Received: by mail-pf1-f173.google.com with SMTP id c184so8653912pfb.0
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 21:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=7l3fPMv2Np2/4BhB72cHanpfT8Q8YQfArTQP8kYsKtI=;
        b=DrglYBIeK4glsYaje2ZFrm9lTDWs1y7uXKkFLdZ0HfrjUOCsc8h559r9v8+eRDfdG4
         uSPdReCX90YCfenZQX9ptdKkzZ31aBaX3/URIl9JVZ+tZ1ZAwQC/q7XMnIEmnLXVa+Uo
         ElxF6DxGIHaAxRhJ2pc1/tozCgwzKxoEbsJUHmamEcyqvkCbFg6ka7hdkaDRnkHyKmTY
         uvUt3KEqTRIdlW56rLqCLV23swzTXQqUnEDTgH2YFPoHJKcHphvW0eih4bQIeUjwIAWm
         Bt7WXHCamXtNhLXoj2Mu4LOjp0UB8qVxkEw9qZQfwUoO5Q9NTEGxPZ8EKaNIkfXDunDw
         Bdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=7l3fPMv2Np2/4BhB72cHanpfT8Q8YQfArTQP8kYsKtI=;
        b=ezXm/Vw1dZ0qONMjOnTd8SNoV1E9MwpufOvcju9Ds/rH0fNG+CnnmcpNxQE60VlAaW
         3fn3QB/yLxweVMJatDrR4lyhOB2THzaZqqAhP0dOBpmimpdXgu4CPW6Bo0M2XFXzp0ts
         ojBxTYbgY/sVMzZcQaac0eP8QnaCcpl6yzbKA45ThPsVWqBpMeY3R5A7OfNYAyYmc6nf
         IZgJo/XvlOA6vnXjV+Z4x9pQtpnMHDu6pPgNewgSgD54h3ocm/CMRcBJoKv5iYcpIhlH
         KGn0EMFsiZ/zgiq2dWmBm/P0peIoFz/2VTvSA1hOdzkX7dArwVhQabjMyogh/2CeGFEM
         9y2g==
X-Gm-Message-State: APjAAAXW2CCQQTjV88tVO2ndxP7B3n7TvwFnq0pyrCY7BLkgvpsApu51
        GyPqNOwMlkye4bpeei9rWiGs+SY3
X-Google-Smtp-Source: APXvYqyOsTB60EUQu6n9DlvdrVpHjRR3upvMi9nlYTD+w/oSUl1Whkrfu6dP7dkQwPfJIUHP6q9sXg==
X-Received: by 2002:aa7:8421:: with SMTP id q1mr25107855pfn.174.1572324479075;
        Mon, 28 Oct 2019 21:47:59 -0700 (PDT)
Received: from LJZDELLPC ([184.103.122.48])
        by smtp.gmail.com with ESMTPSA id p1sm12403753pfb.112.2019.10.28.21.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 21:47:58 -0700 (PDT)
From:   <lyle.ziegelmiller@gmail.com>
To:     "'Philip Oakley'" <philipoakley@iee.email>,
        "'git bug report'" <git@vger.kernel.org>
References: <004101d58d24$4daab5b0$e9002110$@gmail.com> <91e5f3d8-d2cf-363c-2407-4b4dfb75e5a8@iee.email>
In-Reply-To: <91e5f3d8-d2cf-363c-2407-4b4dfb75e5a8@iee.email>
Subject: RE: unpacking error
Date:   Mon, 28 Oct 2019 21:47:53 -0700
Message-ID: <005501d58e14$07504990$15f0dcb0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG1h2GfhZDeVN3ik89S7UEhF7jkegHN4Q6Up6KnSLA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


From: Philip Oakley <philipoakley@iee.email>=20
Sent: Monday, October 28, 2019 3:14 AM
To: lyle.ziegelmiller@gmail.com; 'git bug report' <git@vger.kernel.org>
Subject: Re: unpacking error

Hi Philip.

Thanks for writing back. Please see below.

Regards

Lyle=20

On 28/10/2019 00:11, lyle.ziegelmiller@gmail.com wrote:
> Hi
>
> I almost always get this error when pushing from my PC to the bare=20
> repository on my laptop. I'm running Cygwin on Windows 10. I've tried=20
> everything! chmod -R 777, chown -R <my user id>, etc.
>
> A few more details: I have a Git repository on my PC, and from that,=20
> I've cloned a bare repository on my laptop,

[Philip] "How did you clone that bare repository? In particular, how did =
you provide the path to that repo."

I'm recreating the entire process below with a smaller repository on my =
PC (so it won't take hours to clone, etc):

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ git clone --bare . =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry.git
Cloning into bare repository =
'//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposit=
ory.git'...
done.

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ echo "line1" > afile.txt

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ git add afile.txt

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ git commit -m 'Added afile.txt'
[master 7fa616b] Added afile.txt
 1 file changed, 1 insertion(+)
 create mode 100644 afile.txt

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ git push
Counting objects: 3, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 287 bytes | 287.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0)
remote: fatal: not a git repository: '.'
error: remote unpack failed: unpack-objects abnormal exit
To =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry.git
 ! [remote rejected] master -> master (unpacker error)
error: failed to push some refs to =
'//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposit=
ory.git'

Note: I'm able to access the remote repository using Cygwin Unix =
commands on Windows 10:

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ ls =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry.git
config  description  HEAD  hooks  info  objects  packed-refs  refs

... and I do have write permission:

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ touch =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry.git/anotherFile.txt

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ echo "line2" >> =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry.git/anotherFile.txt

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ git remote -v
origin  =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry.git (fetch)
origin  =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry.git (push)

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$

So, I can clone the repository, and I can still write to the remote =
directory using the "touch" and "echo" commands. But I can't push to it. =
It seems that "clone" can access (create, actually) the remote =
repository, but "push" cannot access it effectively.

[Philip] "If I understand correctly it must be in a URL format (e.g. =
file://) to ensure that you get distinct repos, rather than two =
interrelated repos (thought the docs discuss the issue as being the =
transport mechanism)."

"file://" is for referring to a local file from within a web browser. =
"//" is how to begin a path of a file on a remote machine in Windows.

After doing all of this, I created another test file on my laptop =
(filename: afile2.txt) in the repository on my laptop made by cloning =
the bare repository that I just created on my laptop, and added the test =
file afile2.txt to the cloned non-bare git repository, and then did a =
"git push" on my laptop (the remote machine) to the bare repository on =
my laptop (the remote machine). Then, back on my PC, I was able to do a =
git pull even though earlier I could not do a git push:


lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ git pull
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From =
//lylez-laptop/Users/Administrator/bare-repositories/budget-bare-reposito=
ry
 + e9d5a3c...cd21f1d master     -> origin/master  (forced update)
Merge made by the 'recursive' strategy.
 afile2.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 afile2.txt

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ ls
afile.txt  afile2.txt  backup  Budget.xlsx  Joanne  Scotland.xlsx

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget


And there it is, the new file (afile2.txt).

So Git is able to utilize the remote bare repository for cloning on the =
remote machine, and on the local machine (my PC) it can pull from the =
remote bare repository, but it can't push to it.

[Philip] "The same issue probably applies to the subsequent clones of =
the bare repo."

[Philip] "Perhaps focus on the error message and decide if "." is the =
correct way of thinking about the path."

"." is the local directory on my PC that was initially cloned. It is =
where the Git repository reside:

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget
$ ls -a
.  ..  .git  afile.txt  afile2.txt  backup  Budget.xlsx  Joanne  =
Scotland.xlsx

lylez@LJZ-DELLPC /cygdrive/c/Users/lyle/documents/budget

>   which I then used to clone a regular repository on my laptop. The=20
> error occurs when I attempt to push changes on my PC into the bare=20
> repository on my laptop.
>
> If I delete the old bare repository on my laptop, I'm able to create a =

> new bare repository on my laptop from my pc, but then as soon as I try =

> to push to it, I get this error again. I've tried disabling the =
anti-virus, etc.
> I've spent hours Googling solutions. Nothing works! Many others have=20
> had this same issue. I never had this type of problem with SVN.
>
> It would be nice if Git would say what's failing when this happens,=20
> and it would be nice to get this bug fixed. It happens with all my git =

> repositories. I don't think it's a network issue or I wouldn't be able =

> to create a new repository on my laptop from my PC, as that would=20
> encounter the same permissions issues.
>
> The two machines are connected with an ethernet cable. I've done=20
> everything I can to make sure all the Windows permissions are set =
correctly, etc.
>
> $ git push
> Counting objects: 3, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (3/3), done.
> Writing objects: 100% (3/3), 331 bytes | 331.00 KiB/s, done.
> Total 3 (delta 2), reused 0 (delta 0)

> remote: fatal: not a git repository: '.'
[Philip] "Why is the remote end of the connection reporting the error =
that it is looking at "." (as opposed to a proper path/repo)?"

I'm not sure. I cloned ".". I think that's a legitimate thing to do.

All this stuff has worked for me for years. I'm not sure why it's =
stopped working.

[Philip] "I could easily be wrong - I haven't double checked the man =
pages at all, but thought a comment may help your research."
> error: remote unpack failed: unpack-objects abnormal exit To=20
> //lylez-laptop/Users/Administrator/bare-repositories/Tradelab-bare-rep
> ositor
> y.git/
>   ! [remote rejected] timestamp_testing -> timestamp_testing (unpacker =

> error)
> error: failed to push some refs to
> '//lylez-laptop/Users/Administrator/bare-repositories/Tradelab-bare-re
> posito
> ry.git/'
>
>
> $ git --version
> git version 2.17.0
>
> ------------------
> System Information
> ------------------
>        Time of this report: 10/27/2019, 16:53:09
>               Machine name: LJZ-DELLPC
>                 Machine Id: {39BC0826-743F-4ECA-AFBE-66A14FBE533C}
>           Operating System: Windows 10 Pro 64-bit (10.0, Build 17134)
> (17134.rs4_release.180410-1804)
>                   Language: English (Regional Setting: English)
>        System Manufacturer: Dell Inc.
>               System Model: Inspiron 3650
>                       BIOS: BIOS Date: 06/17/16 21:14:07 Ver: 05.0000B =
(type:
> BIOS)
>                  Processor: Intel(R) Core(TM) i5-6400 CPU @ 2.70GHz (4 =

> CPUs), ~2.7GHz
>                     Memory: 8192MB RAM
>        Available OS Memory: 8096MB RAM
>                  Page File: 8076MB used, 7243MB available
>                Windows Dir: C:\WINDOWS
>            DirectX Version: DirectX 12
>        DX Setup Parameters: Not found
>           User DPI Setting: 96 DPI (100 percent)
>         System DPI Setting: 96 DPI (100 percent)
>            DWM DPI Scaling: Disabled
>                   Miracast: Available, with HDCP Microsoft Graphics =
Hybrid:
> Not Supported
>             DxDiag Version: 10.00.17134.0001 64bit Unicode
>
>
> Regards,
>
> Lyle Ziegelmiller
>
>
--
Philip


