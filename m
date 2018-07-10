Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6FC61F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 10:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbeGJKIn (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 06:08:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:56221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbeGJKIm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 06:08:42 -0400
Received: from [192.168.0.129] ([37.201.195.87]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MBrCt-1flO0h0Nz5-00Al3D; Tue, 10
 Jul 2018 12:08:36 +0200
Date:   Tue, 10 Jul 2018 12:08:36 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v3 16/20] range-diff --dual-color: work around bogus
 white-space warning
In-Reply-To: <xmqq601ocecs.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807101149130.75@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <dfa7b1e71f7a39dfa608e1e205579d3b95d8a34f.1530617166.git.gitgitgadget@gmail.com> <CAGZ79kYQTTjipfBn3oAbpjZGnszWNiTKN3Ai4Pp-QA+i_xigbg@mail.gmail.com>
 <xmqq601ocecs.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hZ6f+bfJuIB6uok6uLcGe5BGNLsNkYDItcd8LPr8i8ayCXkTDL7
 iduBG1AEWxGn24LbLQt+e99Tq4ssux7hpxaNLIhbHdwzzVfxtDg7ZGIgkp/axXp9eUzRN4Y
 wGVG0quNbhUfH7eC5Jjnv+OggYrRoedreFIMGYRHlWeIBO3btS6jRTW2fXxa8XPv9KnfyDq
 oeWTwWU77lIHtL2vEvq6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:on67+3WkSm4=:9BwfnsHL7mGExPFmppyEjq
 wlWUD8Eoe0XZeUZruMT5Xqkc+HDcMNIVXSWDdW0tzQPqnldPTQHMMC5groS8vJRSqqVZ5uLNM
 cn+5eQh3Hs5ioENbAi08K0Oz9jlQkMkgrU1u44pmeuySiWD6G1JcXqObAnvyf9o8ZBN7HS5ia
 FW1m7vGl0J+aJD8uc6HLLtY8/knkZrlRo1RYSgZ2F0WV+jLUFrC0B9AM5ZjYu7gOyrzJBtu1r
 N+YBH6cMooAg3CcUjjkbqx4UFZDjUs5cfMhw5mHvH1tCiqy/EckySvYJrOGcdKj78DdngsE61
 s4B58aMde/yhyl8m8AvGGQSzqwk5KaiA6CIHgTQKu7mcqjWptsUhdsII9cckfWyHwpgaI04eC
 aSsr1mkCrJYnEEj/OKGC8R3S3UQocW8zfDzUQJOg3yd0hPRVCFL31J4H9veca5r5Hk/v0C9Le
 m4va/TzlEvDwIE3PTHLUNcWjht+Cqf2KIRmxlmnV/qbwnEKNnUP6czAnrv9haivsHTCdX9qT3
 1dtYOS//xOIexTIAgVmHiK7IipFa4D8xlwmbUJnSQH7uLZzLEJrftqXpqF2M6ENJ4ciJD3fJT
 x/6M2tbm5rfxgn0qJ+mirt8BL0GDzkqGA9dB0uhd9u7axBIcOV35nX04ySTPIhXR39/RNR41b
 SKD+vaxANNcEwaJ3qqHZYr0Jt+n7J1x4XiEjv/24k3Tg/srzgIDSNdg+GbvKVlwZ9AWPKYXqq
 74KXdrbyPqztp7IADNk+uD2peE3QpbvEWqZDRZ5G1lnVpSN8J5Be18NW2urTFFUPfMTd+Ouw7
 3nR4MOY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 9 Jul 2018, Junio C Hamano wrote:

> I also wonder if we should be feeding the context lines to ws.c
> machinery in the first place though.

It *is* confusing, I know. The entire "diff of diffs" concept *is*
confusing. I just don't know about a better alternative.

So hear me out, because there is a big misconception here: there are *two*
levels of diffs. The outer one and the inner one.

Context lines of the outer diffs have no problem [*1*].

The problem arises when the outer diff shows a - or + line (i.e. the line
is present *either* in the old patch set or in the new patch set, but not
both), *and* that line is *not* a context line of the inner diff.

Let's illustrate this via an example. Let's assume that both the old patch
set and the new patch set add a comment to a statement, and that the
context of that statement changed between old and new patch set. Something
like this would be in the old patch set:

```diff
 	int quiet = 0;
+	/* This is only needed for the reflog message */
 	const char *branch = "HEAD";
```

And this would be in the new patch set:

```diff
 	int quiet = 0, try_harder = 0;
+	/* This is only needed for the reflog message */
 	const char *branch = "HEAD";
```

So as you see, both old and new revision of the same patch add that
comment, and it is just a context line that changed, which a regular
reviewer would want to *not* consider a "real" change between the patch
set iterations.

Now, let's look at the "diff of diffs":

```diff
- 	int quiet = 0;
+ 	int quiet = 0, try_harder = 0;
 +	/* This is only needed for the reflog message */
  	const char *branch = "HEAD";
```

Please understand that in the dual color mode:

- The first line's `-` would have a red background color, the rest of that
  line would be uncolored (because it is a context line of the inner
  diff),

- the second line's `+` would have a green background color, the rest
  would be just as uncolored as the rest of the first line,

- the third line would be a context line of the outer diff, but a `+` line
  of the inner diff, therefore that rest of the line would be green, and

- the fourth line is completely uncolored; It is a context line both of
  the inner and the outer diff.

That's it for the diff colors. Now for the white space: The first two
lines start with a `-` and a `+` respectively (outer diff marker), and
then most crucially continue with a space to indicate the inner diff's
context line, *and then continue with a horizontal tab*.

As far as the inner diff is concerned, this *is* a context line.

As far as the outer diff is concerned, this is *not* a context line.

And that is the conundrum: the whitespace checker is called because the
outer diff claims that the second line is a `+` line and the whitespace
checker has no idea that it should treat it as a context line instead.

I'll try to find some time this afternoon to study Stefan's reply, as I
have a hunch that there is a deep insight hidden that helps me to figure
out the proper path ahead (because I do not want to uglify the `diff.c`
code the way my current iteration does, and I'd rather have a way to color
the diff more intelligently myself, in a function in `range-diff.c`).

Ciao,
Dscho

Footnote *1*: Actually, that is only half the truth. In dual color mode,
if a line is a context line of the outer diff, but a - or + line of the
inner diff, *we still want it colored*. And of course, ideally we still
want whitespace checking for the + lines.
