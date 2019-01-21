Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C55E1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 18:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfAUSUA (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 13:20:00 -0500
Received: from mout.gmx.net ([212.227.17.21]:42345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbfAUSUA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 13:20:00 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8pKi-1gvZH23Ejc-00CBXZ; Mon, 21
 Jan 2019 19:19:52 +0100
Date:   Mon, 21 Jan 2019 19:19:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v4 5/8] git-rebase, sequencer: extend --quiet option for
 the interactive machinery
In-Reply-To: <CABPp-BFrgjW-c8NKGYKs1VaH--Oc8yUu0enQMSp1pQVUwBOBwA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901211916400.41@tvgsbejvaqbjf.bet>
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com> <20181211161139.31686-6-newren@gmail.com> <nycvar.QRO.7.76.6.1901211709090.41@tvgsbejvaqbjf.bet>
 <CABPp-BFrgjW-c8NKGYKs1VaH--Oc8yUu0enQMSp1pQVUwBOBwA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rJlzGUYXD2F3nge+ku30l67uJLy/mCTo/MeSbfu+iJ1Hs89xBqR
 x9C5zkUloh1LuAhwKwRXAr1H4zfuA69H+hEjp344QMd7hAMKFWSA8bhY17tfjpeCGjZifDJ
 Hb0rmOq8YvkUcikMxcufj4+Sxbgz2EYlm7rXkCGTHVdKKTkxq1lniztZa2zXkyuyKaELfjh
 t6JGfSE7udIDXht7JRgVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JEjsaFAApuA=:iayQTx6GGii33NoS9OiT3O
 wEszmUoTl5jCX33hUgclzcyV40THv5ORPqwni5zgOF0nJ0vjyPgJme9lUjpFQib0Ef+6nglXV
 niwtPirQJxlvS7WwbIDgGj73s/2WUDrSpSLWtpp5aFG1K5UccTbypiX/RBjGRsVatn8iFucCY
 NHiMDVB42G26tOFgXPq14/LT0CQ/hJiw6994QTsb+CI2kKbcs3J1dlV4TtDTsqWrI2bso6SE5
 cONMPGOD18G3bLZCK97MsU14Dhjl2bT7fP1F8M/nrB+9wp9PFeYDR1cIY/idJtpB9as3OWBrE
 Lgdjmfp2yP4mSFAF6S2A5I/CBk1p04h8JUamETBl8aVNo+kKUI/f3KC+1Cf3UWEw82JZbzGJr
 XrLT4JKXUO/O+TC3HvpF2Teyqsu9JZMbHbpfcHWHYzFsJOcge8TQeInbpAUIXR0a0ecON7M3q
 y0KjxFtYZ9y+VQU3iEH7P4R5a8rgffNNEzzumFysIHyayz1CZnUjjbwSyaQSKFCIjZa7bv3YL
 cKQNSVQnM0CSGLTEyW6Xa4fqQZ1ft7Oi/2ZxaCTDq+4XGiRTdmynBJjGb4tq+ilVj3GsNPF0b
 lOBaRmYr/zPnSAAARGHhpWa2CeZfOumo12UgX2wl7N4nTse/UQ06HpXpqoo9Rd0+CbkzEn3M8
 BpCpc9xGOLyQt79CxgxKRG7NaEAHfvFvR3tPWhXMGDWYoEugh8awSegZUeV49+e1KNS7+aAwo
 fppq/w+tXbTyWxbJ+dvkAVkEf1LJSIPIWQ0yGBYq4DUAenYevbRVenDfo0YBtDKKILi9fsNAp
 qGqEyWIj2NPG2zyMQJ5IzyFXp1PUT1TfyunOQofh6vGqWLeFXnqrgH7i9kJ93RqPsuvxnFMs2
 kliWeh/ThEChAv6/Z2OTqjk9KeocJvo8l+Mc1TzvGGwlQuZBIc+avhd5Y0acskS+USRQaPcWt
 wIUVgJfy0Qg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 21 Jan 2019, Elijah Newren wrote:

> On Mon, Jan 21, 2019 at 8:10 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 11 Dec 2018, Elijah Newren wrote:
> >
> > > While 'quiet' and 'interactive' may sound like antonyms, the interactive
> > > machinery actually has logic that implements several
> > > interactive_rebase=implied cases (--exec, --keep-empty, --rebase-merges)
> > > which won't pop up an editor.  The rewrite of interactive rebase in C
> > > added a quiet option, though it only turns stats off.  Since we want to
> > > make the interactive machinery also take over for git-rebase--merge, it
> > > should fully implement the --quiet option.
> > >
> > > git-rebase--interactive was already somewhat quieter than
> > > git-rebase--merge and git-rebase--am, possibly because cherry-pick has
> > > just traditionally been quieter.  As such, we only drop a few
> > > informational messages -- "Rebasing (n/m)" and "Successfully rebased..."
> > >
> > > Also, for simplicity, remove the differences in how quiet and verbose
> > > options were recorded.  Having one be signalled by the presence of a
> > > "verbose" file in the state_dir, while the other was signalled by the
> > > contents of a "quiet" file was just weirdly inconsistent.  (This
> > > inconsistency pre-dated the rewrite into C.)  Make them consistent by
> > > having them both key off the presence of the file.
> > >
> > > Signed-off-by: Elijah Newren <newren@gmail.com>
> >
> > This is convincing. I would like to point out, though...
> >
> > > ---
> > >  builtin/rebase.c      |  5 +----
> > >  git-legacy-rebase.sh  |  2 +-
> > >  git-rebase--common.sh |  2 +-
> > >  sequencer.c           | 23 +++++++++++++----------
> > >  sequencer.h           |  1 +
> > >  5 files changed, 17 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > > index 78e982298f..ec2e5fbf23 100644
> > > --- a/builtin/rebase.c
> > > +++ b/builtin/rebase.c
> > > @@ -185,10 +185,7 @@ static int read_basic_state(struct rebase_options *opts)
> > >       if (get_oid(buf.buf, &opts->orig_head))
> > >               return error(_("invalid orig-head: '%s'"), buf.buf);
> > >
> > > -     strbuf_reset(&buf);
> > > -     if (read_one(state_dir_path("quiet", opts), &buf))
> > > -             return -1;
> > > -     if (buf.len)
> > > +     if (file_exists(state_dir_path("quiet", opts)))
> >
> > This changes the behavior. AFAIR the `quiet` file was always written, but
> > contained `t` in quiet mode. I have to interrupt my review here, and will
> > continue later, but maybe you will beat me to looking into that.
> >
> > Ciao,
> > Dscho
> 
> You are certainly consistent;

You flatter me!

> you commented on this exact same issue in both v1 and v2 (you didn't
> have time to review v3). In v2, your comment was[1]:
> 
> "
> I am slightly concerned that some creative power user could have written
> scripts that rely on this behavior.
> 
> But only *slightly* concerned.
> 
> The patch looks correct.
> "
> 
> Also, I have a fuzzy memory of discussing a very similar case with
> some rebase-oriented option and its on-disk representation, where the
> concern was more about users upgrading git versions during an
> incomplete rebase rather than power users looking at internal file
> contents.  And I think either Phillip or Junio made some statement
> about considering these internal details and that they felt the worry
> about upgrade mid-rebase was overly worrying.  But I can't find the
> emails right now, and it's been so long (at least half a year) that I
> might be imagining things.

Indeed, it was one of Phillip's patch series that fixed an incorrect
quoting in the author script. And we eventually all agreed that it would
not be worth the trouble to take care of upgrade-spanning rebases (both
Phillip and I spent some time to make it so, IIRC).

> But from first principles, in this case even if you're worried about
> power users reaching into internal files of rebase or about users
> upgrade mid-rebase, at *worst* people will get or lose a few fluffy
> progress-update messages.  To me, that's an innocuous level of change
> that's certainly worth the risk to allow us to get rid of the annoying
> differences in implementation of handling of different options.  But,
> if you strongly feel that's too big a risk, we can remove the part of
> the patch making verbose and quiet be handled consistently; it's not
> critical to the rest of the series.  I just thought it was a good
> cleanup while I was touching the area.

I think you are correct. It is much easier in C to check whether a file
exists than to read it, parse it and determine whether its Boolean value
should be `false` or `true`.

So color me convinced that your clean-up is worth it. Maybe, just maybe,
if you submit another iteration (and only if), could you add a little
paragraph for future Dscho to understand that this clean-up was slipped
in?

Thanks,
Dscho
