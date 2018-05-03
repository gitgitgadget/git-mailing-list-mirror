Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E404200B9
	for <e@80x24.org>; Thu,  3 May 2018 20:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750962AbeECUmd (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 16:42:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:59207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751074AbeECUmc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 16:42:32 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCggg-1f4xO71PeM-009MvI; Thu, 03
 May 2018 22:42:25 +0200
Date:   Thu, 3 May 2018 22:42:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
In-Reply-To: <CAGZ79kZAidPafdfu1NGwwpVo1Vy=vKOV+EREE2=-ct_sbo7Gkg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805032227520.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de> <CAGZ79kZAidPafdfu1NGwwpVo1Vy=vKOV+EREE2=-ct_sbo7Gkg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:eZMydl1t9ssrm8ZgOxPnA4occC83do5GF05cQX4v3ZsghUkLUlX
 czC8PIFjrj6W36N0qlRMuQseIDJpY1ZzdvydwIJzyynZQSibNpJLcwYTRbysK63moqg0yHS
 PHpAJTGyjtUac+5fG4U4zsl4woheWa/2lTxWKMNHOCXbSRCklc1iqdRNWffGiVUxnMo8mTz
 //oz0O4V0bqv9sKLmgA9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZafsVfXFlXQ=:txsBxtFYXorPIR+5N6szdu
 UxsUSmGnZlGqBwdTC4GMznAUF1t1tBoNXsMau4Pcu3D8nIdDzu3ozNM84jeoDjehQGr5Kw57n
 dMFtAfP6KVclxvpyx25+Cu36iWWmvJuaUKyJvOKwH/aT89km9RmddS4KObTxupHlu81ySX/Ry
 nTBOiKbXx1HAyNstjuib8tRKZKFkaHRjNbgvddrxRfjcsdn/QiIHXHRO+2NYU3EEnuZkZzZTt
 ALkcRejteBA2CBunmjPnAUfj228loGlc7Wcf5kl4Xf0RQuKhy3ewsv7KUSh8dSuz6rk9JpCwv
 EjiwpVgSGcNIrPyyyMPIHlytip4F4D4DTJiVhS8wVf5G4Ww/A6SvUajRlPBkqkWIls7tzuKet
 14nkCv56mD9YNwWezoeZtR8/Eu+ZnwId81gV69ogzDFnbJxJq6iYv8NmC3s1UbXYeiqqmrE4V
 Tu0Ts0SQ/C2keeXEr96ZAyNaYwIMIJ9jeJ7ylwF4e+wTSOOgOdAIDSFV7uFXtjXmHY/UbM783
 ZaCFmdXlybtZbRdR/q8USIfMhvUOLRdmWlDTG730TOoVuH6xIOEB0ahYpDg76uOSL+Pqf40up
 Lk8XNoXaFJCcvInhS4UpCvWo2DUMKt6vqOK/k7cm7zAhZUU2EHo7bOuYVVWzLjgFV3hZrShgC
 EeezRgk1p2yeX0UvAcxwxGBc95bbp4UaLdVKdtMKQYZ33Y10xaAVEake6MZEOL3Bhu1AA9qMs
 Y9+yVYSiRZWMvGFZ/t3T7YUSQmEoyTaR4CNoXIk3fe5YWrR/QdQelTkuEzbem4YDk1OUvGOK2
 teJ6pFK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Thu, 3 May 2018, Stefan Beller wrote:

> On Thu, May 3, 2018 at 8:30 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > This builtin does not do a whole lot so far, apart from showing a
> > usage that is oddly similar to that of `git tbdiff`. And for a good
> > reason: the next commits will turn `branch-diff` into a full-blown
> > replacement for `tbdiff`.
> 
> While I appreciate the 1:1 re-implementation, I'll comment as if this
> was a newly invented tool, questioning design choices. They are probably
> chosen pretty well, and fudge facotrs as below are at tweaked to a
> reasonable factor, but I'll try to look with fresh eyes.

Absolutely. While tbdiff got some testing over time, it has definitely not
gotten as much exposure as branch-diff hopefully will.

BTW I chose a different command name on purpose, so that we are free to
change the design and not harm existing tbdiff users.

> > At this point, we ignore tbdiff's color options, as they will all be
> > implemented later and require some patches to the diff machinery.
> 
> Speaking of colors, for origin/sb/blame-color Junio hinted at re-using
> cyan for "uninteresting" parts to deliver a consistent color scheme for
> Git. Eventually he dreams of having 2 layers of indirection IIUC, with
>     "uninteresting" -> cyan
>     "repeated lines in blame" -> uninteresting
> 
> Maybe we can fit the coloring of this tool in this scheme, too?

Sure. So you mean I should use cyan for... what part of the colored
output? ;-)

> > +       double creation_weight = 0.6;
> 
> I wondered if we use doubles in Gits code base at all,
> and I found
> 
> khash.h:59:static const double __ac_HASH_UPPER = 0.77;
> pack-bitmap-write.c:248:        static const double
> REUSE_BITMAP_THRESHOLD = 0.2;
> pack-bitmap.c:751:      static const double REUSE_PERCENT = 0.9;
> 
> all other occurrences of `git grep double` are mentioning it in other
> contexts (e.g. "double linked list" or comments).
> 
> When implementing diff heuristics in 433860f3d0b (diff: improve
> positioning of add/delete blocks in diffs, 2016-09-05), Michael broke
> it down to fixed integers instead of floating point.
> 
> Do we need to dynamic of a floating point, or would a rather small range
> suffice here? (Also see rename detection settings, that take percents as
> integers)

I guess you are right, and we do not need floats. It was just very, very
convenient to do that instead of using integers because

- I already had the Jonker-Volgenant implementation "lying around" from my
  previous life as an image processing expert, using doubles (but it was
  in Java, not in C, so I quickly converted it for branch-diff).

- I was actually not paying attention whether divisions are a thing in the
  algorithm. From a cursory glance, it would appear that we are never
  dividing in hungarian.c, so theoretically integers should be fine.

- using doubles neatly side-steps the overflow problem. If I use integers
  instead, I always will have to worry what to do if, say, adding
  `INT_MAX` to `INT_MAX`.

I am particularly worried about that last thing: it could easily lead to
incorrect results if we blindly, say, pretend that `INT_MAX + INT_MAX ==
INT_MAX` for the purpose of avoiding overflows.

If, however, I misunderstood and you are only concerned about using
*double-precision* floating point numbers, and would suggest using `float`
typed variables instead, that would be totally cool with me.

Ciao,
Dscho
