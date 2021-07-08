Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BB5C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 16:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C9E61874
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 16:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhGHQjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 12:39:22 -0400
Received: from mout.web.de ([217.72.192.78]:40967 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhGHQjV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 12:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625762198;
        bh=gWoKgBeaA9yzXAixisJgePlu/rFVxz2FKfOBOFTaphs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=em697Mws5YoMRmPfcBBu6cCUvM3q9K8SQvxJCLByMh+DKJJqeCW/Nab4vzuA+uA2b
         FpV2G5eemLQTgoump/lD7pVUciEXSOtTYUwJC4gWSgSb7l3I6V6Gg/b7nNQgYX5NY3
         QKRuQvBszSpkATD1kEsI/nKBvaZjPgwsja1PfLJg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.26.194]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MPpIE-1m5OtQ0kYU-0052Pq; Thu, 08 Jul 2021 18:36:38 +0200
Subject: Re: Antw: [EXT] Re: bug in "git fsck"?
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     git@vger.kernel.org
References: <60DF1C22020000A100042225@gwsmtp.uni-regensburg.de>
 <xmqqczs0popg.fsf@gitster.g> <52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de>
 <60E2B7FB020000A1000422A0@gwsmtp.uni-regensburg.de>
 <77655a4e-8c39-5ccc-71af-d2d8684bf208@web.de>
 <60E40275020000A1000422F7@gwsmtp.uni-regensburg.de>
 <fcfd0401-df5b-15ec-29c4-74d2903274cd@web.de>
 <60E6B541020000A1000423C8@gwsmtp.uni-regensburg.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f460e7e0-113e-f19f-fbaa-a22f567105dd@web.de>
Date:   Thu, 8 Jul 2021 18:36:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60E6B541020000A1000423C8@gwsmtp.uni-regensburg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K2xRbHNvWlenP5KDM/0Bt/oKPkauHL6lCWWuEDLlxxkLd3V2ngW
 jE/s8mvgMP4HvyoPbrbUvBkh/fAXoAOhRCGJCJ50f0gyVCllzKa8PnrX3g/TvsAb2gleF/u
 5v3d+ztLab9pJ8FljAwObQtA0PmcGunqeXtMPjaOVVj6lETcm6lVUYz7zfZUpVL+TxXjD7j
 V40X/EdAbHaiPcaKjL7iQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kFcskSblyOc=:VlRjae5uQyw/AZKJPxOQIl
 kd+QrMVete/fWR+zp8QpicE96+8wlsUftaysVokMD+3WSNXbmcFyiA4rLVgcP7kkogicAvU3g
 WQ8AGUXvrP1V3FH9dNCNmY8n/dtrxVOJyekPmKsXpOkZ3eCNDwOwzEbMufADIXe48K0cibsS7
 H/Z3Dl4C5FWC4Ja09u6Ig4RRv2mIrMK7cgwq7c3rp+SGYF+qWj81I/AXHjT2V3iqTuadqz4aZ
 ObZ0wca5uFE3/JYjdsz6NCUPz2o7xdv6q7SfP+vjq6nxYGvjMR1Vb/mezU7cAMmw/smIQ5cyf
 Pk42ZusIAfYfop5rnHm0s4G8rJbofTlKcmBsV7T2tXydDiLFirGlg5t+GKv/DfhNNSsu86Orc
 L0P8/+i+A2KAk4xLSNnIUDdxglErp7keIpPB5pmR5Js8qLyor5nmEMYn9+xsnWehgGtLThqG0
 bF2nwybaqJQUFILt+lO2f2wmPAYjw2FUQuVefh/luRTakRXUpy8sRyb9gXxz2Goq4WXQ2vIVA
 HXMVLxN8+wqXX2nKjI5AKims5piykeGkXh1retuKSi8pBUSRygQZpP+lqaD5n95slFiQZwDi8
 dR+h1qxy05AqWfDwVCHheKOV/+pPEhWlv/6uhgr3FqY84wZmwcMJgHCeB7tO8VwhYgwtpRHW5
 0VT3bw8VC0iFFviH7NkfK8qVbslK56RBa6mextgtpGbWiZ4PVYAUSJLIV2BleaTj//9edFNvU
 njUIBqo5OcJ9VrjB0rnEXh9hIaOZZ/MNf9S0RgrnTyGJcQYC0pryu5t5dfxV33wRHmmLrY5Wd
 xmmeapCnfULCIpPzfYx9oaLnBlI+vSh8f676ZX1DH6A1c6kE0awnyp4AGI07Syvuv604fryZp
 LTZ2PHbFurKv+QXxgDDB5z2hJ6QFUeRa4IELBV6iktpERWeFpQzJ5S/HC1WQn/zg+sYGTAWyV
 iDSDA+0KkkEZkEnsic6aKxX3Fs8iBlEt5SHm7sqltk6LHmjHPi3oXqcMnvCr9Boid1hr/RIDh
 Gbr6zsPejTg/6qcTv2RJbEdXyASV9X/O6FGz2WauOduv2bkNE9rxLW9yT2kOVsBVtA1aHhHSa
 RHpybcGQNEBK2mF9FtSV25xI47NcAyrci/d
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.07.21 um 10:20 schrieb Ulrich Windl:
>>>> Ren=C3=A9 Scharfe <l.s.r@web.de> schrieb am 06.07.2021 um 16:25 in Na=
chricht
> <fcfd0401-df5b-15ec-29c4-74d2903274cd@web.de>:
>> Am 06.07.21 um 09:12 schrieb Ulrich Windl:
>>>>>> Ren=C3=A9 Scharfe <l.s.r@web.de> schrieb am 05.07.2021 um 16:44 in =
Nachricht
>>> <77655a4e-8c39-5ccc-71af-d2d8684bf208@web.de>:
>>>> Am 05.07.21 um 09:42 schrieb Ulrich Windl:
>>>>>> You *can* overwrite them using "git branch --force foo" and then
>>>>>> "git branch -d foo" works.
>>>>>
>>>>> Would it be OK to force the branch to any commit (e.g.: "master"),
> relying
>>>
>>>> on
>>>>> the fact that any reference (read: "master") to that commit will pre=
vent
>>>> actual
>>>>> removal of the commit?
>>>>
>>>> Yes, any valid commit would do.  This turns dangling branches into
>>>> normal delete-able ones.  Other branches are unaffected.
>>>
>>> OK, but either it does not work, or I did not understand what to do:
>>>
>>>> git branch --force bitmap-generic
>>> fatal: Not a valid object name: 'bitmap-generic'.
>>>> git fsck
>>> Checking object directories: 100% (256/256), done.
>>> Checking objects: 100% (173/173), done.
>>> notice: HEAD points to an unborn branch (bitmap-generic)
>>> dangling blob 0458be7cf03f35be365c819afe0104ff3c178ca0
>>> dangling blob 3000d29f0a652f3f7ed25572cac9969b90adeca5
>>> dangling commit 90e8531086d3efaeefdf6c8d39b6782e49dd2a0d
>>> dangling commit b598195f859106662bde746f391a7df9162231e9
>>> dangling tree fb4866ab5cc2f0c34a63334b90550ef7199a2098
>>> ...
>>
>> First: Please make backups.
>>
>> Here's what works for me.  First reproducing the error:
>>
>>    $ echo aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa >.git/refs/heads/bro=
ken
>
> Hi!
>
> Thanks for the hints. But first the problem is in the repository, not in=
 the
> workspace, so I don't have a ".git/refs/", but "refs/".

So you have a bare repository (one without worktree, i.e. no checked out
files)?

> The other thing is that the only "refs" that is there is "master"; the o=
ne
> with the problem isn't there.

You probably had your refs packed (in a file named "packed-refs").

> So I tried:
> % echo aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa >refs/heads/bitmap-gener=
ic

I used that command to generate a broken branch.  You already had a
broken branch, so you didn't need to repeat that reproduction step.

> Then "git branch" indicated that "bitmap-generic" would be the current
> branch:
> % cat HEAD
> ref: refs/heads/bitmap-generic

HEAD references the current branch.  So the broken branch was the
current one for you?  I somehow assumed that you'd be on a healthy
branch.  And I'm not fully sure how to use branches in a bare
repository.

> Next I brute-force edited HEAD, repacing bitmap-generic with master.

OK, but at least this moved you to a healthy branch.

> Still, that would not work:
> % git branch --delete --force bitmap-generic
> error: Couldn't look up commit object for 'refs/heads/bitmap-generic'

Expected; you hadn't done anything to that branch, yet.

> But the next command worked:
> % git branch --force bitmap-generic

This made the broken branch point to the same commit as the current
branch, i.e. master.

> Finally, this also worked:
> % git branch --delete bitmap-generic
> Deleted branch bitmap-generic (was 03aa7ca).

Right; the previous command had unbroken the branch, so it had
become deletable.

> Most importantly "git fsck" did no longer complain.
>
> Thanks for the help! Do you want to provide an answer to stackexchange, =
or may
> I use your procedure to write an answer?

Feel free to use it.  I don't even have an account there.

Ren=C3=A9
