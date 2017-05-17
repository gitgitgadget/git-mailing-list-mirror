Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32740201A7
	for <e@80x24.org>; Wed, 17 May 2017 19:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753654AbdEQTdn (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 15:33:43 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:37620 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753495AbdEQTdm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 15:33:42 -0400
Received: by mail-it0-f53.google.com with SMTP id g126so15640080ith.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 12:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Gl4UNdpxxTXRHBOEhM6xdYkXnVmbMlEpimQvMTq7pU=;
        b=EcdQO3mvx5s1XAhkctfkczq9ecmxgio5y7cUYG319JHiOWuhlu9AJcSqbRc5X7UdpW
         7t20vXoUzu6ncfYFyZWiDgv6BlhPlppuQuVziMXB5fxTZU7tyRxd31UEShi8AK/9sw+I
         kCjSVfEILe9FbCXStzJO3Obu7R5rJmE1SDllnOvHge86Z5L1hmZ4R+Xm+CQOVtm42+vf
         Da6xVMx52+LzhCtzsm005u9R/c+fv5TjdL2FkVbQr87r48Vui21EjMnokQO3RVsIkrjg
         ampX99tm/Ya3mb7SHGS4gr1Eh9l46YVuArQNB1U9+R00Zf1Q0bmAbVMBEbASvn7bqrZ4
         8zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Gl4UNdpxxTXRHBOEhM6xdYkXnVmbMlEpimQvMTq7pU=;
        b=copnAA0t7LTn5UR1P31ONXt+oGFIrZQoOGcI6VMGQo3RgLMzlbvf6f4fcWZetbXbpS
         COQ++vi2vK9E0hTb7N19g3j+0XHCipDzO+eCOzem1V3Z6CGL7amsv+LQw+HiMSaV4MsI
         /7PORro9rRcJVmPtuPC5L1K2V/PhBjCcxIeInL0n2uDVLACpCPvjimCVWbIAJTiewNFO
         m1VsQ1Wq1Nmq+iQ0pV65E+A3WMPhxC7iR3MqisJM0qZx6CVOHehcElb768Dxlt23Rx+I
         TMn/XKsEvz+8y8+qQOFuDjsdqX476iOiEVGPRWgB94vo2/PH1m5cDtJTAWHtusa1hqDe
         RioA==
X-Gm-Message-State: AODbwcAOPIT2o5WtpN9Cf2ULbFOOf4xDQktbPk8QmFYZ30rteHOhBQNN
        szNBXD/aVv5oy8oRm9yd3lIIfyh7+Q==
X-Received: by 10.36.37.78 with SMTP id g75mr484470itg.94.1495049616344; Wed,
 17 May 2017 12:33:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 17 May 2017 12:33:15 -0700 (PDT)
In-Reply-To: <xmqqbmqrwzu1.fsf@gitster.mtv.corp.google.com>
References: <20170516175906.hdwn4x5md7dj7fo3@kitenet.net> <20170516203712.15921-1-avarab@gmail.com>
 <xmqq7f1gyzep.fsf@gitster.mtv.corp.google.com> <CACBZZX4Jppr7ht7m444EjW4CDYX5CMvnxtStH4bF=A19TYKcZg@mail.gmail.com>
 <xmqqbmqrwzu1.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 17 May 2017 21:33:15 +0200
Message-ID: <CACBZZX5BrASFemN2VviMjH-AqnxU6veLVmjRdn1iYuA9fgKQog@mail.gmail.com>
Subject: Re: [PATCH] tests: add an optional test to test git-annex
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Joey Hess <id@joeyh.name>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Well, it is one thing to place git-annex under CI to make sure its
>>> latest and greatest works together well with our latest and greatest
>>> (and it may be something we want to see happen), but driving its
>>> tests from our testsuite sounds like a tail wagging the dog, at
>>> least to me.
>>
>> To me this is just a question of:
>>
>> * Is it the case that git-annex tests for a lot of edge cases we don't
>> test for: Yes, probably. As evidenced by them spotting this
>> regression, and not us.
>
> And I'd encourage them to keep doing so.

The point of this patch is that we can do this more systematically and
reliably, not have people discover this sort of thing after a major
release.

I.e. we can be pro-active about this instead of waiting for bug
reports to roll in.

>> * We can (and should) add a test for the specific breakage we caused
>> in 2.13.0, but that's no replacement for other things annex may be
>> covering & we may be missing which'll catch future breakages.
>>
>> * It's a pretty established practice to test a library (git) along
>> with its consumers (e.g. annex) before a major release.
>
> I am not so sure about the division of labor.  What you are
> advocating would work _ONLY_ if we test with a perfect & bug-free
> version of the consumers.  If they are also a moving target, then
> I do not think it is worth it.  After all, we are *not* in the
> business of testing these consumers.
>
> Unless I misunderstood you and you were saying that we freeze a
> version, or a set of versions, of customer that is/are known to pass
> their own tests, and test the combination of that frozen version of
> the customer with our daily development.  If that is the case, then
> I would agree that we are using their test to test us, not them.
> But I somehow didn't get that impression, hence my reaction.

The test I'm adding tests the release version of git-annex, so I think
in practice we don't have to worry about random changes of theirs
producing false positives for us.

The utility of this test is that sometime close to release someone
(e.g. me) can run it, if it fails let's see if it fails on the last
release version of ours, if so it's probably upstream breakage, or
like with the 2.13.0 release if it's OK on 2.12.0 it's our bug.

It'll never trip some random tester up since you need to explicitly
opt-in via EXTERNAL_TESTS=3D1, so honestly I'm a bit puzzled by these
objections. This incurs no burden on either devs, packagers or users,
and would have demonstrably detected an issue we'd rather have wanted
to know about pre-release than post-release as is the case now.
