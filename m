Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5040AC2D0C2
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 20:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9A521655
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 20:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LzxHNzjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgABUR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 15:17:56 -0500
Received: from mout.gmx.net ([212.227.17.22]:40867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgABURz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 15:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577996273;
        bh=Mi7Vh9q3Dri9MraR9uMUohksbeok/1OYQjg8ejDn+MU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LzxHNzjMgFMcCcaV3YbhWjnCXeP15w7R9/nw1ABUafGxH8/xD3rL+y8E7pT59S8Qs
         eLjtYX2W1bJrQcPssSgWNvNqh2egQk5wr4UuKfSurv9uJu1byjeQ340ZRtE7o0rGDW
         9Qvqn6gnAMNPwSS3LdszzcAOMdjBO/2t1Tpu0tJ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MowKc-1jVpaJ1mX8-00qTIS; Thu, 02
 Jan 2020 21:17:53 +0100
Date:   Thu, 2 Jan 2020 21:17:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Comparing rebase --am with --interactive via p3400
In-Reply-To: <16add63e-a631-5ebf-bbbe-17823d942ee9@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001022108280.46@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet> <a00e1689-ec7c-4039-a2e9-f72d452ae4ff@gmail.com> <CABPp-BGCQR+MLVTDoaXDmPrE4SCu+dQ794X6Kvx1PpiQ=6D7KQ@mail.gmail.com> <16add63e-a631-5ebf-bbbe-17823d942ee9@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-48933659-1577996272=:46"
X-Provags-ID: V03:K1:qYuiIomGVlIXHUQi34CUtDsx3Szn3O/O5c11hHsrM3lW6ioqVTj
 xlaaYmr51/zmkUKgsU4NQSYJjW28xFbqcz6z67R63lfPJUo7QV4PaqpfHOEgmyWq8/IjnuO
 PBK16Nfj7vaC42ivmzst8qiMOI1vpFQ6ae01TgQb8J2tem34sBMDBVnpb9gTWgk61pYca+5
 SdHh6/xYZHs4/39cQrbMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u9JeMzAstZU=:juITt7yjXuxBb6CiHog1tm
 T2JYCClK+EW4QM0clQ3qRq7S7epQ4de4IkGTYefzDX+6vXSJfFlx/Ul+qZCHz1th7Aeu8BZ9d
 OvW0FbYEModvDjBP2EI5xH+0dmXxExYVNOTQdZXolE55N30FO54svO5/EwwNwysi6kVWrPgX5
 E+uPJrSyXXhz12NbixWz1Xhn/iGV9xmkF1i1alERzvxxUej0oLla+fYrnnVtzOfgkCm2DDOlQ
 ipCZ7oFjwFS8/Ahc3WsP0kPibUTWyeNUmutdjC/UNFB7cjWPZvodx8d0nRG91k4nYCtgALc3y
 aUezKsVYNz9nOqsX3sqPh/xZGMg8wvGSAOV/GgWQiTd2HQAG970TZojjg+iPR6+9mc89Q+uLy
 /4I/9/UFN/ZNxtuOgofZg2OE6Jbi0pUvcTZEuEIeQED+xJmtwmyDwGUO76ewXsL2aoUYQVpQ0
 iFsHn4O03HkgFcupk33M40S8WMDndmDQtFtBE5lbRse9GdbS1C7dWb+7OSW1mszowKObl7seI
 GVWHQIB6wZOxtL0YdKIH+K+lbNxOHrPJ/BQbP2rLS0QAR9mhIrwjMHnPc8MjHgx+/GPU07Ab5
 qHK6Q2ee7wP1eYFlPYLit6+7mh2ZPB05Kay2mQPx/VWZLDqg4gNyhFPHtTbNWJdOYApE8DRSK
 VltdMldJ/S5SuKqpb03LxjRIBbD4tYXG3bXVuv98Iw4Vmoe3IXcU8LS+XSdmSvCYOnLhATruk
 hzBqhwcuw/WZBO65vX37MaBQ1/DEp28y5ZGsogTnHkMcaEn+L4tmKNFHyRPdOaafzJqVsD3/7
 DUKV9BA0nAiRZH1Adk9hXTJBAi01rl/04zcQsgVQlO6Nx6b65jtxTPjwkyFRZXavpq/zec6mh
 2AXwKQ81UqwsJeu3PBFtWfv83DTutWigccNLoL0APK5nLRYwveDr8crDsR9qcgys6aqK57cjG
 9sUU1LD0AF4EfOpFPRMMhnkeGqBWldcVq6JI4smmRFZW4xEsl5xhd3VWf83iCfrOoTp5RC8Kw
 L+wy17knFNgF4+/Q0d3wuZq9MBfhVhLRuuC45vmQgx8621SvvL/z55gp5mLvMwh63oHWOs7Zb
 YEjfkzKnJyBI9uMeqAJGNHNi1Wn7siplobhDrRhtoHztefIoUnf4QOrPNcWwvcHqXocKtjPmK
 Np9Xk7Xamm9Sf4mdk8G6m4FddFQO3JumHDQKc950Cz58+P3s7yL1LAqMSs4S/grVDdU0VESaF
 wuAXkJcrmh8Vb9P/IrZUv03+Y+bNirj+V3+3z3rwX7O6Pds4sScoKLgO4oCo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-48933659-1577996272=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alban & Elijah,

On Sun, 29 Dec 2019, Alban Gruin wrote:

> Hi Elijah,
>
> Le 27/12/2019 =C3=A0 23:45, Elijah Newren a =C3=A9crit=C2=A0:
> > Hi Alban,
> >
> > On Fri, Dec 27, 2019 at 1:11 PM Alban Gruin <alban.gruin@gmail.com> wr=
ote:
> >>
> >> Hi Johannes & Elijah,
> >>
> >> Le 01/02/2019 =C3=A0 07:04, Johannes Schindelin a =C3=A9crit :
> >>> Hi Elijah,
> >>>
> >>> as discussed at the Contributors' Summit, I ran p3400 as-is (i.e. wi=
th the
> >>> --am backend) and then with --keep-empty to force the interactive ba=
ckend
> >>> to be used. Here are the best of 10, on my relatively powerful Windo=
ws 10
> >>> laptop, with current `master`.
> >>>
> >>> With regular rebase --am:
> >>>
> >>> 3400.2: rebase on top of a lot of unrelated changes             5.32=
(0.06+0.15)
> >>> 3400.4: rebase a lot of unrelated changes without split-index   33.0=
8(0.04+0.18)
> >>> 3400.6: rebase a lot of unrelated changes with split-index      30.2=
9(0.03+0.18)
> >>>
> >>> with --keep-empty to force the interactive backend:
> >>>
> >>> 3400.2: rebase on top of a lot of unrelated changes             3.92=
(0.03+0.18)
> >>> 3400.4: rebase a lot of unrelated changes without split-index   33.9=
2(0.03+0.22)
> >>> 3400.6: rebase a lot of unrelated changes with split-index      38.8=
2(0.03+0.16)
> >>>
> >>> I then changed it to -m to test the current scripted version, trying=
 to
> >>> let it run overnight, but my laptop eventually went to sleep and the=
 tests
> >>> were not even done. I'll let them continue and report back.
> >>>
> >>> My conclusion after seeing these numbers is: the interactive rebase =
is
> >>> really close to the performance of the --am backend. So to me, it ma=
kes a
> >>> total lot of sense to switch --merge over to it, and to make --merge=
 the
> >>> default. We still should investigate why the split-index performance=
 is so
> >>> significantly worse, though.
> >>>
> >>> Ciao,
> >>> Dscho
> >>>
> >>
> >> I investigated a bit on this.  From a quick glance at a callgrind tra=
ce,
> >> I can see that ce_write_entry() is called 20 601[1] times with `git a=
m',
> >> but 739 802 times with the sequencer when the split-index is enabled.
> >
> > Sweet, thanks for digging in and analyzing this.
> >
> >> For reference, here are the timings, measured on my Linux machine, on=
 a
> >> tmpfs, with git.git as the repo:
> >>
> >> `rebase --am':
> >>> 3400.2: rebase on top of a lot of unrelated changes             0.29=
(0.24+0.03)
> >>> 3400.4: rebase a lot of unrelated changes without split-index   6.77=
(6.51+0.22)
> >>> 3400.6: rebase a lot of unrelated changes with split-index      4.43=
(4.29+0.13)
> >> `rebase --quiet':
> >
> > --quiet?  Isn't that flag supposed to work with both backends and not
> > imply either one?  We previously used --keep-empty, though there's a
> > chance that flag means we're not doing a fair comparison (since 'am'
> > will drop empty commits and thus have less work to do).  Is there any
> > chance you actually ran a different command, but when you went to
> > summarize just typed the wrong flag name?  Anyway, the best would
> > probably be to use --merge here (at the time Johannes and I were
> > testing, that wouldn't have triggered the sequencer, but it does now),
> > after first applying the en/rebase-backend series just to make sure
> > we're doing an apples to apples comparison.  However, I suspect that
> > empty commits probably weren't much of a factor and you did find some
> > interesting things...
> >
>
> Yes, I did use `--keep-empty' but misremembered it when writing this ema=
il=E2=80=A6
>
> >>> 3400.2: rebase on top of a lot of unrelated changes             0.24=
(0.21+0.02)
> >>> 3400.4: rebase a lot of unrelated changes without split-index   5.60=
(5.32+0.27)
> >>> 3400.6: rebase a lot of unrelated changes with split-index      5.67=
(5.40+0.26)
> >>
> >> This comes from two things:
> >>
> >> 1. There is not enough shared entries in the index with the sequencer=
.
> >>
> >> do_write_index() is called only by do_write_locked_index() with `--am=
',
> >> but is also called by write_shared_index() with the sequencer once fo=
r
> >> every other commit.  As the latter is only called by
> >> write_locked_index(), which means that too_many_not_shared_entries()
> >> returns true for the sequencer, but never for `--am'.
> >>
> >> Removing the call to discard_index() in do_pick_commit() (as in the
> >> first attached patch) solve this particular issue, but this would
> >> require a more thorough analysis to see if it is actually safe to do.
> >
> > I'm actually surprised the sequencer would call discard_index(); I
> > would have thought it would have relied on merge_recursive() to do the
> > necessary index changes and updates other than writing the new index
> > out.  But I'm not quite as familar with the sequencer so perhaps
> > there's some reason I'm unaware of.  (Any chance this is a left-over
> > from when sequencer invoked external scripts to do the work, and thus
> > the index was updated in another processes' memory and on disk, and it
> > had to discard and re-read to get its own process updated?)
> >
>
> The sequencer re-reads the index after invoking an external command
> (either `git checkout', `git merge' or an `exec' command from the todo
> list), which makes sense.  But this one seems to come from 6eb1b437933
> ("cherry-pick/revert: make direct internal call to merge_tree()",
> 2008-09-02).  So, yes, quite old, and perhaps no longer justified.

Right. This commit also moved the `discard_cache()` call outside from the
`else` clause of the `if (no_commit)`.

That `else` clause goes all the way back to 9509af686bf (Make git-revert &
git-cherry-pick a builtin, 2007-03-01), and I admit freely that my memory
is no longer fresh on the specifics of this patch.

Looking at that patch, I think I simply discarded the index because a
subsequent code path would spawn the `git merge-recursive` process, which
would have changed the index externally.

> I know I had to add another discard_cache() in rebase--interactive.c
> because it broke something with the submodules, but it does not seems
> all that useful now that rebase.c no longer has to fork to use the
> sequencer.

FWIW I agree. The code is still quite complex at this point, but
infinitely more readable (thank you Elijah for taking point on simplifying
merge-recursive.c!). So I think that it might be the right point in time
to make sure that the index is not re-read and re-discarded over and over
again.

Thanks,
Dscho

--8323328-48933659-1577996272=:46--
