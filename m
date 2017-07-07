Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEE76202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 11:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbdGGLNN (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 07:13:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:65322 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750768AbdGGLNM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 07:13:12 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3igT-1dkpYQ1H6H-00rJRh; Fri, 07
 Jul 2017 13:13:07 +0200
Date:   Fri, 7 Jul 2017 13:13:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael J Gruber <git@grubix.eu>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t5534: fix misleading grep invocation
In-Reply-To: <22feab0a-ca75-2aea-1ec9-2f71fe40c9d0@grubix.eu>
Message-ID: <alpine.DEB.2.21.1.1707071259550.84669@virtualbox>
References: <936f43ce2c993e545deaee5e196c018933375214.1499254650.git.johannes.schindelin@gmx.de> <xmqq1spukfyw.fsf@gitster.mtv.corp.google.com> <22feab0a-ca75-2aea-1ec9-2f71fe40c9d0@grubix.eu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-403794951-1499425987=:84669"
X-Provags-ID: V03:K0:Wik7KnocOyrlgPHGgcC4Gnx4gpUpkbfGtN8TCC2XJMJ89Lk7VIE
 knLXnij8NvKs1OhZTkkGv0zT5fiVfeh2xldcYH0SU0YKkjZQK8dypcgScNfU16E4jCPb6+2
 Xwq8JfOFBEa4ThQPJTlK2C+wkl/dD8va6Nb6q19IXeuPpLMdFJZch4GgKiGfe7J31V3XjKj
 ZQVHQ+AcaoPhxF1gNxgQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1FJCSyXRW/8=:/1a24bwF99P1FG51KTm7+x
 PweYGVWVPVKxIAI6cYiTt2XRW6eIetu0ca9PhoQNM6kNyJzUeqfNbhIqY+7O2rl2slShRcvKS
 aSXol5gtDwEd7/4BztmjtNRT7S42ZAWROsGC3l/ST5/QnKKJ70WJl4VZ9miGA8sxHxlPdGtx7
 NQJdhGNsvNh0OWgCm+kGE+95G6R6nERaAG0Fum1DPemAPO4SdHR/ya6yD5rAlC/ZEmJHVD7ak
 U3hyS7XF004Nxlq8KWniG9xQqUWCLq54x5sWYjxdFZFB4LoAmoYYjtl11GfFhABeiMZU3/pom
 aZOJ6oEuJaCPThLAGngiw+yP0f6sstCtjszBKSvkITKLOws6No4sWAKjFSEFIke/E2Vol9IFR
 /7VKF9tGRWufH8RsmTMWsr5UqF0fcP37I9T29iTM3+SNImnPz31k+/okulXJcfOEn7CR3JA0s
 +WAfEUOLIbjZW1yGwpLV3USWtQ2NkH9ZoKGcH243oPLhDlAlNG46GXHqGM9q1CYSHVI1hkVNh
 rnEuVnfM6ZkJTDlmSpIUy1Wcle58QwFHwL0UwiaUZfzYUd/tRH0wmAn5WaYR1ulDgcgBBM/Fb
 M2N7aaqgz0RWf8wqfJyvgqIjS+3NThieGZRZZ94xiuROQryvALUISnFsroTiTBAVEIjcB5wQL
 /9PFInWCjidt7ZLJQILO6fXVJCkiMSL2z13DjB95yajwT/VjKJh25Bc1yJqWoPqh7XN9aKQn5
 CmJf8LSFS7jhg+XYIzXw34P4oy7WxDJA4QEGR5wEbipoPYos5y4zlJWMMgxrDABsI0/MBiwmd
 BunGL2+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-403794951-1499425987=:84669
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Michael,

On Thu, 6 Jul 2017, Michael J Gruber wrote:

> Junio C Hamano venit, vidit, dixit 05.07.2017 18:26:
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >=20
> >> It seems to be a little-known feature of `grep` (and it certainly came
> >> as a surprise to this here developer who believed to know the Unix too=
ls
> >> pretty well) that multiple patterns can be passed in the same
> >> command-line argument simply by separating them by newlines. Watch, an=
d
> >> learn:
> >>
> >> =09$ printf '1\n2\n3\n' | grep "$(printf '1\n3\n')"
> >> =091
> >> =093
> >>
> >> That behavior also extends to patterns passed via `-e`, and it is not
> >> modified by passing the option `-E` (but trying this with -P issues th=
e
> >> error "grep: the -P option only supports a single pattern").
> >>
> >> It seems that there are more old Unix hands who are surprised by this
> >> behavior, as grep invocations of the form
> >>
> >> =09grep "$(git rev-parse A B) C" file
> >>
> >> were introduced in a85b377d041 (push: the beginning of "git push
> >> --signed", 2014-09-12), and later faithfully copy-edited in b9459019bb=
b
> >> (push: heed user.signingkey for signed pushes, 2014-10-22).
> >>
> >> Please note that the output of `git rev-parse A B` separates the objec=
t
> >> IDs via *newlines*, not via spaces, and those newlines are preserved
> >> because the interpolation is enclosed in double quotes.
> >>
> >> As a consequence, these tests try to validate that the file contains
> >> either A's object ID, or B's object ID followed by C, or both. Clearly=
,
> >> however, what the test wanted to see is that there is a line that
> >> contains all of them.
> >>
> >> This is clearly unintended, and the grep invocations in question reall=
y
> >> match too many lines.
>
> [...]
>
> How did you spot this? Are there grep versions that behave differently?

Yes, there are grep versions that behave differently... how did you guess?

I am in the middle of an extended investigation trying to assess how
feasible it would be to use a native Win32 port of BusyBox (started by
long-time Git contributor Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy) in Git=
 for Windows to
execute the many, many remaining Unix shell scripts that are a core part
of Git (including crucial functionality such as bisect, rebase, stash and
submodule, for which we suffer portability and performance problems).

And it is BusyBox' grep that does not handle newlines in the pattern
argument to split it into two alternative patterns.

I first considered patching BusyBox to adhere to the expected behavior,
but then I looked closer and saw that the test's grep invocations actually
matched two lines instead of what I expected. An even closer look made me
suspect that the original intention was different from what the script
actually does, and for once I tried to be nice in my commit message.

Ciao,
Dscho
--8323329-403794951-1499425987=:84669--
