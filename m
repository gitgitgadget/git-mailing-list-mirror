Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5C5200B9
	for <e@80x24.org>; Thu,  3 May 2018 21:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeECVtk (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 17:49:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:48041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751190AbeECVtj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 17:49:39 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Meutp-1eym5y21xR-00OUt4; Thu, 03
 May 2018 23:49:32 +0200
Date:   Thu, 3 May 2018 23:49:31 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
In-Reply-To: <CAGZ79ka7RJq=tNnBsLs6wwL7Cf3hSJODM2iLW5tet-csAM20eg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805032334180.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de> <CAGZ79kZAidPafdfu1NGwwpVo1Vy=vKOV+EREE2=-ct_sbo7Gkg@mail.gmail.com> <nycvar.QRO.7.76.6.1805032227520.77@tvgsbejvaqbjf.bet>
 <CAGZ79ka7RJq=tNnBsLs6wwL7Cf3hSJODM2iLW5tet-csAM20eg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BThDoEbq7BykRQqh+C8nskUHL6xtqVxZLSrtdCbRH3SpMhNkYrK
 VNZ2p826Vc3GY4I+zEcKn2Sfjt+mHoGTmnnn0SfIjVOsaZeGhPaFh8dahVrTl8gLiZSyON7
 iGxHCaqgUp50Flu8UOg/CJja38p8nd+5uUDO7jHxm4u/zUTX4umxuAEUs/F8aHF7cRst5pI
 Cw7VWB0UQHS2ENKIUptYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pa7uZyO7LWc=:geXTCMaVSb8Q4vNF1nXsMC
 qe3Oz551tXu4S00FWW56wGQRNjglO4eSLE6Kqh2qmbBWamO3ppI/SBW9b8ZS+ZF8CP6s8bxPL
 3rqGzNIm8ejc0hmlUZejfOaye156RUsfLeT9XkuDedkybRkHElqS859BgCZ5ty3IyA44oc6DQ
 rxQZ6X0OmgObS34iAaEjphpqwmRSVukuNsBWj+aGG5S7c9SY3t5KNTZvIGL6G5qQs6l/QDBzd
 NeSJAIL8WLtSMtnJH0LiI0b/tQSheo42ZdRPeNQxCpZ5zfcheSPKGI12POfnPUb2WI+5iRter
 PQEE9zSgy6oW78rKqtTwu7BgWZ3EWlz8deb/dt0p+P3T5UPsKYXwUNjY4qaU04M7QYZEEyu1D
 JVK5AQjJayV9aDaWykqqMSephFibzv2XZ3l1Z8ejIa307EGiN5ekGz88Z+r90uEgICaUC543o
 TAUSlWJQhOK9vwX49wZ2cw3IkiPjcwKXA5e3EBZ5z6lICHTPRii+wgISM04c0FIrFk0X66txc
 8Dl79VJP5rkrBPMK1AeQlcIaHDjbsb8KNl8YlWXWCc221TT7R3y5uitmk9FljirzKu2pjdGWw
 uL3rEZANlbiOe1bKH5ObhveusqtJaesTWulRFhJGl7cA7SrCyTZciD7yU0SfesthlkcmQ8NCY
 h6TDxNQ76bA0VYXSIN6TBeRcO75QXNYmhxtFhYLuHlJWChtt5/zSfkzPyXgSxXtsKNP/UdPFI
 62Z6Y/WkDCnzZypFURDtrDR7EcGSF07rAaawhBdd2PCBodlXbt0m50IBZcv+gXUI/17USDYWs
 TKB5Vnq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 3 May 2018, Stefan Beller wrote:

> On Thu, May 3, 2018 at 1:42 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> >> Speaking of colors, for origin/sb/blame-color Junio hinted at re-using
> >> cyan for "uninteresting" parts to deliver a consistent color scheme for
> >> Git. Eventually he dreams of having 2 layers of indirection IIUC, with
> >>     "uninteresting" -> cyan
> >>     "repeated lines in blame" -> uninteresting
> >>
> >> Maybe we can fit the coloring of this tool in this scheme, too?
> >
> > Sure. So you mean I should use cyan for... what part of the colored
> > output? ;-)
> 
> It is just a FYI heads up, not an actionable bikeshed painting plan. ;)

Oh, I did not understand it as bike-shedding at all. I had hoped that you
ran `git branch-diff --dual-color` on something interesting and found e.g.
the yellow color inherited from DIFF_COMMIT to be the wrong color for
unchanged commit pairs.

So please: as soon as you have a concrete suggestion where to use cyan
(and preferably even a DIFF_* constant to feed to diff_get_color_opt()), I
will be more than interested.

> >> Do we need to dynamic of a floating point, or would a rather small range
> >> suffice here? (Also see rename detection settings, that take percents as
> >> integers)
> >
> > I guess you are right, and we do not need floats. It was just very, very
> > convenient to do that instead of using integers because
> >
> > - I already had the Jonker-Volgenant implementation "lying around" from my
> >   previous life as an image processing expert, using doubles (but it was
> >   in Java, not in C, so I quickly converted it for branch-diff).
> >
> > - I was actually not paying attention whether divisions are a thing in the
> >   algorithm. From a cursory glance, it would appear that we are never
> >   dividing in hungarian.c, so theoretically integers should be fine.
> >
> > - using doubles neatly side-steps the overflow problem. If I use integers
> >   instead, I always will have to worry what to do if, say, adding
> >   `INT_MAX` to `INT_MAX`.
> >
> > I am particularly worried about that last thing: it could easily lead to
> > incorrect results if we blindly, say, pretend that `INT_MAX + INT_MAX ==
> > INT_MAX` for the purpose of avoiding overflows.
> >
> > If, however, I misunderstood and you are only concerned about using
> > *double-precision* floating point numbers, and would suggest using `float`
> > typed variables instead, that would be totally cool with me.
> 
> So by being worried about INT_MAX occurring, you are implying that
> we have to worry about a large range of values, so maybe floating points
> are the best choice here.

I am not really worried about a large range of values, I am worried about
a use case where we use the maximal value as an "impossible, must avoid at
all cost" value. See this line in hungarian.c:

                        u2 = DBL_MAX;

It does not seem as if any arithmetic is done on u2 after that
(theoretically, it should not survive the loop that comes after it and
tries to replace u2 with any smaller value it finds, but what if that loop
does not even run because column_count == 1? Sure, it is a pathological
case, but even those should have correct results).

But actually, yes, there *is* arithmetic performed on u2:

                        if (u1 < u2)
                                v[j1] -= u2 - u1;

So in the pathological case where we try to find the best assignment of a
single column to an arbitrary number of rows (where simply the row with
a smallest cost should be picked), we try to subtract from v[j1] an
insanely large value. As a consequence, v[j1] will be close to INT_MIN if
we were to switch to integers, and who is to say that the next time we get
to this part, j1 will be different? If it is the same, and we hit the same
u2, then we might end up subtracting something close to INT_MAX from
INT_MIN, which will definitely overflow and the computation will be
incorrect.

*That* is what I am worried about: overflowing integer arithmetic. IIRC if
you subtract DBL_MAX from -DBL_MAX, you still end up with -DBL_MAX. So in
that respect, using floating point numbers here is safer.

> Looking through that algorithm the costs seem to be integers only
> measuring number of lines, so I would not be too worried about running
> into INT_MAX problems except for the costs that are assigned INT_MAX
> explicitly.
> 
> I was more asking, if floating point is the right tool for the job.

I think I would have to spend some real quality time with the code in
hungarian.c to turn it into using integer costs instead of floating point
numbers, to ensure that the arithmetic is done in a way that is consistent
with the algorithm, even if we cannot represent the arithmetic faithfully
with limited-range integers.

I'll think about the best way forward.

Ciao,
Dscho
