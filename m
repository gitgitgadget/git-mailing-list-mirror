Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 681BC20401
	for <e@80x24.org>; Mon, 26 Jun 2017 08:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbdFZI3V (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 04:29:21 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:34976 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdFZI3U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 04:29:20 -0400
Received: by mail-wr0-f170.google.com with SMTP id k67so140056037wrc.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 01:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XdFoQK1E6J9KX20S7EbzeLzjrKB3CprC90pWuVtWhVI=;
        b=PjT7sIVcsjqls5c6qehnrJEy/KqDfY8DWtpaW9fKwmdjTfyEM1MLrCNNHCaL1DNvBi
         FRvKn2qJBlqolnkKZFTBNfFBeVkCUOI0jASN7rHg6boBcMgQMtidkK/jP6R2lYDnYTQj
         u6Zopt8sM5DiEPnSbgKNdLUlq1nIUmPjxZeOXipdZK0TmUZRqBrEYoV8r7NRfqwxp43A
         F6PW8+j4iA1km4zHcwrGnrBvRqGi2Ql2CPermfY3slatmCqF5v7XnlPYIjagfNn7z/m/
         +7+NYQ9U0cO7Nx3R58eszt2aqp4pfjbizQt59xkWc9UYZUh2AG8oAmRVVE9GX1Z5cXMB
         860A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XdFoQK1E6J9KX20S7EbzeLzjrKB3CprC90pWuVtWhVI=;
        b=cReWpMppLDjf6zoOTzSgUaorARuAUqHaCBoR92hdBOHccn/JsOT3mGtdSJFA0sj0o+
         K4pOVTP1mZDGoMr7JcibwiC/97KNHQABgDWKYQVTeACYFql3B6AKtsMQ5+Pg97REIjB5
         yNVhaHxt6qb/tvhmB/DH3D5s0UJo52oy9MM3SUyMfat4BRQ4adCm8jba9/M37qb97rxh
         RkdNN8SPHsc8LzxcJzM8I65q7h5oOLowe2WwV67aaclB6FOpkUHM37E/3iX5rnwLvkCU
         aZtro+gkPyjm2aO3ysQzUVflUF6AMhqYMRd1a3DGuA3Q6hp94sDm3Z4KNCJdPzABqWxt
         knjA==
X-Gm-Message-State: AKS2vOxuKFH2sVCjyaVjmtcsUfpqGrOyAK/3WW1S05Dxp3CC1ovaNV+5
        Ab3bfwlM1UMtgg==
X-Received: by 10.223.141.138 with SMTP id o10mr14362343wrb.69.1498465758862;
        Mon, 26 Jun 2017 01:29:18 -0700 (PDT)
Received: from [10.32.249.40] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 22sm15159538wru.29.2017.06.26.01.29.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 01:29:18 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jun 2017, #07; Sat, 24)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq4lv57ypx.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 26 Jun 2017 10:29:17 +0200
Cc:     Git Users <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <BDD05B04-C845-43B5-8E22-D215403D2A6E@gmail.com>
References: <xmqq4lv57ypx.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Jun 2017, at 01:25, Junio C Hamano <gitster@pobox.com> wrote:

> ...

> * ab/sha1dc (2017-06-07) 2 commits
> - sha1collisiondetection: automatically enable when submodule is populated
> - sha1dc: optionally use sha1collisiondetection as a submodule
> 
> The "collission-detecting" implementation of SHA-1 hash we borrowed
> from is replaced by directly binding the upstream project as our
> submodule.
> 
> Will keep in 'pu'.
> cf. <xmqqefuab571.fsf@gitster.mtv.corp.google.com>
> 
> The only nit I may have is that we may possibly want to turn this
> on in .travis.yml on MacOS before we move it forward (otherwise
> we'd be shipping bundled one and submodule one without doing any
> build on that platform)?  Other than that, the topic seems ready to
> be merged down.

What do you mean by "turn this on in .travis.qml on MacOS"? 
The submodule is already cloned on all platforms on Travis: 
https://travis-ci.org/git/git/jobs/246965294#L25-L27

However, I think DC_SHA1_SUBMODULE (or even DC_SHA1) is not enabled 
on any platform right now. Should we enable it on all platforms or 
add a new build job that enables/tests these flags?

- Lars
