Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F55D1F453
	for <e@80x24.org>; Sat,  2 Feb 2019 06:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfBBGic (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 01:38:32 -0500
Received: from mout.web.de ([212.227.17.11]:47083 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfBBGib (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 01:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1549089509;
        bh=/tNNHAM1YoIDq34iQjgPZcQCHU9msE9VbLcUOpRAnOA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=IcOyKEu9PTj6nAZNHU1RZFQxd71PTwadvKAsKutcP6pipDwiivSmlHE/hbpuI7kW5
         TG4LcxpkpJ7M0sVzHyVx1THImIZ37Ur6nZA65ufFUK9npZYvv8dzSG6qmEbAw4Gz5g
         ErCF1mhjXTrlslNeAa3SRSIuHKqOHhPjSG5BeRf0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lk8gg-1hRtWQ3j3q-00c89G; Sat, 02
 Feb 2019 07:38:28 +0100
Date:   Sat, 2 Feb 2019 06:38:28 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Angelo Melonas <angelomelonas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Possible minor bug in Git
Message-ID: <20190202063828.4kjtdmrsm7g4eyg3@tb-raspi4>
References: <CAHYHVP+ty7i7a_abT-th_HR2X-8X6mLmpHPR_3VXv5LpWUsrhQ@mail.gmail.com>
 <CAHYHVP+Dvbq_aOMy1_Kq0LHJsd4r+4GiP3N3R4A9ouAoJ4gw9g@mail.gmail.com>
 <20190131203447.aovalz2vzsjpdjdv@tb-raspi4>
 <CAHYHVPJdbEOPaAoyAhOtJ+wkeXZdowAVqe1Tp_=LOKzuuzA+wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYHVPJdbEOPaAoyAhOtJ+wkeXZdowAVqe1Tp_=LOKzuuzA+wQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:BZbjd9QB3NqU1lBb0TEaI/U/+6ewrqLomVnlSGYJe5m6crSlA1A
 eNFp1wfQhmhNO7lm3Xn1Pc6StJApviNqenXuJ/zhVOGvbeFr/pFnDXgQL377E77gVhR+tvf
 XuQVrlbAXu8R+4icYsIRi1FwafHB+1js9anVsBsrxeIZOfY5QV95oHwlMG6faSkERCwVsOu
 1OcZbcs60ax/PCKUs5bxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y3zkPB2FDh4=:2Hyzmww+JBa9g4fM/SPiUY
 GnAB65Fu/zlGOSSouTYCM8dzQmPjdnWaqHGsTb0u0qm2gxmbw+x72AAarmDyuyDQunZtoan8W
 aoIo3iD+FOjRvjpVSY5ngpiE44Gh/i+FSMol2+++Op82MVq7oH7FqhjlSKl3gixQxHkdPK8DM
 o5K0ZNGZBsmL91VXTqBpyjeeGPeehaPzFyGSePTpXr/fiXD0IqZBTJj4uWiXeGljBgWsqFCdj
 xxfV54EiKq/UKJE/50s0iMvWDIXgjSJQnBGS0aiPQ+B3SQS5O0Xya9gEKo1th5Wp2OgaKIV8d
 qqPjxgZoopHr5eYQX4iT9z33voFZ8LCciWNeiXuhvegI/3FGPjCJvo5dREhlpp+FvLd7LdsFF
 u0tdLSG/FlahBNibRHSxMjZ4lH4oTprMEQUVP4hMfJ+ga8pk9QazVPDBpg2ovEzBTYGjfu8qY
 TUjDFky3e4nDddKLgntfV0pxYWL1rmJCCWc3SSubF2hVAzp6rrR3bHcdvWB1FDR6fFm+RtiET
 NtMy1La/u1uLg2PyG2WDdWuvacMBKpTLWZV1crQGPuTPtRAujpy6UtIu9mEt7rqSM9Ms1vn04
 abRZ6eAJpl2XJnWwxFa8qbn8PBDLfmjjaQlJeMY5SuZI67pHuMVJK27KyYsTYKQ03SQ89V0/y
 eQLNLarPYACvZm7kXkwV7zs4jQ/DNOdhY3dOPwm+iAbZHI7Z5EKnCrplmjGKlDA/b9kIVRfsq
 WipeJRZlkptgtLQoiqKLp+W4TB/Etg+iwi6L6bUAhkv/gmXF+aYKnHZilST1HkvX3Jl2lafmZ
 okr3LT8095FobJIHhzZ0MYLOAPx6L//scP5zDBLfySs+ZpLk1M8ScQD8OxgehWk9WIKYt+WEq
 QdZK3L5O3cNJmqDwWvoPgea0mhc9japBcFaG65ts2CQlnB4hrOye8vnrXNJG4e
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 01, 2019 at 10:02:50AM +0200, Angelo Melonas wrote:
> Hi Torsten,
>
> Thank you so much for getting back to me.
>
> Unfortunately, I believe there is a misunderstanding, as I may have
> explained what I found to be a possible bug incorrectly.
> The file that is originally added (and then later modified) is never
> renamed or moved.
> As you will see below, when a user attempts to add a file, but with
> the incorrect case, the Git CLI responds the same way it would if a
> file was correctly added (i.e., by displaying nothing).
> However, in the above case, when you enter "git status", you find that
> the file was never actually added, and remains unstaged.
> A possible solution to this can be a simple error message similar to
> attempting to add a file with its name misspelt.
>
> Using your example, I have illustrated this in the text below:
>
>     C:\Example>git init
>     Initialized empty Git repository in C:/Example/.git/
>
>     C:\Example>echo AAA > AA.txt
>
>     C:\Example>git add AA.txt
>
>     C:\Example>git commit -m AA.txt
>     [master (root-commit) d550af0] AA.txt
>      1 file changed, 1 insertion(+)
>      create mode 100644 AA.txt
>
>     C:\Example>echo BB > AA.txt
>
>     C:\Example>git status
>     On branch master
>     Changes not staged for commit:
>       (use "git add <file>..." to update what will be committed)
>       (use "git checkout -- <file>..." to discard changes in working dir=
ectory)
>
>             modified:   AA.txt
>
>     no changes added to commit (use "git add" and/or "git commit -a")
>
>     C:\Example>git add Aa.txt
>
>     C:\Example>git status
>     On branch master
>     Changes not staged for commit:
>       (use "git add <file>..." to update what will be committed)
>       (use "git checkout -- <file>..." to discard changes in working dir=
ectory)
>
>             modified:   AA.txt
>
>     no changes added to commit (use "git add" and/or "git commit -a")
>
>     C:\Example>git add A.txt
>     fatal: pathspec 'A.txt' did not match any files
>
>     C:\Example>git add AA.txt
>
>     C:\Example>git status
>     On branch master
>     Changes to be committed:
>       (use "git reset HEAD <file>..." to unstage)
>
>             modified:   AA.txt
>
> I am looking forward to hearing from you again.
>
> Kind regards,
> Angelo Melonas
>

Actually yes, you can call this a minor bug.

Does anybody want to work on it ?
May be as a first-time-Git contribution ?


