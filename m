Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A08EC433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 21:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EAC464EE1
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 21:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhBJVoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 16:44:54 -0500
Received: from mout.gmx.net ([212.227.15.15]:34789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232097AbhBJVov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 16:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612993395;
        bh=/jZNmwAGA8HulsOz1UhEbz0U6t689LOA/aSqT0L6/s8=;
        h=X-UI-Sender-Class:Subject:From:In-Reply-To:Date:Cc:References:To;
        b=Q9/STgtriEVMkjRJpjuluuhZdOWitZXOHnEA+I9OxYB9l7eIEOC0QUPMv/kZri4OH
         TYmbfn9k9vWmwWyrCTb2qJ7UURMECdv7qQfLq0v/+D7VsdPMayYbU5qrlt3e5b7b6v
         KlMESiiFR1lRhWmtGe77brMR1ev8pk1x1sETE4Lk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.101] ([62.202.181.185]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDywo-1l05tX1NO0-00A1NL; Wed, 10
 Feb 2021 22:43:15 +0100
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH] doc: mention bigFileThreshold for packing
From:   Christian Walther <cwalther@gmx.ch>
In-Reply-To: <xmqqim70zzaf.fsf@gitster.c.googlers.com>
Date:   Wed, 10 Feb 2021 22:43:14 +0100
Cc:     Christian Walther via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F63929A8-7BC9-43A7-9E7B-118433F62588@gmx.ch>
References: <pull.872.git.1612897624121.gitgitgadget@gmail.com>
 <xmqqim70zzaf.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3445.104.17)
X-Provags-ID: V03:K1:EUkk4u4fmHLT1pUWnizy6JicnPP0b5inB7aJAjAoybTNQUH81Vf
 rJ2ilppU8wXZ4HohPHZG5SU5obxDINK4KmuNh2W3VzBPa/6tn5r02BlrhxNfsP3weQ5P2QW
 adq9eMhtqhl07bqTflE5YUvCuhlOt5ptsqpRCtGDG8gayqmx2BdcajEdP84ralcsyEpY0MI
 j0BxOqEEqTxhCj6uK+9iA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sa6p6gqxzEg=:njy6/VW9N3/s9yOOwUUhED
 EKpvux5Z0aUhdjMoumV0yo+5e60sP6LOvum2TMhrV9SvOAhsc1FgoZO3f84oT8jhV619+yN8U
 c2oh+vf1h8NngaDuX1xKyPR2ysT5tO9ZvcGV/3+Sp38m8kwZXaXx8sSeOWZQpHqT89qd4N8F7
 d2L1Xm3ynN94i+rMDfFjeqInMMbRXc5Lsehsibjc/HNUocW4CKCHtvG/kRHoT24+EinWNTsAs
 hxRqdyuBIAD1F7LoDyPupwMqkViGtp1QL+Twb64JHsqbfxPLp4Wqa+lrl4q2uYcdQVUd8KBVy
 MFEiTe42VPyb7yrl2Hwljtp8JWGd+Oqq0cFju0qAAn+U/FZVY0Uhc9aZ68ts4fK3YU6t1tC9e
 812BemwUW+nRJuvNaamAlxQSjglv/bKwW3OL9fKrA61JplOlbS3x9sV3X9GtfYl7ZHhSVvPf4
 rwSi7DFWY7u2e3xv37f7jO/u80FB1sCFuNSUZqYG+aaa6PEzoYLTflb0LAtFehq0Frfvcox+C
 HEwgqf+luvUS7qK1jzyfmwwBJF0amMkjpJGouH36tuwgYYNwNoHyss9VhmxzSpZL5ugHm0DBn
 WzZ12L1Z1nhhyzFrhxbBDhyX3Z+XPbtlUKtw3Wmvcs/EW0uOeWg0DxcQTBFDDwAeZ4L1Actcm
 JLRlJRyROS7KbvzlGKjecD1sum5Q21NcdXy3+RlwSEnoq8M0Kb76kv+3ZuAGRm6/fGxke/AJc
 n/a7QjRsGgmKqbkpAKKmBPCyFqHjZx8SsJBJimBYAKTSw+LiTAt68SLKRoI26pktJsYOokeid
 mippw4VAnDo4Az8nIByl+hfDM5pTBKnwPcDilFblOVV0Jv3qOBUkfXy0pHHJFAGwJQggbQhSz
 PSA017BA661PPpk/JFeg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> I doubt that the description of --window/--depth command line
> options, for both repack and pack-objects, is the best place to add
> this "Note".  Even if we were to add it as an appendix to these
> places, please do not break the flow of explanation by inserting it
> before the description of the default values of these options.

OK. That was where I would have looked for it, because it explains why =
--window wasn't effective in my attempts to get better compression, but =
I don't insist on it - any place would have worked, as I read both =
manpages back and forth several times.

In git-repack.txt, there is a "Configuration" section at the bottom, I =
guess it would fit there? There is none in git-pack-objects.txt, but I =
could add it. What do you think?


>>    I recently spent a lot of time trying to figure out why git repack =
would
>>    create huge packs on some clones of my repository and small ones =
on
>>    others
>=20
> Not related to the contents of the patch, but I am somewhat curious
> to know what configuration resulted in the "huge" ones and "small"
> ones.  Documentation/config/core.txt::core.bigFileThreashold may be
> helped by addition of a success story, and the configuration for the
> "small" ones may be a good place to start.

The "huge" repository had bigFileThreshold =3D 1m. That was set by =
SubGit when converting from Subversion, for reasons unknown to me (see =
some discussion at =
https://support.tmatesoft.com/t/reduce-repository-size/2551 and =
https://issues.tmatesoft.com/issue/SGT-604). The result is a pack file =
of about 3 GB.

The "small" repository has it unset, so the default 512m applies, =
resulting in a pack file of about 50 MB.

What causes the huge difference is that the repository contains a =
"changelog" file that changes in almost every commit and has grown to =
2.4 MB over 10000 commits. So it exists in about that many different =
versions, of which about 6000 are larger than 1 MB, but they only differ =
from each other by successive addition of small pieces.

I'm not sure if that makes for a good success story. 1m seems a rather =
extreme value to me. If you think so, I can try to come up with =
something.

Thanks

 Christian

