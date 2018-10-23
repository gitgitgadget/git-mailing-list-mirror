Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24D351F453
	for <e@80x24.org>; Tue, 23 Oct 2018 04:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeJWM2p (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 08:28:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37946 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbeJWM2p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 08:28:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id p3-v6so6481445qkb.5
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 21:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JB8WHJb1O9ET7hQGkPah6GSDnQUO/UfTbpyGOTuc+Rg=;
        b=kYaHlf7CozTMt2Q5Q12oZF95e0L+6IVrRPTyt6HW4OFippqK+MSLq5rnDmdROGqR6X
         Kv0b9b+0BHp++d43bw/JVH3erm02Dv2u8zjcuuabtdzoT5K9IXQpD9IrzDJCGFkoTwqJ
         YMaINJrcmC0bGee913ZWnxlkPSQaFrNXrJ3g28P0HnsziA6mTGJje0y0d0QVtuye+IBi
         YspLRCu/0oveUfg5isItTLS/IXTPR1JvCZUEnVHdCT7Fc4y4fRrKS3VEwoxH0YFEygUg
         VZZqpICu9XIwCy8cfW3z518zNtCieZ/TlWAGcSUzdtVpSr6CxTCjVUVwRRLX86sZOyWP
         Kj+Q==
X-Gm-Message-State: AGRZ1gKm5PitVph1nqfn/vd3Mtlqv1Q9hQXzHcJ0CtK9uDjhG5pv4Hbb
        cOFA2XBXI9OWJJxGFRql3DjjodQjUiFBV74bLO0=
X-Google-Smtp-Source: AJdET5eIOgBrNfpXGNrZ3VtTRC/r4imVxY//AETNLPfAd2n/x7GA6AkOY/6GTUWV/7lh+c8hwgYly/XsdrJ8x5Ru/KM=
X-Received: by 2002:a37:8bc4:: with SMTP id n187-v6mr10735419qkd.220.1540267633005;
 Mon, 22 Oct 2018 21:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwos19nr5.fsf@gitster-ct.c.googlers.com> <20181023035341.15398-6-ischis2@cox.net>
In-Reply-To: <20181023035341.15398-6-ischis2@cox.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Oct 2018 00:07:01 -0400
Message-ID: <CAPig+cTLxkixXizKuPb8iGxOfb0Mx8CHSkcwiK=VxxHW7iLKBw@mail.gmail.com>
Subject: Re: [PATCH 5/5] t7501: rename commit test to comply with naming convention
To:     "Stephen & Linda Smith" <ischis2@cox.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 11:54 PM Stephen P. Smith <ischis2@cox.net> wrote:
> The naming convention was documented [1] but this script was not
> renamed.
>
> The original commit message indicates the script tests basic commit
> functionality. Clean up the test name by changing the file name to
> specify the intent as documented in the initial commit.
>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
> diff --git a/t/t7501-commit.sh b/t/t7501-commit-basic-funtionality.sh
> rename from t/t7501-commit.sh
> rename to t/t7501-commit-basic-funtionality.sh

s/funtionality/functionality/
