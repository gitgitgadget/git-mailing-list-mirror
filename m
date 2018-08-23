Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D88821F404
	for <e@80x24.org>; Thu, 23 Aug 2018 20:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeHXA1l convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 23 Aug 2018 20:27:41 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:38954 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbeHXA1l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:27:41 -0400
Received: by mail-qt0-f182.google.com with SMTP id o15-v6so7901922qtk.6
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 13:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=84pq9yv+gdEWZvraLQNV3238jkzUOw+rvs2YW+eB1EI=;
        b=K/mYEL720J8IKoDp2DqLUmV4aE4tCtfFIgoZN8/P5jKxCutsD5mbB7TfscNsclDrp3
         NcsHJoRizX+SQAjYAZ6+EuxmmpiYf5c8G79E3/H8leWtpa+r5lqqITFIgH5HFBSBJ/3q
         z13oITj4FtyZS9BM0lMYlBf2kX44qBOeBiNC9AqFzQnhLtJGXxguzqezmyhg5qT9ExQ4
         /lNf062rNr3/6WiG3ITJjqiKXCNwMBdgSZ7i+a6QmndfphUxSzjNEKXX4ZTt/FPIj1es
         IxD2oMaZUcTWA0oaai3yZUJIW9HLYIbiplbekB/nnKhR6mt8XKVZobAZNzkphQ4E1J0w
         ZqWA==
X-Gm-Message-State: AOUpUlFt6Nx7UM5kvSAAwowJlgoSgiLp3Vr4RM9JNaSYXqAdu0X/sA9+
        Cv4wi6UcibvHgXAagdNNeHnMKdW0Y/aaqmQnVFg=
X-Google-Smtp-Source: AA+uWPyjZ29vxSGAfUJgqrmPHGviPEu+iDiwr0goSIwexwaakCgnLrrhlez4hoK+dM/pjOHqRNRAfKjaXWeoEvxzeJw=
X-Received: by 2002:a0c:e5ce:: with SMTP id u14-v6mr57003970qvm.6.1535057774534;
 Thu, 23 Aug 2018 13:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180823152502.3886-2-avarab@gmail.com> <20180823203604.5564-4-avarab@gmail.com>
In-Reply-To: <20180823203604.5564-4-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 23 Aug 2018 16:56:03 -0400
Message-ID: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] tests: use shorter here-docs in chainlint.sed for
 AIX sed
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, benoit@openbsd.org, kn@openbsd.org,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 4:36 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> As noted in [1] there's still a remaining recently introduced
> portability issue also introduced in 878f988350 ("t/test-lib: teach
> --chain-lint to detect broken &&-chains in subshells", 2018-07-11), so
> under AIX the tests must be run with GIT_TEST_CHAIN_LINT=0.
>
> I don't know how to solve the other issue, and this gets us some of
> the way to GIT_TEST_CHAIN_LINT=1 working again on AIX.

Does unindenting the comment, as I suggested in [1], fix the remaining
problem for you?

[1]: https://public-inbox.org/git/CAPig+cTTbU5HFMKgNyrxTp3+kcK46-Fn=4ZH6zDt1oQChAc3KA@mail.gmail.com/
