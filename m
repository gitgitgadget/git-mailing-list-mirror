Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29689C3F6B0
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 09:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiHJJXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 05:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiHJJX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 05:23:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3C072EC6
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 02:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660123395;
        bh=lLv9BfzAlINq6phYtbdbx2ufEtEtGtGGanyg7wiMssI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ldIXBovVwC/w8Coq9cguJ7L3O+UAFY4oa7F5f6v8bVTFBHEcDdCnUS337hcxkRA+Z
         2tsWuJHiUuRpumfFEBH2ifrhRgJyqYR/3qaZkm9QCqI00lw1wslZGQK5S+RIF2lsaw
         UJeCIcjgVKzOzjwf534fQsjtH+p7blLAHEI5EuDU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.204.74] ([89.1.214.151]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1ntoEQ0dOH-00YSY7; Wed, 10
 Aug 2022 11:23:15 +0200
Date:   Wed, 10 Aug 2022 11:23:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Documentation/git-reflog: remove unneeded \ from \{
In-Reply-To: <xmqqles7odhy.fsf@gitster.g>
Message-ID: <r6orqqn6-7s7q-6023-97s3-3672soos4397@tzk.qr>
References: <pull.1304.git.git.1659387885711.gitgitgadget@gmail.com> <xmqqles7odhy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KNkD4dlPam8Kp0p20K/x0djNxNSUS553WtRRJWDbhyIesoM3GIM
 +3OMsokQSZ8O6U41YIEJ4kSKdWmG8TnXi03wi1hb3j1X2rybllhFiyYf9/mVQe835+3bRwx
 VUUNkgUjqW5M3wasmTc2hYiWkU3IQXjI/9QaWN4BG14zVEZaMYzs3S9V/83/h2N7RJgb0Zu
 uZBxQesMr9dzbtiTEJzYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8WNJnTZwKMc=:3JipWeX8x79jnXBGBb1pD2
 DcRQNc6l0s0ndCf+KTwXiH6NJH8ry2kEU02a2zHji+XMmokTAC+Hd04qj9oe7uvK3Kmgr5MEP
 XQHgeUcXJEwbw/riqTPXfXT01/GktM3Nctvgqn1mn3z5HM6wmUuIE1f1XiiO8hHnrdC5G7cu4
 sd65UPc4qtuOKixWqN8jbool9DdkirO+UDgibGxKiCYtAogMXuKFluSQyRF6CDTqumyu79tP8
 +Eqc/ZxJzBS5cbBZVYTNeC8KGs1F47IY58A3H3yeQ7jzk9uWhs1QEh/mwTXouiZyCzD9xUOs2
 +1hUdkYeqs4S/KArk8i9WLyGooIczYy4W3htjsw+EsSiiY+iZYScFjLS+MGMDEyc11bQjJWQD
 VQF+Qdc/hYt3j6H39J5TL4Cnh+LwKWUbBq4vmBQJl0AYy2y62HoE0m9IBs94xMmXOPOZTt4TD
 6sNEuUnpnLXM0YfbssC5uc0zi54RYuN+zg8Zko4Wkzy7eRioVd71h30PH7sK2PqtcNispiZw6
 8JtuxDx8GXUZc9cI3WB0J+hNjf+9ZA1Mrsjs4mKvIq+43/ZfEIESBnuaV3Fzpu1FQkK7sRcfz
 RbXsOL3kZ3wWAukLB9XLKouN4VI35z4oWH5gdi/nbKE043fM8ukLRKN6LMaTqeBtYb3drw6cU
 e2jPMzu4JZcX4L/upuWkQLfJKu3TRZL63coDBp8q4Bya7WiRqPkjVCddG7AkHMeNzyUCbC911
 Tgrxuke/k1qRrvwAKUbJs1SCJ0BAe2LymL+Vd8rXHgOPNe0uWH0XJ8lgTO5Ob/sbr1KtB7pmI
 6hkldiUM5ibtTg0vLoV1WrMKnwWikGl+fP/24OOm1VyShXWnSNKTGnAoJvYJddgHwEQgxt1vd
 k4gfhauOaVK0+0BLNbnfSkYJ+4VkmyBkdEWJf7ZnshM7bjsaI//KZAR3g2GaodQKIbAyW3swF
 C5OsrdKwoZ6E3yGkJQG13wXpXY6pO8Iq4wVlZj2QO81yIBFefGwqvIEGaFwKsuWKQdkB2EIqo
 R4A9hhza0VJA7stWEWtT87s9wrPXb2pU4VgyTQVESD9H3GuJpxeTqOEl9T7VPloz1EGpN+IyC
 2zR8AohapjlB0A0ihyxPKy8hFOALdq9nWIWihHfMyZc1xqwSyu2ab7zWw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Glen,

On Mon, 1 Aug 2022, Junio C Hamano wrote:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Fix this inconsistent rendering by removing the unnecessary "\" in
> > Documentation/git-reflog.txt.
> >
> > Signed-off-by: Glen Choo <chooglen@google.com>
> > ---
> >     Documentation/git-reflog: remove unneeded \ from {
> >
> >     I noticed this inconsistency as I was trying to build Git docs wit=
h
> >     Google's internal build system. This string seems particularly
> >     problematic e.g. you can see unnecessary "\" on
> >     https://git-scm.com/docs/git-reflog#_description.
> >
> >     I'm not proficient in asciidoc at all, but I suspect that this isn=
't
> >     tied to the asciidoc version; I initially observed these differenc=
es in
> >     environments with different versions of asciidoc (9.0.0 and 10.2.0=
) but
> >     I can't reproduce this at all on my Mac using different versions o=
f
> >     asciidoc and asciidoctor from Homebrew. Perhaps the issue is in so=
me
> >     underlying library?
>
> Thanks.  ref@\{specifier\} came from 552cecc2 (Teach "git reflog" a
> subcommand to delete single entries, 2007-10-17) but that is so
> distant past that the world must have changed too much that past
> experiences would not help all that much X-<.

Oh wow, what a blast from the past. I indeed do not recall the specifics
why I used that backslash, maybe it was needed back then. Or at least it
did not hurt back then.

Here's my ACK in any case,
Dscho

> There are too many moving parts, older and more recent asciidoc, plus
> asciidoctor.
>
> Those who care about gitman.texi may also want to check the end
> result, as the toolchain there involves docbook, yet another moving
> part.
>
> Will queue.  Thanks.
>
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-=
1304%2Fchooglen%2Fdocumentation%2Fbackslash-brace-asciidoc-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-130=
4/chooglen/documentation/backslash-brace-asciidoc-v1
> > Pull-Request: https://github.com/git/git/pull/1304
> >
> >  Documentation/git-reflog.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.t=
xt
> > index 5ced7ad4f8b..db9d46edfa9 100644
> > --- a/Documentation/git-reflog.txt
> > +++ b/Documentation/git-reflog.txt
> > @@ -22,7 +22,7 @@ depending on the subcommand:
> >  	[--rewrite] [--updateref] [--stale-fix]
> >  	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
> >  'git reflog delete' [--rewrite] [--updateref]
> > -	[--dry-run | -n] [--verbose] <ref>@\{<specifier>\}...
> > +	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
> >  'git reflog exists' <ref>
> >
> >  Reference logs, or "reflogs", record when the tips of branches and
> >
> > base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
>
