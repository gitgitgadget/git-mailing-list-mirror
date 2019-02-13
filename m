Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183FE211B5
	for <e@80x24.org>; Wed, 13 Feb 2019 08:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390567AbfBMIPW (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 03:15:22 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36743 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732965AbfBMIPW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 03:15:22 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so826863plo.3
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 00:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=krqTjDG3PWFZV7pJuKUyb1dumjPZtIK9De2wHW/URPY=;
        b=fvJl2ew9BxK0QRxB9MU9ztHNjQKmbTceB+3PagAMgFHjryFBL49eyNd2XyaYqg2B+y
         kpAYBBaSF6Nqtq3v6ABEO4qhAXiXWf1AxOtRtzyLxhj374fSwn89zhWCflDAFT3sU/Fk
         23CPUtiwbqpydVbHMUk+MkKb8YXUoh+FiZA+zjsy9BC7v7eQ+QUE02wjsmvCBmXaNEdx
         HYOnRJTg+egRDbE+NrdiXsjf2W8vSewcN/ex9OtXZjt/LObqf7p6zv6rE7ZNWVTjrIj5
         76TYSLcbQgGXRPAq50MtvRVuowLl8hbPXzzpc46POB+QZMkho8aEMjy232zKtQJ8Y9bB
         AlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=krqTjDG3PWFZV7pJuKUyb1dumjPZtIK9De2wHW/URPY=;
        b=pKdEcs4TCJfY3hLS2a0ZkYbQdVR8YT3X6mE5iqHzdDnHg+NkjF3J4pOaKZUTz1urAZ
         AfCsHXIInhLTIBbv2uRP0H8Y5v45PDDpwTFIWqPMBHxT0gdGj/e33RNIO3jayNsQOMDt
         zdroUjtjREUN/NYI6PXXmCHREPjJ1Ir9jmh7blEbGuobJTjDHetRtDmGMA/wglb24bnh
         5+4eT3HBoCguKyeFGg+S30AexiwNW1Hd0y82Fxwq841HSFdWAcX91oAnt+M0/67Yhc2i
         o6Z6OF5AteTGz1J6YSeei90SciclIrlat9jRj+M0w7gMGnxYIfuWw5AgkqvzgtWU2+Es
         ZAVA==
X-Gm-Message-State: AHQUAua5EqSb+58wATeS0km9RKdSobXHODR5mLzb8YAvUI2REuR4y2oD
        MDBB+fw5O3QT9hv+EYU7Gfs0CyPJ
X-Google-Smtp-Source: AHgI3IbFYdsxBydPqLPCmrVm0I2S0P5mZ2llIuVKOJOSqixByVDjkOw0f4GOLMKE8tvNVNn/oDJJ2g==
X-Received: by 2002:a17:902:e087:: with SMTP id cb7mr8547084plb.313.1550045721540;
        Wed, 13 Feb 2019 00:15:21 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id t24sm20566799pfh.21.2019.02.13.00.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 00:15:20 -0800 (PST)
Date:   Wed, 13 Feb 2019 00:15:18 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com
Subject: Re: [PATCH v2 2/3] git-submodule.txt: make subcommands underlined
Message-ID: <20190213081518.GA21926@archbookpro.localdomain>
References: <0b62f65a8016c41b96aa6caead366e1ed9dda333.1549944164.git.liu.denton@gmail.com>
 <cover.1549965172.git.liu.denton@gmail.com>
 <b0c124d022bfa9a0bbe0c9494df24780b67c8a08.1549965172.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c124d022bfa9a0bbe0c9494df24780b67c8a08.1549965172.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 12, 2019 at 01:56:11AM -0800, Denton Liu wrote:
> In git-remote.txt, the subcommands are underlined. Following that, we
> also underline the subcommands in git-submodule.txt.

I'd like to retract this patch. I realised that between git-remote,
git-submodule, git-notes, git-stash, git-bisect, git-reflog, it's pretty
inconsistent between whether it's formatted with the underline or not.

Also, I missed the underlining of the subcommands in the body of the
document.

But if someone thinks that unifying the formatting is a worthwhile
pursuit, I'd be happy to reroll this patchset to include this fix.

Thanks,

Denton
