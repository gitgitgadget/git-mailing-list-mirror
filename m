Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 542371F404
	for <e@80x24.org>; Sat, 10 Feb 2018 23:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbeBJXGg (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 18:06:36 -0500
Received: from mout.gmx.net ([212.227.17.20]:34197 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752872AbeBJXGf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 18:06:35 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0LqF9o-1fFZ7l3VHE-00dp42; Sun, 11 Feb 2018 00:06:29 +0100
Date:   Sun, 11 Feb 2018 00:06:28 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
In-Reply-To: <874lmqirma.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de> <874lmqirma.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uSNjGBlIs1lb5uLTCEPsvHARCwetsVlh6suqoB5rdHxpIifYSCr
 keXe/5vsBQ8LAKRO56nLqoGx262yEUB3JH9C2SN2iF6AqwAbUDxnyZlMprMGb5gCLq/XYCa
 MTscdCBnXFPFlWO5XknuVoRw6iY2XJ0Lkv7PYifCPRQmXIYG179pLPogVDcQR+oLrPHE3VE
 hP7fWSXIAZH/6g0qUdqVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L6GxteBy4Go=:UflRfJHgrdiUfD0zx97nvq
 ZM2+U2o06GeZZlFnio20aEU6mohstBrp6bdG6dTex0sUrXLT79o0dzEfCHowRAU5oVbasI/vF
 ObWx6abIS5hyoB0R5VQ0hBdtm6aTcFF0rjHBKnJQvpnLSsiKeUL693tptyuEkLuLLUawm/WuC
 4mdF51WMuyJQrHuxy9+50LqXS3WUXNnBkoHFL8Fw7MB6cowiUnobjmN/rKJ3TCYsjJQACSvaA
 tt6+EKf21HpnbMyNGkETMW7WLwR/rQiFsxiEgklvOWjIdkKKga3moGcUyCZyrJqrg2U/uVbpj
 pc3liGfeihxAQaaLiv4f3xYPbQTR0PzrnkSV/r6fbIGhqnhr6rRGakaM3eDQuL0/zjWBf2Mdm
 YBXtzvUU9setV5N3z/tiDaDch1AZfZ2GU0mYrocALUO240a+zIimg5JgIclpS7dpmsCTxv7uI
 4AsbJBUC2HexR50mDByYKU9xeMiU1BO2trykfxHep79cstvfw1bsiEYVCQUFo5h9RH5HOkJPG
 00Vbkkae2sAhCRqwbn0mAuYrHttiCvI0sjy21Ai3yFzcFK2B8bUfnloGFAHgaowlSmURK8LAo
 3IdzuI3mVXBQzCqc3ySqkADOhqYiEMVaLezcZTXnOcthBaH7tFJFY+8z06cLhyZwGXICGWSCk
 9raBuSOZoaiR8WASphDDPJFhWKIQWwP99inih9bNV9XIwWQYyWAfLkwol9rFcsgIXsBHvRE6p
 pA6cVhWH8YqUVMDRXgPxybQfUJQesHLLuaSsapTijlz6S7nLz4mPcT7E0aZOxbQhkltAcnSaL
 PBF6rW3WOV+HDYfPdDT344mcHfT28I6vLj4fFJfLCQ8uEZ5L8I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Fri, 9 Feb 2018, Sergey Organov wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> [...]
> 
> > With this patch, the goodness of the Git garden shears comes to `git
> > rebase -i` itself. Passing the `--recreate-merges` option will generate
> > a todo list that can be understood readily, and where it is obvious
> > how to reorder commits. New branches can be introduced by inserting
> > `label` commands and calling `merge - <label> <oneline>`. And once this
> > mode has become stable and universally accepted, we can deprecate the
> > design mistake that was `--preserve-merges`.
> 
> This doesn't explain why you introduced this new --recreate-merges. Why
> didn't you rather fix --preserve-merges to generate and use new todo
> list format?

Because that would of course break existing users of --preserve-merges.

So why not --preserve-merges=v2? Because that would force me to maintain
--preserve-merges forever. And I don't want to.

> It doesn't seem likely that todo list created by one Git version is to
> be ever used by another, right?

No. But by scripts based on `git rebase -p`.

> Is there some hidden reason here? Some tools outside of Git that use old
> todo list format, maybe?

Exactly.

I did mention such a tool: the Git garden shears:

	https://github.com/git-for-windows/build-extra/blob/master/shears.sh

Have a look at it. It will inform the discussion.

> Then, if new option indeed required, please look at the resulting manual:
> 
> --recreate-merges::
> 	Recreate merge commits instead of flattening the history by replaying
> 	merges. Merge conflict resolutions or manual amendments to merge
> 	commits are not preserved.
> 
> -p::
> --preserve-merges::
> 	Recreate merge commits instead of flattening the history by replaying
> 	commits a merge commit introduces. Merge conflict resolutions or manual
> 	amendments to merge commits are not preserved.

As I stated in the cover letter, there are more patches lined up after
this patch series.

Have a look at https://github.com/git/git/pull/447, especially the latest
commit in there which is an early version of the deprecation I intend to
bring about.

Also, please refrain from saying things like... "Don't you think ..."

If you don't like the wording, I wold much more appreciate it if a better
alternative was suggested.

> Don't you think more explanations are needed there in the manual on
> why do we have 2 separate options with almost the same yet subtly
> different description? Is this subtle difference even important? How?
> 
> I also have trouble making sense of "Recreate merge commits instead of
> flattening the history by replaying merges." Is it "<Recreate merge
> commits by replaying merges> instead of <flattening the history>" or is it
> rather "<Recreate merge commits> instead of <flattening the history by
> replaying merges>?

The documentation of the --recreate-merges option is not meant to explain
the difference to --preserve-merges. It is meant to explain the difference
to regular `git rebase -i`, which flattens the commit history into a
single branch without merge commits (in fact, all merge commits are simply
ignored).

And I would rather not start to describe the difference between
--recreate-merges and --preserve-merges because I want to deprecate the
latter, and describing the difference as I get the sense is your wish
would simply mean more work because it would have to be added and then
removed again.

If you still think it would be a good idea to describe the difference
between --recreate-merges and --preserve-merges, then please provide a
suggestion, preferably in the form of a patch, that adds appropriate
paragraphs to *both* options' documentation, so that your proposal can be
discussed properly.

Ciao,
Johannes
