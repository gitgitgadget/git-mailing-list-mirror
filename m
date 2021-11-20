Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219A3C433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 08:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbhKTIIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 03:08:18 -0500
Received: from mout.gmx.net ([212.227.15.15]:56183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230207AbhKTIIR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 03:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637395508;
        bh=2t6OBzbSWL78GhBYrTZiJaqhWadkknOFomq3zCtxy64=;
        h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
        b=bYg3gI5iutGkMpB5fec54peljMU+XNOKSnImFEFvwrGD5bxdHzFgW8wDxOBhoaWgz
         c+GQ+kMdttP/Kq4pkzXcHJPkC1BC/y8MVWjOeCHsDvxMKzfLTRhhSx//7N+2UifOM4
         ae7Id3MIMQdHtY+1SfBRRRHKjzcT4uqoKYc9xm9Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [127.0.0.1] ([213.196.212.25]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsPy-1mx6nM1JvE-008sX5; Sat, 20
 Nov 2021 09:05:08 +0100
Date:   Sat, 20 Nov 2021 09:05:06 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        git@vger.kernel.org
CC:     Junio C Hamano <gitster@pobox.com>,
        =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/6=5D_CI=3A_Remove_Travis_CI=2C_?= =?US-ASCII?Q?shorten_names_for_GH_tooltips=2C_split_jobs?=
User-Agent: K-9 Mail for Android
In-Reply-To: <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211120T030848Z-avarab@gmail.com>
Message-ID: <BED25714-4917-46CB-AAD4-C30158A7A42C@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5yk6AV7mJl4SexOQnu6BJTnsDRMa7sarzAq24uKwCYOZzQWVzqn
 oictgC4kSciJqM+sytDzuoufntcyIcLlwFhx3Nvi1zzDkHiIuNv0fbZbqWIfTibTuVwUoCy
 NKZ5xHnZeHPOLD8UDuBP8dx4Uaqzo+MbtsTmOUVaQDPxmRxLK5EoRvhxhwAwvGwh8M+XPZC
 kcjVEKVz11Loc6qO2FYkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TiCa++OMK6U=:yQMDegrbzU/E7+TV/B63M4
 Nd/klbZ9ybGlieC6Nw5rrXcn5OQjjp/eAKYfcfk2ugQIQ++IRHG4OrHkaj+f9hiWNnwgU1Fcn
 8xl2n7f0MYEyJwJzuyNz6gd+J1ir0oNarGEIFKIondqkqOC4l/l1mwAuBcD5F0RS7db39TA0Z
 +QONm4f+E70XHycurgusfAdGb/is9m+AS/gN2ojrzp85BMYvk2nI+v/IH+H4c5syAeCUpArFE
 MEGfj1XmXyQTAZ7uf4FYThHuXp2kFUqUPBAeO7OzTci0JyUpMsAOUD/7npFwTNWqNXv/nJ+Tu
 dEIxwlTxeDx3f3/vADEG09x85sXVFdj+s5F0DsEoqqSYOOJ/ItwXDA745b1V7B55H6pYfrh/g
 +J/GImJ5iyC5BwVfSNBlhVDh0xv1zW7ecOpleuiTeVUKmcHIfWq0oiTDSyaNzk18wLK+x3lMQ
 doTAtaE1Bp5ZOdPcVYdwMEsX/sw4nttpVLRWPiL+qE8kWhhRbGMymD7dajjCUgva7EOZQTkPI
 B7dyrpAp/EOnSFBnBESryQoMJewMXRwCK5OrkOB1QVW7TQcsDTfYjmBc4ZqwQAUCAVZ0wDFGx
 LNbraVUjyyyZSVq40JFnFxJgHyvOPfVTd6vFbtds6u0JwHi/Hs04Svj8oxd0/k+R0xOsmmg/K
 U2/Ljy868JVHzq6rTcwTFCnQozhRAF5oRoYGrtrHiIs/sYMFWfCk7fNHUKAOuWtpzPiDizug3
 V6cvXgWYX0KHMkkQv4DFut9dciRBXVNDnn8mnxQygSFABqKgwK1Vvj+fKobv+1oxB+acYCH5b
 +WuOwppfpyWvHeSXhYyy5sxXYv6nhbjy42N9NBAdb6IXKId/1qadJiO5DotiUseR08Pr6Jesq
 6HAR1wklfsp+T952nerMKUIS825SDggibMgjMqUSCIhCHQzFQDPhq2dXVr/XbjCeKFq0vZfmM
 a0m6TuxYCFGjbW1miDCpsLSpJQJeUQ0ppeYrawIwjy3/UWDuA1uGz5YVCOG2tHxUT1ui14xh/
 casQHI1DUF6tV85BFdihSs15alTvVr+K9uqINa8C6zYqyQRmTwaw6pTXe52utSUa5Qp5OkKOu
 JMyIucMtr7tPvU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 20, 2021 4:28:30 AM GMT+01:00, "=C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason" <avarab@gmail=2Ecom> wrote:
>
>  CI: remove Travis CI support

This is a patch I am in favor of, and would prefer in its own patch "serie=
s": separation of concern, and consideration in avoiding reviewer fatigue, =
are two aspects I would like to see you optimize for a bit more=2E

>  CI: use shorter names that fit in UX tooltips
>  CI: rename the "Linux32" job to lower-case "linux32"
>  CI: use "$runs_on_pool", not "$jobname" to select packages & config

These strike me as simply shuffling things around and ramping up commit co=
unt in git/git, without actually addressing any of the problems our GitHub =
workflow _definitely_ has=2E

One quite obvious problem is that any failing run is very cumbersome to di=
agnose, and you kind of have to know where you're looking=2E A troublesome =
and off-putting experience for newcomers (and even some oldtimers)=2E You h=
ave to expand the print-failures step logs and search for "not ok" to get e=
ven close to the relevant part of the failing test case's details=2E

Yes, addressing this would be much harder and take more effort than just g=
oing ahead and renaming things=2E It would also be much more useful=2E

>  CI: don't run "make test" twice in one job

I am in favor of the idea=2E As is obvious from the fact that I already pr=
oposed this years ago=2E

The commit message, however, is mum about that=2E And about the reasons wh=
y my proposal was shot down=2E And why those reasons should somehow no long=
er apply (and I would strongly suggest to aim for providing convincing evid=
ence over mere opinions, to back up the patch)=2E

As has been mentioned before, this lack of diligence is disappointing=2E R=
eviewers should not be forced to look up previous related discussions on th=
e Git mailing list=2E I would do that for a first-time contributor, but you=
 are a long-term contributor who clearly has the ability, the knowledge, an=
d the time, to accompany patches with such vital information=2E

>  CI: run "documentation" via run-build-and-test=2Esh

This patch has a commit message that explains what the patch does, and des=
cribes a little bit of related commit history=2E

It does not talk about any convincing reasons why the change should be des=
irable=2E

This is troubling, in particular since it counteracts the major benefit of=
 the preceding patch: to reduce the jobs' runtime=2E

Also, while the preceding patch makes each job's focus more obvious, so th=
at it no longer requires careful study of the entire test log merely to fin=
d out which `GIT_TEST_*` settings are set, _this_ patch crams the check-doc=
s into the same job as the pretty unrelated test suite run=2E In other word=
s, it combines even _more unrelated_ things into the same job=2E

So what does this patch series try to accomplish? To shorten the jobs' run=
time? Or to extend it? To have a clearer separation of concerns of the indi=
vidual jobs? Or to muddy the waters by once again doing several things in t=
he same job?

It is quite confusing and strikes me as a patch series that could have use=
d quite a bit more time and polishing and mailing list research and rearran=
ging and splitting up and patch-dropping before unleashing it to the review=
ers on the Git mailing list=2E It does not help that v2 seems to have been =
rushed out, and tripled in size, no less=2E If I had the task of wearing ou=
t reviewers, that is exactly the type of thing I would do=2E If I would acc=
ept the task=2E

To end on a positive note: I suggest to split off the Travis CI patch=2E I=
t should be relatively uncontroversial=2E Further, I suggest to find the pr=
evious patch that split `linux-gcc` on the mailing list, summarize what the=
 conclusion was, and either adjust the equivalent patch in this series acco=
rdingly in order to contribute it stand-alone, or drop it=2E Then, you coul=
d use the considerable time you seem to have at your disposal on working to=
wards teaching our workflow to present diagnosable information about build/=
test failures in a much more immediately consumable manner than it does rig=
ht now=2E

Ciao,
Johannes

Hi,
