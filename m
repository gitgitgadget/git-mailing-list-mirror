Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5363E207B3
	for <e@80x24.org>; Thu,  4 May 2017 09:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbdEDJMZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:12:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:52182 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752991AbdEDJMT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:12:19 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lk8CY-1dcWkd3Xfm-00c8qf; Thu, 04
 May 2017 11:12:01 +0200
Date:   Thu, 4 May 2017 11:11:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
In-Reply-To: <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1705041104070.4905@virtualbox>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1705021406510.3480@virtualbox> <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com> <alpine.DEB.2.20.1705021756530.3480@virtualbox>
 <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com> <alpine.DEB.2.20.1705031139090.3480@virtualbox> <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-29158573-1493889121=:4905"
X-Provags-ID: V03:K0:P1WUBH8XfkEEfR7T+C4o+m92jPK2WklnuptGCXsQBh/1qvtftKU
 HKSWf+A7seAyFr2vD43g7yZSiaor21SACfr4BoCmecrXJ2wZYjmMLXXBsbq2w9jiLuUiwZO
 BvE6Yj3DKFY+dXVvOMmuHsuqtUURSVaXY2rslGtJKbnSH1hs8rrLO9JkObyJI8OpVncBXxC
 xT8u+ZcGpn1ct89tYRa+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZC/YtdIb98I=:ParPp7w/qwM/bEu6/4KcfH
 BbbpgGv8Eg8ydzxB9g3kc7iWd8sxiBdlnMCrleqaiexVGwHgbZL9j3YEdZFttGxexBzyXAkJp
 wfbcepwr9hQPB+hD9NNl7MUqg8tCdZ6YDfMdsag6nmUBW83Ex5nYJ6K2LY9ccPemRhzaQ7MZS
 us00VG73hY8y2BfgKPqAJcd/iXVvGqVfDAg6lQwlRSYNI2yQE8DaIJvtikY2ULwAzFJMDvghg
 NnCvjfucuBmfBkQh1BentEf8ii6WDNfHO6Lb6g4QeIpcCj/Cv5+DgBVFVLkB9f+1ZqiZOns6L
 LBLPSNCi4iKCY4dpfiA8aKesc32FuKVtX3FVB8PN0SWfpGJkYLX6olloochN86gAWYuMy3mOX
 7JR1QvP/kAr+0MOsliE2SwyiIq0HuFnGouHBrlYabCSFUzRFlDGiDw1RIIXngM0GgTO5I6vxr
 eXDkpltZQPzk0yr0vBBCC+ryDFRmYaWh5BSbcazYaSEmYOCwzt8Livwn4pNRRTRBKDd7NCa6/
 V/CKkBa9PCNLgnI5gWVdzvEo0C9ORvT8arxvNnzXTOzhcxtBLubg0ygmoTZvEKB5yTEHkbTNi
 8/566iTAw0kZRukRllzKvjyF4/KkOFy3mmtzmZvMMYE5qGiL0oNj2grw9JqPSI34DnVQZAzUY
 saZD6F+E55pViU1qfD9/LgrNcV4icBW5FKM1m+ayCF2bibLSLRr+kIihnUJS4Nq2YAR1gA43/
 shbTwpbegPThncj8eMyAGdmAyljpL1Ke7kuMV5IXYsQ5P2nmJ4HFs72CWzlMauyJIOrthL1Iu
 KUkNDg5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-29158573-1493889121=:4905
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Wed, 3 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> [Just replying to you & Duy in the same mail, easier]

It makes it harder on everybody else, though, as two slightly different
discussion points are conflated now. Also, no single online mail archive
will be able to render the thread correctly (assuming that you edited in
the In-Reply-To header to loop back to Duy's mail).

> On Wed, May 3, 2017 at 11:45 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > At this point, I feel that someone should recall into our collective
> > memory what happened when we made a change similar in nature that
> > broke existing build setups: by requiring REG_STARTEND all of a sudden
> > ("you can easily flip the NO_REGEX switch", as if everybody should
> > know about those Makefile flags we have).
>=20
> And as a result grep/log -G got faster by default,

Sure. For those developers where the build was not broken.

Software maintenance is always a trade-off, and with software as popular
as Git, maintainers bear a special responsibility to *not* break builds
easily, as it is more likely than not that anybody who wants to build Git
is *unfamiliar* with the specifics.

That is the main reason why we have a configure, even if we try hard to
make things work with a straight `make`: people who are happily oblivious
of our discussions on this here high-volume mailing list will be able to
build Git without even consulting the documentation, just by doing what
they would do with any Unix-based software: ./configure && make

> and more importantly since v2.10.1 which includes your 2f8952250a and
> made a REG_STARTEND engine a hard requirement nobody using git is
> mysteriously going to miss grep results because of some stray \0 in the
> string being matched.

That is a misinterpretation of what the REG_STARTEND flag is supposed to
do. In *some* implementations, REG_STARTEND allows NULs in the haystack.
Some other implementations do not allow that. It is ill-defined.

> I agree that I should drop the patch to make v2 the default from this
> series for now. Clearly it's controversial, and can be considered on
> its own merits once the supporting code is in. I'll do that in the
> next submission, which I'm planning to send after v2.13.0 comes out.

Good. I am really glad that we agree that the move to v2 should be a
two-step process, with the uncontroversial "optionally use PCRE v2 for
speed and robustness" first.

Once enough users like it (and speaking for myself, once I heard from
enough users how good it is so that I can justify to set aside enough time
to support PCRE v2 in MSYS2), you will find it much smoother sailing to go
to phase 2.

Ciao,
Dscho
--8323329-29158573-1493889121=:4905--
