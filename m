Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A03020970
	for <e@80x24.org>; Tue, 11 Apr 2017 20:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753452AbdDKUkg (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 16:40:36 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:32782 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbdDKUkf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 16:40:35 -0400
Received: by mail-io0-f175.google.com with SMTP id k87so2897802ioi.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 13:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2BOVXg8UmOCtjjCKrNJz3SclZWdrVJDrAZHrSkLA8MM=;
        b=t7Twf2RAlfS/KrtO3bnsG5nAAFktwacX4EPIjsprPmOV0BmV58qrNRQUU0TNb/oj0n
         +qQgql6h9xSR/YHSYxN9LhhT47HvxcP0vq/s9UpMOtJq7p5oaJRg83n//HgodgggCB/x
         WGuY47Mx3AnZL8hqK1l67d1RAyQjK9ODUVcUivpsX4e0T4RkUKN7bTbYlba9O2mrfV3X
         cBSByTG+/SW5R61Jm8U/+WWuPTgBt3SpwbLyVze197u1sxh5Gp3upiY9oy+aE4tr+99r
         w24GxtBiDsC+1U52cFm47iH+RkNHJ8D3s+NaOF05EFISe5O7HMSPguu8N9VI9n3lyMfN
         J0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2BOVXg8UmOCtjjCKrNJz3SclZWdrVJDrAZHrSkLA8MM=;
        b=jDWr+dpmZlIL/cL0EzhEEwwYXOrOPvaPaSNoa411T9ftBeKCImGUJRHLOp+TNeP9i9
         1X1I6iA1Ro2QqsHn43m6Ox60P+J2r/KGZ3dumbF20GmocLnFXQ9+rucUPmunVXlZLYqx
         A9FFrKJz9hTLN5LO3zFk3UVxn8J3dwEwC1jYhC4938vq9Hmea8GXGu+1D9qDiaQf7/gv
         O9MKDAufzrEdki/h7TCzahHMgpMsk0bQO7x5ZPR5cw8jPCW6qgXHL5CU8g60BVF2Nnej
         DohJuR+cjFGZYeeYr6AXmYvz/5hg/4GgYaPmrkPsImOoAf5FGE/Wpxp3SzrjyAF8FuM7
         SvFA==
X-Gm-Message-State: AN3rC/7aAK3SF9i7yYHkpk/a74ekaEeCUBiq2KJM83PvE53rE9piRLdq
        MhTebzEM+/v84ydK3w0wDgJtknEtv+whe4M=
X-Received: by 10.36.82.144 with SMTP id d138mr19737083itb.24.1491943235025;
 Tue, 11 Apr 2017 13:40:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 11 Apr 2017 13:40:14 -0700 (PDT)
In-Reply-To: <CAMLReHYbuHmGTtBSUQq3bO=6ghz=rfP-=Eg=PvP0tkwZbM2Q1Q@mail.gmail.com>
References: <CAMLReHYBVmuu5H015N1ShCD0iLNau9oLOabJhQ7xc=58rXQi+Q@mail.gmail.com>
 <88df8638-9b7b-42c4-bb34-4e1a49d4c22d@grubix.eu> <CAMLReHYbuHmGTtBSUQq3bO=6ghz=rfP-=Eg=PvP0tkwZbM2Q1Q@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Apr 2017 22:40:14 +0200
Message-ID: <CACBZZX7xqoZ3LboOjwvQvX3JRJFhjFC54+mfLOddLXzconrobw@mail.gmail.com>
Subject: Re: `git status` output is very misleading after a merge on a
 "detached HEAD"
To:     =?UTF-8?Q?Enis_Bayramo=C4=9Flu?= <enis@picussecurity.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 5:13 PM, Enis Bayramo=C4=9Flu <enis@picussecurity.c=
om> wrote:
>> Well, what do you suggest as an alternative?
>>
>> Git tells you that you are in detached state and where you came from
>> (detached from).
>
> I think it'd be best if git status somehow indicated that you're no
> longer at the same commit. Maybe something like:
>
> $ git status
> HEAD detached from origin/master, no longer at the same commit
> nothing to commit, working directory clean

I'm not saying this is clear, I didn't know this until I read the code
just now, but for what it's worth it says "detached at" if you're
detached from BRANCH but at the same commit, and "detached from" if
you're now on a different commit.

> or, to be more informative
>
> HEAD detached from origin/master 1 commit ago,

In lieu of that, which would need some of the rev-list machinery to be
invoked on every git-status, I wonder if just saying "HEAD detached &
diverged from origin/master" wouldn't be clearer:

diff --git a/wt-status.c b/wt-status.c
index 308cf3779e..79c8cfd1cf 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1542,7 +1542,7 @@ static void wt_longstatus_print(struct wt_status *s)
                                if (state.detached_at)
                                        on_what =3D _("HEAD detached at ");
                                else
-                                       on_what =3D _("HEAD detached from "=
);
+                                       on_what =3D _("HEAD detached &
diverged from ");
                        } else {
                                branch_name =3D "";
                                on_what =3D _("Not currently on any branch.=
");




> On Tue, Apr 11, 2017 at 5:55 PM, Michael J Gruber <git@grubix.eu> wrote:
>> Enis Bayramo=C4=9Flu venit, vidit, dixit 11.04.2017 10:57:
>>> I've encountered a very misleading output from `git status`. Here's a
>>> sequence of events that demonstrates the issue:
>>>
>>> $ git --version
>>> git version 2.12.0
>>>
>>> $ git checkout origin/master
>>>
>>> $ git status
>>> HEAD detached from origin/master
>>> nothing to commit, working directory clean
>>
>> Hmm. My Git would display "detached at" here as long as you are on the
>> commit that you detached from.
>>
>>> $ git merge --ff f3515b749be861b57fc70c2341c1234eeb0d5b87
>>>
>>> $ git status
>>> HEAD detached from origin/master
>>> nothing to commit, working directory clean
>>>
>>> $ git rev-parse origin/master
>>> e1dc1baaadee0f1aef2d5c45d068306025d11f67
>>>
>>> $ git rev-parse HEAD
>>> 786cb6dd09897e0950a2bdc971f0665a059efd33
>>>
>>> I think it's extremely misleading that `git status` simply reports
>>> "HEAD detached from origin/master" while this simply happens to be a
>>> mildly relevant fact about some past state.
>>>
>>> Thanks and regards
>>>
>>
>> Well, what do you suggest as an alternative?
>>
>> Git tells you that you are in detached state and where you came from
>> (detached from).
>>
>> Michael
