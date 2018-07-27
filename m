Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9EF71F597
	for <e@80x24.org>; Fri, 27 Jul 2018 15:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbeG0QlI (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 12:41:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:56781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbeG0QlI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 12:41:08 -0400
Received: from [192.168.0.129] ([37.201.193.59]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhAAr-1fMqf33BY1-00MMoA; Fri, 27
 Jul 2018 17:18:40 +0200
Date:   Fri, 27 Jul 2018 17:18:39 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 2/5] format-patch: add --range-diff option to embed
 diff in cover letter
In-Reply-To: <CAPig+cSYXYrEdJMpkC_emi3u5PY2GFmZw0nsn5EbEBtU28ZXtw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807271717020.10478@tvgsbejvaqbjf.bet>
References: <20180530080325.37520-1-sunshine@sunshineco.com> <20180530080325.37520-3-sunshine@sunshineco.com> <nycvar.QRO.7.76.6.1807171219480.71@tvgsbejvaqbjf.bet> <CAPig+cTKGd8N78XvW-rmBEZC7ykcJsE+na1V_vCVXTUhGrFe4Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.1807261249490.71@tvgsbejvaqbjf.bet> <CAPig+cSYXYrEdJMpkC_emi3u5PY2GFmZw0nsn5EbEBtU28ZXtw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VlYgzClJ5jvNbuvBkPPyDmDnEu19eycrVjJzz9/fQenAPdUsSy8
 e4hcA2tCOUwt0W9g/LfXz73s6+etUD5FoFcsJH3kGKviua5u0dO8sdUGNMUgCNafV6v3FIq
 Z3wT91gEDXwrz67ipfs1cH41KGI7pmGTtBWbt8LvhVL4Jat/OgyH1B53CFDmuqMOP9ozjmB
 x26jfM1q26mFVknYFfqsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kGGwBdbwDwQ=:sK97/rX7UDLSdV7muoIcR5
 0Eohfs5w95WtYYoDL4Q/o1aSYyWUUCTNa05m7s9YV2m8RPVf2uSF+nQtGHr061pERQkruS5GZ
 m6MFnknRJ8xJXFwlPOoiEKop5v7StOEYiGHhq5u8z0MACuM5QcIjhNvyKhO0YloE+nTM268kQ
 I2Xbv51fIbS0XJlXzf+jodMJTyFp3r5Cx3oql1nxBeMq5Bekdp+1xfhf1nVZqAgWRqqECesHl
 AcGCDyVSy6OsVtIQSv1TnQAJOahlHgwYhwCMuLVr87UQe3F+zh/dWYFETOHhxB+x1rpnVDNV8
 MSXqJlm667omiVJED0HE3ueU5VejXpIkUPhf5c0sJsuHaK84XIdli0E+hToFyeu+yMQMDxNfO
 W29LGS+Yx1dqP8/ZJXlJvvUU4Nn04/5TANTuBbN/4i8DHyIXtf6/+9n63KsxmRlqD3nANB7FY
 QxIv2J177DTYawLzdXnfhBjVsEp6TAbDS00WcXJw2kp6bLv1uzrLPuHFe6i4dnbu9RS2jj316
 OGSn3Cg1gNuYDsQom5/WEFQmJcQiEPbhc5GEOg7OwEkiX6y7BOTay2sQWtDKwJ7YFw2yrGb6k
 mj/C9OXj85UBpTEvr34azDmrbxHYjcRro7fNCeO0NAeB97ZHGLRDeWqd61T5NM7vPasXy0Fur
 lscfHZUXFBuXX5neDpe4dWlp5vZUTjvDLfuMIKHSaTceBHglfL192YmFLitpGYLUOZ1I3R6nf
 wIMEWuKCnUkDwMrEgUv80/qrAfNBqyBZTikQPr5w7xX6ajjn0ef1QP2WY4VnQQVpGmxVgXEG+
 VKJuUiz+oFSohTrAXT16lrsxM7av6Z3VC8zZJCjU/21ILOXvPjrNQmlNPB+KSPFNjP9BUd12+
 EL5D1lGAgmue6bAUHDEZkh7kgI56Lfbwk3ZDLAs+MpegdaDHZfV4ThXNOwTZLKV/gyV173HCe
 OvxP1MNF48rMmxPWhzeRToXdFQxETuTO7yQiM6zL97Po5HQOa/p5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 26 Jul 2018, Eric Sunshine wrote:

> On Thu, Jul 26, 2018 at 6:56 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 17 Jul 2018, Eric Sunshine wrote:
> > > On Tue, Jul 17, 2018 at 6:31 AM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > > > BTW I like to have an extra space in front of all the range-diff
> > > > lines, to make it easier to discern them from the rest.
> > >
> > > I'm not sure what you mean. Perhaps I'm misreading your comment.
> >
> > Sorry, I was really unclear.
> >
> > In the cover letters sent out by GitGitGadget (or earlier, my
> > mail-patch-series.sh command), I took pains to indent the entire
> > range-diff (or interdiff) with a single space. That is, the footer
> > "Range-diff vs v<n>:" is not indented at all, but all subsequent lines
> > of the range-diff have a leading space.
> >
> > The original reason was to stop confusing `git apply` when sending an
> > interdiff as part of a single patch without a cover letter (in which
> > case mail-patch-series.sh inserted the interdiff below the `---`
> > marker, and the interdiff would have looked like the start of the real
> > diff otherwise).
> 
> The new version[1] likewise indents the interdiff to avoid confusing
> git-am / git-apply.
> 
> [1]: https://public-inbox.org/git/20180722095717.17912-1-sunshine@sunshineco.com/

Great!

> > In the meantime, I got used to this indentation so much that I do not
> > want to miss it, it is a relatively easy and intuitive visual marker.
> >
> > This, however, will be harder to achieve now that you are using the
> > libified range-diff.
> 
> I toyed with indenting the range-diff in both the cover letter and
> below the "---" line in a patch. With the libified range-diff, doing
> so involves modifying the range-diff implementation (rather than
> having the consumer of the range-diff manage the indentation locally),
> so it adds a bit of complexity to show_range_diff(), though perhaps
> not too much.
> 
> However, I opted against it for a few reasons. First, "header" lines
> apart, all lines of the range-diff are already indented, and the
> existing indentation was sufficient (for me, at least) as a visual
> marker. Second, range-diffs tend to be _wide_, especially the header
> lines, and I was loath to make it wider by indenting more. Third, due
> to the existing indentation of the diff proper, a range-diff won't
> confuse git-am / git-apply, nor will the unindented header lines, so
> extra indentation seemed superfluous.

Totally understandable. For some reason, I never thought about that fact
(a range-diff is *not* a diff) when changing mail-patch-series.ts to use
range-diffs instead of interdiffs.

> > > > > @@ -1438,6 +1480,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> > > > > +     const char *range_diff = NULL;
> > > >
> > > > Maybe `range_diff_opt`? It's not exactly the range diff that is
> > > > contained in this variable.
> > >
> > > I could, though I was trying to keep it shorter rather than longer.
> > > This is still the same in the re-roll, but I can rename it if you
> > > insist.
> >
> > I think it will confuse me in the future if I read `range_diff` and
> > even the data type suggests that it could hold the output of a `git
> > range-diff <options>` run.
> >
> > So I would like to insist.
> 
> In the new version[1], this variable is named 'rdiff_prev' (the
> "previous" version against which the range-diff is to be generated).

Thank you.

> > > > > +format_patch () {
> > > > > +     title=$1 &&
> > > > > +     range=$2 &&
> > > > > +     test_expect_success "format-patch --range-diff ($title)" '
> > > > > +             git format-patch --stdout --cover-letter --range-diff=$range \
> > > > > +                     master..unmodified >actual &&
> > > > > +             grep "= 1: .* s/5/A" actual &&
> > > > > +             grep "= 2: .* s/4/A" actual &&
> > > > > +             grep "= 3: .* s/11/B" actual &&
> > > > > +             grep "= 4: .* s/12/B" actual
> > > >
> > > > I guess this might make sense if `format_patch` was not a
> > > > function, but it is specifically marked as a function... so...
> > > > shouldn't these `grep`s also be using function parameters?
> > >
> > > A later patch adds a second test which specifies the same ranges but
> > > in a different way, so the result will be the same, hence the
> > > hard-coded grep'ing. The function avoids repetition across the two
> > > tests. I suppose I could do this a bit differently, though, to avoid
> > > pretending it's a general-purpose function.
> >
> > If you can think of a way that would make this easier to read for,
> > say, myself if I ever find myself debugging a regression caught by
> > this test, I would appreciate that.
> 
> In the new version, the function is gone; it looks like this:
> 
> --- >8 ---
> for prev in topic master..topic
> do
>     test_expect_success "format-patch --range-diff=$prev" '
>         git format-patch --stdout --cover-letter --range-diff=$prev \
>             master..unmodified >actual &&
>         grep "= 1: .* s/5/A" actual &&
>         grep "= 2: .* s/4/A" actual &&
>         grep "= 3: .* s/11/B" actual &&
>         grep "= 4: .* s/12/B" actual
>     '
> done
> --- >8 ---

Looks good.

Thank you so much!
Dscho
