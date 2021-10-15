Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62068C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 21:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B2F660E0B
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 21:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbhJOVHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 17:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbhJOVHC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 17:07:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0299C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 14:04:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so8178259pjb.5
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=oKUvPSC5xs4S3mB1b5MRj40h/dlNW+zOXBLJynKqp10=;
        b=A1VYN5jJ0Lo7Pca0sHB7vzqVvHl2O6bjlLpzyoZSzULNqoDvRpVonCJHCWcm1V+yix
         rjYHTksruWXiwMrgNhpYQ0ZJIFQ2NclQUAAzXQ9vJu54isznRhlyimRjDYUP21rjKg3j
         aOjgdBylm25ZZ3Xlj62UuvcPIYchLpqpRYGawGpngxBS01jCSdht8SsLWNiR81fjvLz1
         itgG4KcT0CzI2jdCYOjZtNOyYp8V75GjSrwIgcRgJKgVJKuD0EayfbPl+SabVvnvD1sF
         8Bn3krmdd6DWnOrWnuhd6hdMHDdaDF0cItV7qA9pveM1uERXUUlNOgnf0dxxFurvwxId
         u1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=oKUvPSC5xs4S3mB1b5MRj40h/dlNW+zOXBLJynKqp10=;
        b=W70mO8a/cE5XNvE810z+7v0GhF2abH5p6DX2pmIwIsWBFn2KD2+kJ7WNYi2AGrcRNX
         zqIwsvBIo7gj+ezoSUJgcj5mkv962j1EWvmTp3P/ndhL5O92tAMYpvsbOKPywUo42VpV
         12E5JP0tZTDda/1z/ehsNa/gjH8hqoZRsd2eDK30gZSitZeweLsnZaLTnr4VLvxGmtoK
         LMkPwBwK4gjrMMja7EqHoHSQctwSz4RZ5c8dyspmcaU4ZwALClPZ1ZzaFoirFVNmAVoL
         vRuOjL5HSWdzb5lg4VozlFta80GUfsBxMKCJ+oDRYTt3cuhd1NyOx4mTPwwtxLrMCvJb
         OpPw==
X-Gm-Message-State: AOAM533mPhMXzlRu3UnOqxGPKnknEzpVuM+WKTKkDBVuSL4TrEqnzxQF
        09cvDO9JU9/S0sC5AGt0faG1XsUmlGE=
X-Google-Smtp-Source: ABdhPJx4PG3zrkkPBIsR+ls6Cygk8hMT+W3PG6AhxdK2OSEIBtai5h/MM2J18jS6ONAGTZR3m9yFOA==
X-Received: by 2002:a17:90b:3797:: with SMTP id mz23mr16213784pjb.216.1634331895438;
        Fri, 15 Oct 2021 14:04:55 -0700 (PDT)
Received: from smtpclient.apple ([2600:380:8022:3997:d5f1:4479:a7fc:d7a2])
        by smtp.gmail.com with ESMTPSA id s30sm4780894pgn.38.2021.10.15.14.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 14:04:54 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Jesus Alvarado <mannyman4208@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Fri, 15 Oct 2021 14:04:53 -0700
Subject: Trade 
Message-Id: <BED4B0A6-0CCC-4D29-8CF0-82C38AB6F344@gmail.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (18G82)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The adult world is what got millions of Americans stuck together in Trojans p=
roblems world economy is affected by this.

JMA

