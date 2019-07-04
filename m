Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6CB91F461
	for <e@80x24.org>; Thu,  4 Jul 2019 21:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfGDVat (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 17:30:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:59379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfGDVat (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 17:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562275842;
        bh=i0oDkJ/12md8WNJ8hbqeOYodsu9vT5WECDFWjJWs3gU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HKkB6PzfFVb1pDQOCFBfXYZ44UdjhO+h9WA3qKNJPtFSw/unPSWxcSpCJUundUjcY
         U12FpPRNr/tdRYPUyrJjKVVwT4kKM0saGrX32BwUsk8EOUloXhnRxImaeYl4FOZ4AF
         W4O1vf4utOi5SYHMZJ7o9ew9YEo5nwvPTyLD4tIE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LrePN-1iflmu3i5V-013OFJ; Thu, 04
 Jul 2019 23:30:42 +0200
Date:   Thu, 4 Jul 2019 23:31:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: mt/dir-iterator-updates, was Re: What's cooking in git.git (Jul
 2019, #01; Wed, 3)
In-Reply-To: <CAHd-oW6s1kGJqaRhm2f5ZG1C48upZu8ypeB_rw7do2=Vi3jZqw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907042308200.44@tvgsbejvaqbjf.bet>
References: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907041136530.44@tvgsbejvaqbjf.bet> <CAHd-oW6s1kGJqaRhm2f5ZG1C48upZu8ypeB_rw7do2=Vi3jZqw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lSkYZO6vN1flW+QvDKPAESA3x9RAB4WCRFFhkqZgAsiZNxu0RmK
 BPtwH8zHTO22uTWq82xaKev7JrOksoGIEQA4L9/B9wPUln40TYSs0VYua4e3hmrTFSWXQ9+
 AKjEHikbuifF+casxMnuHD5HwpmxWGSWoFuVGVo8IUnGjZfAhXbuQMx+6OFVAYonaF82oQ5
 HeN9UqWu5kyDNQQq2rgLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hbGpFIpK6Oc=:6SA/9688i5MP8hIzTyTuRd
 gBfmbcTft9orBYjpWiOamVCFuk1Z84tmk0TBA75YctbOW1D/l0rtxJOLjS5Ejy+n+jqDuzW28
 q/Hd4u8Y7FoLreIl1+lB6nFavgOS12DmeWoxXhRVCFarrr+9ROqEIp/Iy3FC8yqzDb1dxr7hW
 FRtgOEUEwoT8SV7XC953HHnyOLSUPMPPuPZCy5oSzlIwb436JbAOcxQxx2hraGVhbBiUE2t7J
 ic1tc274A7BVVEo60fWnv68uS0vPyZWS8/TRBBFXFUoPy7HMimIXufRyJuIjdAR+zD6UhNLPQ
 +0WmSylh3+sxlq4MOLy1dIaSYKjHeNLbhV+8R2P1UH75Gxbdb/UQzDJYZUr6CGfne2A+sO4Rk
 2QdI8aIOz16rFZDE+ovflh4cgClz1KsYXfWJnkDT98rTDQK+8Dqq7lwkeih0uAhV7OASnvM/Q
 aoOuX4qGuWfnaCCfmohlDrTyWtb12ZMEWMVJbtKoyct3achgT7YCqM7N0rSv72by6y2vpDK8p
 jsQhYbh0u0Kqp4aUepr8iNYi1lcz7t+9LypPuaLHlcFZWWhjLrCnWVLihuMj152WJF2M2n9Lw
 WO/acxKc5s2RKNcogPoLCLqvhISaDsq4U8OAECjNYjBADBL7OeV0TxaS4FYLjr218VolhvmTC
 OmPCINtYANbyf5H11I4wVTD/vwnBg82CRuezgIpnJr3QV3K/86nIQaTwv5EKQTlVX5/jnivz1
 vXs4+Gxhy8hnQsE2wHom5QW4HLjBpw+lnQc1lOl/M3Yfk+61eSTTU3wJNuR05hE+MyPICN+B6
 CL2Voo0K7un2d6v405nKRGQmabniOUuoPU/sP4nq1FAcpbdtPgTOnGeqdRzMG6U7H9lnxo0rN
 LQMP2XwS6GYP+a9A8rb5J7OSZQA0SP4mHFDea/a8NbZWJn0q2XjiRBkfVRr7dtu/TMCaPreSo
 1GGr+abkXOuLyQkxG59BgHi1N6xixGJ4Lx/ZWWVRYUXiMApqK7Tu05pzv4DyHwh/xLm68MhXM
 d7/LvJjx1Nm5s7HkCJm028mlDTIgq1gkWttaTw8HO9PJ4wU/971NGCQuOvqDYGaE26hPNZ5pq
 +e/7uefM5LAGJvPCvQZ6rgO8zPg0pgGFWcb
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Thu, 4 Jul 2019, Matheus Tavares Bernardino wrote:

> On Thu, Jul 4, 2019 at 7:02 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 3 Jul 2019, Junio C Hamano wrote:
> >
> > > * mt/dir-iterator-updates (2019-06-25) 10 commits
> [...]
> > >  Is this ready for 'next'?
> >
> > No. It still breaks many dozens of test cases on Windows (if not more)
> > because it thinks that it can rely on `st_ino` to detect circular
> > symlinks.
>
> I wanted to take a look at the failures to see if I could help, but
> I'm not very familiar with azure (and travis-ci doesn't run windows'
> tests). So the only build I could find, containing the code from this
> series, is this[1]. But it only shows 4 failures and they don't seem
> to relate with dir-iterator... Could you point me to the right place,
> please?

Certainly. In
https://github.com/gitgitgadget/git/branches/all?utf8=3D%E2%9C%93&query=3D=
mt%2F,
you will find the red X next to the branch name `mt/dir-iterator-updates`,
and clicking on it will pop up the list of jobs (including the failing
ones).

If you click on any item, it will first get you to the "Checks" page where
you can find the link "View more details on Azure Pipelines" on the bottom
of the right-hand side pane. This will lead you to
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11495

I usually click on the "Tests" tab in that page:
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11495&view=
=3Dms.vss-test-web.build-test-results-tab

You can click on any of the 1,384 (!) failing test cases, it will pop up a
pane on the right-hand side that shows the trace of that failing test
case. For the full trace of that test script, go to "Attachments" and
download the `Standard_Error_Output.log` (via the horizontal bread-crumbs
menu you can see when hovering over the file name).

> > In
> > https://public-inbox.org/git/nycvar.QRO.7.76.6.1906272046180.44@tvgsbe=
jvaqbjf.bet/
> > I had suggested to do something like this:
> >
> [...]
> >
> > However, in the meantime I thought about this a bit more and I remembe=
red
> > how this is done elsewhere: I saw many recursive symlink resolvers tha=
t
> > just have an arbitrary cut-off after following, say, 32 links.
> >
> > In fact, Git itself already has this in abspath.c:
> >
> >         /* We allow "recursive" symbolic links. Only within reason, th=
ough. */
> >         #ifndef MAXSYMLINKS
> >         #define MAXSYMLINKS 32
> >         #endif
> >
> > But then, the patch in question uses `stat()` instead of `lstat()`, so=
 we
> > would not have any way to count the number of symbolic links we follow=
ed.
>
> Hm, I think `stat()` itself uses this strategy of an arbitrary cut-off
> when resolving a path. So we may also "ignore" circular symlinks and
> let the iteration continue until the point where `stat()` will return
> an ELOOP. (But it may be expensive...)

This would not be equivalent, though, as your code also tried to address
circular references when two or more symlinks are involved, e.g. when
one symlink points to a directory that has another symlink that points to
the directory containing the first symlink.

> > Do we _have_ to, though? At some stage the path we come up with is bey=
ond
> > `PATH_MAX` and we can stop right then and there.
> >
> > Besides, the way `find_recursive_symlinks()` is implemented adds quadr=
atic
> > behavior.
>
> Yes, indeed. But it only happens when we have a path like this:
> `symlink_to_dir1/symlink_to_dir2/symlink_to_dir3/symlink_to_dir4/...`,
> right? I think this case won't be very usual on actual filesystems,
> thought.

No, the check is performed in a loop, and that loop is executed whether
you have symlinks or not. That loop is executed for every item in the
iteration, and as we cannot assume a flat directory in general (in fact,
we should assume a directory depth proportional to the total number of
files), that adds that quadratic behavior.

> > So I would like to submit the idea of simplifying the code drastically=
,
> > by skipping the `find_recursive_symlinks()` function altogether.
> >
> > This would solve another issue I have with that function, anyway: The =
name
> > suggests, to me at least, that we follow symlinks recursively. It does
> > not. I think that could have been addressed by using the adjective
> > "circular" instead of "recursive".
>
> Indeed, "circular" sounds much better then "recursive".
>
> > But I also think there are enough
> > reasons to do away with this function in the first place.
>
> We can delegate the circular symlinks problem to `stat()'s ELOOP`

Not really. I mean, we _already_ delegate to the `ELOOP` condition, we
cannot even avoid it as long as we keep using `stat()` instead of
`lstat()`, but as I demonstrated above, that only catches part of the
circular symlinks.

> or `path_len > PATH_MAX`.

This would have the advantage of _not_ adding quadratic behavior.

And just in case you think quadratic behavior would not matter much: Git
is used to manage the largest repository on this planet, which has over 3
million index entries when checked out.

Quadratic behavior matters.

I don't know where the dir-iterator is used, but we simply should try our
best to aim for the optimal time complexity in the first place.

> The only downside is the overhead of iterating through directories which
> will be latter discarded for being in circular symlinks' chains. I mean,
> the overhead at dir-iterator shouldn't be much, but the one on the code
> using this API to do something for each of these directories (and its
> contents), may be. Also we would need to "undo" the work done for each
> of these directories if we want to ignore circular symlinks and continue
> the iteration, whereas if we try to detect it a priori, we can skip it
> from the beginning.

Given that the intent of this patch series is a mere refactoring, I wonder
why the new, contentious circular symlink detection is slipped into it
anyway. It complicates the task, makes reviewing a lot harder, and it
holds up the refactoring.

Ciao,
Dscho
