Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C783320323
	for <e@80x24.org>; Wed, 22 Mar 2017 23:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754555AbdCVXno (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 19:43:44 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:38075 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdCVXnm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 19:43:42 -0400
Received: by mail-it0-f51.google.com with SMTP id y18so31827795itc.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 16:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8zR2oB56ZB6/ejKjdHwM6V7AjepJwcE3Pvqo6Kc8+5U=;
        b=o7VItwFpyoQG+jYGcDrwfa6v+OUC3JX5QJwHznyIOGicy4rq9S179/DwHcNvopWryf
         utbDfqx/w9LlEKK0YPtWkWLMkH34hnURBg2FTyti3iLVCcMNdTXFBkrT9w1JhknecsvQ
         VE0DrwMSaUyFuIb2eAqd9ve7RZAI+LENeRe14x/rF9QN3DQ9UYIRTMg6HL+cGPm0Wjm2
         nBpHn4X5Q1Z2yblLaP5VYhnOL+3tv8uL1nEDR8LME4MzFK5kmXavRiNKJL/TQ7v1T7sj
         RK+Q9Gmv9l5jEeVJ7/F7rkTNBm6wqX/hS2427A/Dj+L+V9qhcVtmfpgLoXU2hak9ktjb
         4eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8zR2oB56ZB6/ejKjdHwM6V7AjepJwcE3Pvqo6Kc8+5U=;
        b=mkFGe9nzWcqva7ktIXHKw2ccOAiAYCFu1WSDQfZI5bsOCOTzwnSQHVrbhfIdOTQ2Pt
         adWW0g2imenNSanjEC3/ikwxUWhPCQVYeoIeHogcRB53sGOWE0utbTTkhKs4H1cZXX9a
         3asBVxDNteoujEg3mvu3LPtIQd5YER8OuLMoqbG/XJemYeEZpqb3lCnT9qNa1caNZmNy
         kvuLVSi9MNQvs5M93y9zbEJ+wwefjc030pdZ+N8NOgYgV5G2qy7001ingPCmz8UVRMoh
         wA4ttd3eqkXo6wmcTBnMmD21orU/xptBShq29pxPcNwVHUoWlxWaXS++ixlRqFovTWvQ
         eBOA==
X-Gm-Message-State: AFeK/H3n0IUxye2pw6Aj3NKnYSUsO0y2Vkq3IA/YhyfcGi4vdNX72Joy/Gg1fWNCo1eyXVJf2giTYh/uhxBRSQ==
X-Received: by 10.36.116.71 with SMTP id o68mr88833itc.60.1490226221348; Wed,
 22 Mar 2017 16:43:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Wed, 22 Mar 2017 16:43:20 -0700 (PDT)
In-Reply-To: <20170322223600.huyel6j5wl644ddf@sigill.intra.peff.net>
References: <20170321125901.10652-1-avarab@gmail.com> <20170321125901.10652-11-avarab@gmail.com>
 <xmqqo9wupixz.fsf@gitster.mtv.corp.google.com> <CACBZZX70pb=h3nPKDY-rcM3rjh9SNYUzUhxA3Hu0-Jph8ODxdg@mail.gmail.com>
 <xmqq1stpj9xv.fsf@gitster.mtv.corp.google.com> <CACBZZX4rofOquS4q0NDCb8cHOF=E7iPzFMxj3bre6CTB7=b_MA@mail.gmail.com>
 <xmqqtw6lgd82.fsf@gitster.mtv.corp.google.com> <20170322223600.huyel6j5wl644ddf@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 23 Mar 2017 00:43:20 +0100
Message-ID: <CACBZZX7kJ_G8mAYd3mN5WtP0ZLUUOuWs4hu1fhTSspWuW_O=5A@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] tag: change misleading --list <pattern> documentation
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 11:36 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 22, 2017 at 03:26:21PM -0700, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>> > of things you think we should be putting in the test suite. I.e.
>> > should the tests be:
>> >
>> > a) Only be a collection of invocations of git we'd be comfortable
>> > showing to someone as "this works, and this is how you should do it",
>> > or things that explicitly fail marked with test_must_fail.
>> >
>> > b) or a) && also various surprising combinations of things we don't
>> > necessarily want to encourage or even support in the future, but which
>> > are in there so if we change them, we at least know our change changed
>> > something that worked before.
>>
>> I am strongly inclined to (a).  If we cannot decide when we designed
>> the feature, and we anticipate that we may want to change it later,
>> then documenting the choice in a test or two may be a way to remind
>> the choice we happened to have made, but in general I do not think
>> we want to promise (to ourselves) more than what we are willing to
>> commit to.
>
> I've occasionally[1] added tests that are "what we happen to produce
> now", but I almost always mark them with a comment either in the test
> script or in the commit message.  What I'm _most_ concerned about is a
> developer later breaking the test, but being unsure if they were
> breaking some real-world case (and not being able to find clues in the
> history).
>
> A secondary concern would be people using the test snippets as guidance
> on what is normal or encouraged.
>
> So I could live with these patches, but I'd prefer to see a comment
> somewhere. And I think I'd have a slight inclination to just stick to
> (a) in the first place, unless there is a really good reason to cover
> the test (like that we do not care between behaviors X and Y, but we
> need to check that it does one of them, and not Z).

Right, or in this case something where we're testing for behavior we
documented for a long time, but never really intended to support.
Junio would you be fine with just this on top:

diff --git a/t/README b/t/README
index 4982d1c521..9e079a360a 100644
--- a/t/README
+++ b/t/README
@@ -379,2 +379,5 @@ Do:

+ - Include tests which assert that the desired & recommended behavior
+   of commands is preserved.
+
  - Put all code inside test_expect_success and other assertions.
@@ -424,2 +427,17 @@ Don't:

+ - Include tests which exhaustively test for various edge cases or
+   unintended emergent behavior which we're not interested in
+   supporting in the future.
+
+   An exception to this is are cases where we don't care about
+   different behaviors X and Y, but we need to check that it does one
+   of them, and not Z.
+
+   Another exception are cases where our documentation might
+   unintentionally stated or implied that something was supported or
+   recommended, but we'd like to discourage its use going forward.
+
+   In both of the above cases please prominently comment the test
+   indicating that you're testing for one of these two cases.
+
  - exit() within a <script> part.
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 0a7ebf5358..35402ad9a0 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -350,2 +350,6 @@ test_expect_success 'tag -l can accept multiple pattern=
s' '

+# Between around v1.7.6.1 & v2.13.0 the documentation unintentionally
+# implied that --list was what took the <pattern>, not that patterns
+# should be clustered at the very end. This test should not imply that
+# this is a sane thing to support.
 test_expect_success 'tag -l can accept multiple patterns interleaved
with -l or --list options' '

Or do you think the "long documented but unintentional" argument isn't
worth a test, in which case squash this:

diff --git a/t/README b/t/README
index 9e079a360a..9f85b8d1cd 100644
--- a/t/README
+++ b/t/README
@@ -433,12 +433,8 @@ Don't:
    different behaviors X and Y, but we need to check that it does one
    of them, and not Z.

-   Another exception are cases where our documentation might
-   unintentionally stated or implied that something was supported or
-   recommended, but we'd like to discourage its use going forward.
-
-   In both of the above cases please prominently comment the test
-   indicating that you're testing for one of these two cases.
+   In that case please prominently comment the test indicating that
+   you're testing for one of these two cases.

  - exit() within a <script> part.

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 35402ad9a0..83772f6003 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -348,19 +348,6 @@ test_expect_success 'tag -l can accept multiple patter=
ns' '
        test_cmp expect actual
 '

-# Between around v1.7.6.1 & v2.13.0 the documentation unintentionally
-# implied that --list was what took the <pattern>, not that patterns
-# should be clustered at the very end. This test should not imply that
-# this is a sane thing to support.
-test_expect_success 'tag -l can accept multiple patterns interleaved
with -l or --list options' '
-       git tag -l "v1*" "v0*" >actual &&
-       test_cmp expect actual &&
-       git tag -l "v1*" --list "v0*" >actual &&
-       test_cmp expect actual &&
-       git tag -l "v1*" "v0*" -l --list >actual &&
-       test_cmp expect actual
-'
-
 test_expect_success 'listing tags in column' '
        COLUMNS=3D40 git tag -l --column=3Drow >actual &&
        cat >expected <<\EOF &&
