Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0F71F597
	for <e@80x24.org>; Sat, 21 Jul 2018 21:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeGUWjf (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:39:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:42423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbeGUWjf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:39:35 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lip2P-1gJ4f0132D-00d0Rf; Sat, 21
 Jul 2018 23:45:15 +0200
Date:   Sat, 21 Jul 2018 23:44:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v3 16/20] range-diff --dual-color: work around bogus
 white-space warning
In-Reply-To: <CAGZ79kbG0QZZSstC85pqSPS1awXq44vsBSvn_gfgP=22fdpzcA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807212314390.71@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <dfa7b1e71f7a39dfa608e1e205579d3b95d8a34f.1530617166.git.gitgitgadget@gmail.com> <CAGZ79kYQTTjipfBn3oAbpjZGnszWNiTKN3Ai4Pp-QA+i_xigbg@mail.gmail.com>
 <xmqq601ocecs.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807101149130.75@tvgsbejvaqbjf.bet> <CAGZ79kbG0QZZSstC85pqSPS1awXq44vsBSvn_gfgP=22fdpzcA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Wyqcxr7fVXvi7HkYpW6b6oQ9rc6dgLtEwIi9Eji8nwrvM/meHpX
 nhnysZAz0JnzahpRY23N187giYM9G8i0nSIqZgSbnn0H9yTCDewpqVdvXtM4szDf1BnHcTE
 SKmBisEVrIpOO067V4pbTGh0RYwnN4Dc7xyXokirpONzvI4MDSay6qWoHbcOgYh0O1ZdC4o
 RiEQv8Oxr7fGvjVpvHCsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gZNxGs7G4n8=:gEVFTvSPI/eGm8Fm0Elk2C
 RPKt7LNnd2A/kolklWXZEJ++R7JV48ACddCjfGEqXsRD8J1eVyzH3X4x5jbTcDeRyrEuwjZFV
 hrY9Cv7YXi4eqwwO2x0EUqP9AfwIKj0YW5pYmKMg0mwUzBBTbbiPybtxpDTgjUqV1RxubwptL
 VmEs90GALVLJkTjIatdmc7XOm5/h1qncqZRbGkRUO94rnmWV3/haWo3xlPSnxsqBtKYehfGxk
 U3Gm6APClH8G1sxWPAqEKdg5urK0iduQnf+4mThILNYNmE1rIZqLoGri5LGxMaEX7i8Nz+6hd
 1Wrad+mCul3M2XuJMmObs0tm8Qh97YYkgdhQdWd75/xJR84gXOIyc78r1ri/oYm/zxTusNlGz
 Ks5Uohx+4BehYtHL9n8D3EMVbG9pHfYLMOst+Y9gqbRpOaQhZume8ZHxHkDp3aTk0SquXaqaV
 kTLideBD7rCl4qwVvhcq8wqCoMF3u2qkeyJlj2F9VzLs5qj1lwQtGsu/Klieh0KTh7z+pdZa0
 hReRuwfrd/J0aVimmL3EFQ/AtcMImaxa4uohMx5cBSabMDzbKJ2nJBPvrR2WNQluvX1NpZ5fO
 SZkgqKQ6nTB3xLN5AyTZ1uljU/Tc0+cdkcqPw2YucGSlvBZ9QIPWzvfhtVcLon2LKFLdZJpjU
 2oyrlWaiYxIH6991zmk2nIPFs/OilYfr9yAsqt89n8s0FmCFKPCAP3irRdasF2y6yT2owZLUO
 MR6OUa1d1HEZ9i/JjAniOvUKMnBMU5BnfdTkUSvYcoopzxa/HPra5HMAhFkshRCh1AdD+i5WK
 KTdiNm7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Tue, 10 Jul 2018, Stefan Beller wrote:

> On Tue, Jul 10, 2018 at 3:08 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 9 Jul 2018, Junio C Hamano wrote:
> >
> > > I also wonder if we should be feeding the context lines to ws.c
> > > machinery in the first place though.
> >
> > It *is* confusing, I know. The entire "diff of diffs" concept *is*
> > confusing. I just don't know about a better alternative.
> 
> I agree, but I am sure we'll get used to it quickly.

Maybe you. Not me, though, I use range-diff extensively, and I still got
confused quite a bit.

Until, that is, I implemented the change where the "old-only" changes are
dimmed and the "new-only" changes are displayed in bold.

(The colors stay the same, it's just that the brightness indicates whether
this is a change that was made obsolete, a change that stayed the same, or
a change that was introduced in the latest iteration.)

With this change, I am quite confident that I read the range-diffs
correctly all the time.

> > So hear me out, because there is a big misconception here: there are
> > *two* levels of diffs. The outer one and the inner one.
> 
> Yes, the inner diff is just input that was generated before because it
> is so convenient to generate. Recently when using this too (back then
> when it was called branch-diff), I came across the following:
> 
> Patch 1 looked like:
> 
>     line 1
> +    new line
>     line 2
>     line 3
> 
> and in the next iteration it looked like:
>     line 1
>     line 2
> +    new line
>     line 3
> 
> such that the diff of diffs showed the move correctly, but as the inner diffs
> had different context ranges, other lines looked like added/removed
> in the outer diff, though it was both context.
> So I wonder if eventually (not in this series) we want to tweak the context
> lines, generate more than needed in the inner diffs and cut them off in
> the outer diff "at the same line".

That would be a welcome improvement, although I fear that it will be
relatively intrusive. For one, you can forget about using different
diff consumers (such as word-diff) if you hack up the diff of diffs
generation at *such* a low level.

> I digress again w.r.t. white space.
> 
> > Context lines of the outer diffs have no problem [*1*].
> >
> > The problem arises when the outer diff shows a - or + line (i.e. the line
> > is present *either* in the old patch set or in the new patch set, but not
> > both), *and* that line is *not* a context line of the inner diff.
> 
> So an actual change in the patches; an incremental reviewer would want
> to spend most care on these.

Precisely.

With above-mentioned dimming/brightening, there is a strong visual cue to
focus on those parts.

> > Let's illustrate this via an example. Let's assume that both the old patch
> > set and the new patch set add a comment to a statement, and that the
> > context of that statement changed between old and new patch set. Something
> > like this would be in the old patch set:
> >
> > ```diff
> >         int quiet = 0;
> > +       /* This is only needed for the reflog message */
> >         const char *branch = "HEAD";
> > ```
> >
> > And this would be in the new patch set:
> >
> > ```diff
> >         int quiet = 0, try_harder = 0;
> > +       /* This is only needed for the reflog message */
> >         const char *branch = "HEAD";
> > ```
> >
> > So as you see, both old and new revision of the same patch add that
> > comment, and it is just a context line that changed, which a regular
> > reviewer would want to *not* consider a "real" change between the patch
> > set iterations.
> >
> > Now, let's look at the "diff of diffs":
> >
> > ```diff
> > -       int quiet = 0;
> > +       int quiet = 0, try_harder = 0;
> >  +      /* This is only needed for the reflog message */
> >         const char *branch = "HEAD";
> > ```
> >
> > Please understand that in the dual color mode:
> >
> > - The first line's `-` would have a red background color, the rest of that
> >   line would be uncolored (because it is a context line of the inner
> >   diff),
> >
> > - the second line's `+` would have a green background color, the rest
> >   would be just as uncolored as the rest of the first line,
> >
> > - the third line would be a context line of the outer diff, but a `+` line
> >   of the inner diff, therefore that rest of the line would be green, and
> >
> > - the fourth line is completely uncolored; It is a context line both of
> >   the inner and the outer diff.
> >
> > That's it for the diff colors. Now for the white space: The first two
> > lines start with a `-` and a `+` respectively (outer diff marker), and
> > then most crucially continue with a space to indicate the inner diff's
> > context line, *and then continue with a horizontal tab*.
> >
> > As far as the inner diff is concerned, this *is* a context line.
> >
> > As far as the outer diff is concerned, this is *not* a context line.
> >
> > And that is the conundrum: the whitespace checker is called because the
> > outer diff claims that the second line is a `+` line and the whitespace
> > checker has no idea that it should treat it as a context line instead.
> 
> Spelled out this way, we might want to add more symbols to
> enum diff_symbol, such as
>     DIFF_SYMBOL_DUAL_DIFF_PLUS_PLUS
>     DIFF_SYMBOL_DUAL_DIFF_PLUS_MINUS
>     DIFF_SYMBOL_PLUS_MINUS
> or so.
> 
> These would need to get generated when we create the diff of diffs
> in emit_{del,add,context}_line or even fn_out_consume; and then have
> their own treatment regarding white spaces in emit_diff_symbol_from_struct.
> 
> I am not sure if that would help for the series as-is, as I am thinking
> already how to move these diff-diffs in-core (as that would help a lot
> with the context line cutting mentioned above).

I settled on _DIM and _BOLD versions for CONTEXT, FILE_OLD and FILE_NEW.

> > I'll try to find some time this afternoon to study Stefan's reply, as I
> > have a hunch that there is a deep insight hidden that helps me to figure
> > out the proper path ahead (because I do not want to uglify the `diff.c`
> > code the way my current iteration does, and I'd rather have a way to color
> > the diff more intelligently myself, in a function in `range-diff.c`).
> 
> I considered trying a cleanup on top of your series as I had the impression
> the move detection added some ugliness as well.

I will be glad to review the patches after this coming week. Should I
forget, please remind me.

Thanks,
Dscho
