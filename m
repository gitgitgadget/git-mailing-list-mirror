Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA38C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 11:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiFFLBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 07:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiFFLA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 07:00:58 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2BC1660AA
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 04:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1654513249;
        bh=lgBouXOMTZaQBSi92THBTmkR97aXYQ822+RnG8/Wya0=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=YSXvCMVZZc9KZ+x61EaLPj35EBD2QfXRWuC/VvfXLNEmMjUMKvW2sljwk0Pv3z5FT
         MpjhuB7QJDNDbbGOBC5Ffs8FUAgBSAM94HyAir79GL212Cgj5Pwug/J3CZ0nqgfWZC
         nl+BSNsLMXhxik/WQe4JncevC6QqWx6EIHGr3Tis=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNfUF-1o9LXn3mZv-00OtOv; Mon, 06
 Jun 2022 13:00:48 +0200
Message-ID: <24022c08-ed58-8157-6036-6a4c6a49f195@web.de>
Date:   Mon, 6 Jun 2022 13:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: git bug: Including a git repository in a directory
Content-Language: en-US
To:     Steven Jonn Edlefsen <steve@sprangle.com>, git@vger.kernel.org
References: <e308be58-a399-8e5c-36a8-96d3d58caff3@sprangle.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <e308be58-a399-8e5c-36a8-96d3d58caff3@sprangle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FCJS/6RoXqflx7se0dyv14vPeWoaEczbg7kXXn93vrv9lO7GyfP
 dfCy34BIZAWiREUcNrnXG5zZW/bMHCxlL3GcvztyLxWFDL0GOJwoL9NpxE4F3+99DdDMX1W
 Cnk/xPey0ja9tLW2MBS3Iypvd8IgUH5l/am71iMYLPneQEUNo07N4XxLfDqdI7EvrXZ30w8
 /4CorfdBSG7Ui4zdUUsQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L24YntvalFk=:zhXwFPaG96JW19MqkU2TkJ
 yJLMUzAUHWc6qvqKh+6UDva/K0Rfl5j6US/wR32LahNe7V92rNo9XdlscJxwNXKaw88XpoGZR
 Cjecs3mYkpgpl06PbpGu2SqApfaJJ3Gj9fh1phRlujbsrO79pNNVVuQzkN6bHdagLBGp9+0AF
 19XIFrAH02s/zDy9s+2HlIPFbTho0mFiTSeI7WS/rsQo3s52y0sLPRkGcP2bPK6fRDJNzCGaS
 +EQqklfRRYetgQida/p/M5zrXmmL0olnzRjjvoTRThsQEITVIZpm/MNuqipfx6GQ74zdiQtVB
 OQYwjbmLS8MM27fjKLsgHA9/gW8oZWVASSPEm4itbT4OzBSdTkB9Nhh0qNl3kf6KwTjXmMRtf
 7TbaxErU9zso4DEZqnxhZ16JHDKheEAqW5ik7LzQfXiFBx5Vdz7jgjQziYpb6VUtCbcELG9Tl
 x8knN42nWT5PE0/PXwBIQmwKWPXS9qZ+ASBOtIyjWRui6rKdHpYoyLsc1agMKSGF3nYdW7TRN
 hJQeE6HZ/40qY9+wrRnTFnOgxAovibK+XIO8CFxGW6hL3s0Srydgq5JZL0JE2MQNpSrwakito
 HAvyaLlQDEkry790BuYk5JemxiljgPnB+85ba7n5k2kpNCOkiWU2EFzHMpW0Slu7G4asN9pwh
 qCPeUxTc1s/OYA3hMaQ+TAXcsuzoggAJe+G+/+qB5+kEWFQ9pS0AqP6ErDRZfbyIGxHX1PFaC
 TWFpofWJwhwUi/QvSlrNDElQv1QuU5kQ5Jh89C/0tbiAy4P83t/DCY6a/NmIwtoDgFmPU/m5+
 D0HWA1uC8Gks0Qx1KqVx7CS9PFZFlLKFY8+vYknA8pfCTe/l0h8YrP98M743cetuN3AhNx5fG
 fMxUNIPGvjRWnd82yYdJl3jBFvxNfi7W81zJbuVBY2cEJgVsAlMQyy6lc/Eimub59qsKdJcBM
 vsNu5/O9LV5cBkrxuf5CxeajfwTUf1LwXgVy+IsZqmMH3hIlsz0AV+GjCO1cmGBN5dzZ4D8GY
 SFh22qcYWgxbimpRLWnkGrnHJXqiGQJyCmRYxwc+qPI0DYAFwLoFuT1/uML+qgWCB4Eq32xaJ
 mjf9beF/xFmAGKriMywA0VcVJw1gkFFaD9k
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.06.22 um 07:43 schrieb Steven Jonn Edlefsen:
> Git cannot commit/push a directory with a git repository in
> a sub-directory.
>
> The sub-directory with the git repository and the directories below
> are set to the =E2=80=9Cmaster=E2=80=9D branch, while the directories ab=
ove remain
> set to the new branch.
>
> When the top directory is committed, the sub-directory with the
> git repository appears as an empty file.
>
> Even when the subdirectory branch name is changed from master
> to the new branch and the top directory is re-commited/pushed,
> the same problem occurs.
>
> When the git repository in the sub-directory is removed, e.g.
> the .git file is removed, and top directory is committed/pushed,
> the subdirectory has all the sub-directories and files.

This is intended behavior.  A repository inside another one needs
special handling.  Git provides the submodule feature for that.  A
simpler alternative for some use cases is called subtree.

That's all I can tell you, as I haven't used submodules and subtrees
myself.  At least I hope these keywords help you explore your options.
Others will probably chime in with advise on which one to use if you
explain _why_ you want to combine multiple repositories.

Ren=C3=A9
