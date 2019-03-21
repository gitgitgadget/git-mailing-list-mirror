Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49CF20248
	for <e@80x24.org>; Thu, 21 Mar 2019 11:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfCULWV (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 07:22:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:59363 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfCULWV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 07:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553167338;
        bh=4gHnMbFs2my1hTNIHgomu/C+Ki+Q4hbqOfpFjlK+9I8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JSx9K7geDeXvnNhNdru4o3kKgca5z1QmQWNt071y/V3KJM5U0O/Ogs7OarJmaLK7M
         UEgzV56o4Ae0LK909xxqCs8AoyW/pwswx6mVKaW57swEC/otSSXDkkhmpt4aKpLXSm
         0CkVs0FueSONgYSL8izr+It7rJz/4iUaoVBr09RE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lq9oW-1gTSA62cXA-00dlRj; Thu, 21
 Mar 2019 12:22:18 +0100
Date:   Thu, 21 Mar 2019 12:22:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: [WIP PATCH/RFC] Use a higher range-diff --creation-factor for
 format-patch
In-Reply-To: <87tvg49c5u.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903211209280.41@tvgsbejvaqbjf.bet>
References: <87y35g9l18.fsf@evledraar.gmail.com> <CAPig+cRMiEcXVRYrgp+B3tcDreh41-a5_k0zABe+HNce0G=Cyw@mail.gmail.com> <87tvg49c5u.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1763471688-1553167338=:41"
X-Provags-ID: V03:K1:SpLBS2l1tZEQA4VTD40n1Z89lxBL1k5Zeld98TQ2+cvLdqZMFCJ
 So7C3q43zuq6ISqSLE90esyd5dh0iDjywpky6cakrqBumIi4PwxaY3oCMp9xVV5ddN8bco2
 50U7gUp60XCwxJj2I3VjN1sdpldzIVrVONZHRY7/duKZmpS62fmucx+Fb/SCRkHvE9Dm5tV
 dHtOhY9bvLwSBiwcrrE4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1W/n85N9k6g=:LGFXqLcpfmu1kghv7Nyj2E
 Mveb3PYHygEG/pHybctloo/AmwWIWoM8fuRTbs/DNBedH4kmM42ql1jM7nVT1nPTKgjpQESPY
 HZCAPymXjQ4YijV5P8GDYvMFRK7ocpltRaCq2AftNPu47bdyYYVRDAdXQoDhX0KpNFEpOvpKq
 nntxPyyaKJJd/hX6JgT9YafxI3hMi4HEuGBx4Tg0y6Y4ZrmABO/TZ6cyIQdchMHmHGs+23h2C
 DvU2NHBiRIg9FcPzb72XY393BKsOrBm2tX9fa8jpbperivfjMmX6faEDOcbYf8XX/Kre1arBM
 fEG9thbhYRsY2mNuqwytiB+SZUzVEj/ITb6g2sMlVModpA9oyq4ME2jmw+xWE8GSiUdI73zUE
 gBJQl8SEdptm6MdOlsu92ujuKeI71sf2ZsEmjzwqWQUaxANsDWFNprjBvhgoB3v8FqbynPoPW
 dLTjDqSDcQjHvfBvTfryOzKBiZ3qE/LavGpJ2o8X06XuRNcfpOAE5GKq8RMD9AJYPxEPWkB5h
 yMmXlfvYMz4IMOuy241hzC+5Ze82P1y1fyLFJ7rbSus6Ik/qnAabaCI6ZHjkfjCU62txKwYfN
 BHKOmQtjGc059PvbmSSEe4l+NNGdc6tNh0yvxVU4o+YcHVEoicKv1bDDNi5q5mNE2cui45trO
 +mhrZiMYY+pQaHor6sM3m571vwHxF+/PPHzXBDMloRhElrhClv1o3iOW92wY17+7fmmMYNXYG
 Pn9FcO+fqQZQLdI4LOkd+GIRzo2ngSL0Gz8Gw2ra5StWfRUahWJ416IDdL/jOQ2+l8mcUt6Kd
 k3d30KhdMaGYMI1c3IGaExfvIh07gZueKHrP7Q19TfDOvPkiezGP6QLBcgML1yIrVHU/MpxkO
 +HH5l2h3xfP0ghP9fG0VB6Pc0bAGKV8NnG7R5G+hG2GKBC14DwIW5psITMHJJ9vApwVIO0AxC
 cFsXSQx2tiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1763471688-1553167338=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var and Eric,

On Fri, 15 Mar 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Fri, Mar 15 2019, Eric Sunshine wrote:
>
> > On Fri, Mar 15, 2019 at 12:09 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> > <avarab@gmail.com> wrote:
> >> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-f=
ormat-patch.txt
> >> @@ -261,6 +261,10 @@ material (this may change in the future).
> >> +Defaults to 90, whereas the linkgit:git-range-diff[1] default is
> >> +60. It's assumed that you're submitting a new patch series & that we
> >> +should try harder than normal to find similarities.
> >
> > My understanding was that the primary use-case of git-range-diff
> > itself (which existed before the --range-diff option was added to
> > git-format-patch) was to generate a "range diff" for a cover letter of
> > a re-rolled series. So, I'm confused about why this tweaks the default
> > value of one command but not the other.
> >
> >> diff --git a/range-diff.h b/range-diff.h
> >> @@ -4,6 +4,7 @@
> >>  #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
> >> +#define RANGE_DIFF_CREATION_FACTOR_FORMAT_PATCH_DEFAULT 90
> >
> > The point of introducing RANGE_DIFF_CREATION_FACTOR_DEFAULT in the
> > first place was to ensure that the default creation-factor didn't get
> > out-of-sync between git-range-diff and git-format-patch., Thus,
> > introducing this sort of inconsistency between the two would likely
> > lead to confusion on the part of users. After all, --range-diff was
> > added to git-format-patch merely as a convenience over having to run
> > git-range-diff separately and copy/pasting its output into a cover
> > letter generated by git-format-patch. If the two programs default to
> > different values, then that "convenience equality" breaks down.
> >
> > So, I'm fairly negative on this change. However, that doesn't mean I
> > would oppose tweaking the value shared between the two programs (and
> > also the default used by GitGitGadget, if it specifies it manually),
> > though I defer to Dscho in that regard.

GitGitGadget does not specify the creation factor manually.

> I think that was the intention initially, but at least I'm now using
> range-diff as a general comparison tool of different non-ff-branches,
> e.g. the force-pushes to "pu".

Interesting ;-)

> I'd expect the tool in general to be used like that, whereas with
> format-patch it's safe to say we're dealing with a re-roll of the same
> thing.
>
> Hence the hypothesis that for format-patch we can be more aggressive
> about finding similarities.

I do agree that `format-patch`'s `--range-diff` is certainly exclusively
used for comparing different iterations of the same patch series. As such,
I do agree with =C3=86var that it makes sense to have a *different* defaul=
t for
the creation factor.

Having said that, I did notice while porting `tbdiff` to C that it would
be a neat idea to put more weight behind the differences of the commit
message, and maybe even use a *different* measure on the commit message,
too. Personally, I would try to use a variation of the word diff
(maybe something that reflects my experience that it is common to change
the case in the oneline, to add a sentence here and there, or to delete a
sentence, but not so much to replace entire sentences), to account for the
fact that the commit message rarely changes substantially between
iterations.

So I guess there is a lot of room for improvement here: code (read: diff)
changes simply are not the same as commit message changes.

Ciao,
Dscho

--8323328-1763471688-1553167338=:41--
