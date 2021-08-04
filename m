Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06F7C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF03061040
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhHDVmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 17:42:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:49303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231893AbhHDVmn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 17:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628113348;
        bh=BCXaS/08+HacPY9M/GmskJSkmg6dSB1m9cdSs17IYoA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HGXLUJOWpFnLGVw+t3o5fRic5bk0zKP0hDVBVjdqzWJQ0F2aiP4LSWBBgsPg/SC/j
         70ae91aQ24EG6KK0Eks4NXK5sncKvcLgU4TbL3xKaKCcruivBdycRDKAmrPgC+uzLT
         VbDFOLOLVWwOn79bDUajlhfXsVVguOOY+OQ8Uk+A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQeK-1mKmrC0gdC-00ASRi; Wed, 04
 Aug 2021 23:42:28 +0200
Date:   Wed, 4 Aug 2021 23:42:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 08/10] merge-strategies.txt: fix simple capitalization
 error
In-Reply-To: <CABPp-BFuHiBGC-JnneJYCUWbX4VAT22wTFh=W2msca9A7Yovjw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108042342080.55@tvgsbejvaqbjf.bet>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com> <010702d08417f86da033ae8a6093ec4b9ce6e19a.1628004920.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2108040058520.55@tvgsbejvaqbjf.bet>
 <CABPp-BFuHiBGC-JnneJYCUWbX4VAT22wTFh=W2msca9A7Yovjw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bKBiuAjBfbDqUkp8OOAxhn1HmI91mheF07+BxDGcCk8MRfyWxWn
 z1tOV/SD35NJOiAGDkuoWQE3IBp/5gnjbw+Kk3Dy4uOklEl8xwCEMERhwwxyHhTl1Pma0WQ
 ygtD71ieubp+tZH2phQt0gOXNWBLMNhaCi/6zXCSe+GG6abnzjO/mXmuHwcqyB5lEJmXGep
 VCy2eyAK1LEEABhZsKa1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3+wyUmm/JKg=:s0iT0NcoaZXzg65SSoejW2
 MbGvlteZJzFsmi7zE5RbUp0MR5J5bJIaz/e0FqTrvLk0tKZD2zFjcKpecFoHytbh3k7ri2/Mp
 U/58+YrGvqvgBgm7JGNK0o4Iw4L3NuYTGMt8el0I3dcTVC+lf7qXuBXPM0SvYiYM1cfdAmY3L
 tCObnIcgv1+In3X+oluIVh507mzyBZx37Kidw+Nirfmmf66qJNpqtd4AcsF20Y1NRJizo4XZY
 iEq97b6kbjX3iPvixJDWJb+0D71Cvkwq7De2Yr3VJzs9AdqHIABmgdH3wxqvfqU5VTUQ2ZwHu
 u71LzlEofDQw++Dzm1GHPSFPbzusqLP2dKTk1wtUcEEuJkI5ipLVQNREpVDkyhrNextYSomkB
 LH+cTXNAStMohhXnC2WZGUj1+RWOu9ludsFG4FbepByCE0cYNVyxmuMVxM9Fh97oHo1wvd21N
 T9RCdheXoA2L6GdROW/EA/oTWJwJaZBRHmhRJge/D+sjMemnwIaNNssL9l5pd/ToNAsizaJqC
 waxOdIUtabwRb6KEkONALXp3MiXE807T7o1v78hIlF+XJd8xl1T63X3R4bkuxelbCjtViOCCq
 ThQg+UH0YKoK76t0GAejwqel6iGnFPU7ErlhhDFqtxSz+M2X/VF9nlvqFQx7h5tHIMaGor7VM
 CHButHbuGwXgv2ii7FhRL/hONAURLLOCJgRysENi0Za/anI520Bcvf9zpUSrJ9ICmrDqj/7fu
 V6tu8HwFrWlM13UMdVTZzOPT7PIiOdzc7yxKSkZNRx9l43KfENTSIoY7jxZl9QYizsIFUaZWs
 7Jn1ANpPfOtr6XRFVkVGiJrVRxzJehTpKfOqYryuERST5v6FrxKKqY783M/ERhTd3VKJq1rng
 jg/CYZ8TVdP3DM+zfhkFLoHF9Jvk6flLpxPYUWB3BdbQZifi/zS4EHu8waBIDuADnl9wgSM2h
 LQdwvxecSR1N5UQO/N86FybmGVN+8f9W4r7XqvHmofaplSF6GHC4NxQY7fox/Nw0V1RpMz55y
 uTBogE79i53m5ENo44LxT5NF8gMa/44ygHS3hNVtAmOXDQD6oLmxIpSPGHFQRnpNDLcSgNuL1
 pjOy5L4l23NrdLtPXrs/VyI8vx0FCdOSMjr+GV/YLInxjh+01zGIyd5Ww==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 3 Aug 2021, Elijah Newren wrote:

> On Tue, Aug 3, 2021 at 5:01 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Hi Elijah,
> >
> > On Tue, 3 Aug 2021, Elijah Newren via GitGitGadget wrote:
> >
> > > From: Elijah Newren <newren@gmail.com>
> > >
> > > Signed-off-by: Elijah Newren <newren@gmail.com>
> > > ---
> > >  Documentation/git-rebase.txt | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase=
.txt
> > > index 7044afba362..b4429954480 100644
> > > --- a/Documentation/git-rebase.txt
> > > +++ b/Documentation/git-rebase.txt
> > > @@ -530,7 +530,7 @@ The `--rebase-merges` mode is similar in spirit =
to the deprecated
> > >  where commits can be reordered, inserted and dropped at will.
> > >  +
> > >  It is currently only possible to recreate the merge commits using t=
he
> > > -`recursive` merge strategy; Different merge strategies can be used =
only via
> > > +`recursive` merge strategy; different merge strategies can be used =
only via
> >
> > I am not a native speaker, so I'm eager to learn what is the correct t=
hing
> > to do here. In particular since I continued in lower-case after a
> > semicolon for _years_, right up until some native speaker mentioned th=
at
> > that's only correct if I continue with an incomplete sentence. If a
> > complete sentence follows the semicolon, so the advice went, I should
> > start the sentence with an upper-case letter.
> >
> > Could you help me understand the correct rules here?
>
> First I've ever heard of it; I just presumed it was a typo.  I don't
> pretend to be an expert on such topics (and although native speakers
> may have an edge in knowing what "sounds natural", I tend to presume
> we are less likely to know the rules).  However, some quick internet
> searches suggest that different style guides differ on whether to
> follow a *colon* with a capital letter[1][2][3], but everything I can
> find suggests that *semicolons* should always be followed by a
> lowercase letter (with exceptions for proper nouns)[2][4][5][and
> others...].
>
> [1] http://www.sussex.ac.uk/informatics/punctuation/colonandsemi/colon
> [2] https://www.quora.com/Why-is-capitalization-necessary-after-a-semi-c=
olon
> [3] https://writingcenter.unc.edu/tips-and-tools/semi-colons-colons-and-=
dashes/
> [4] https://writeanswers.royalroads.ca/faq/199268
> [5] https://wordcounter.net/blog/2016/06/24/101812_capitalize-words-colo=
n-semi-colon.html
>
> So, after reading through the above links, I'm fairly convinced that
> 'different' should be lowercase here.

Thank you for the detailed answer,
Dscho
