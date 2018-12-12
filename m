Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35BBD20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 13:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeLLNju (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 08:39:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39694 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLLNju (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 08:39:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id f81so5960187wmd.4
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 05:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FtlZKJ6zLR8X2TpXAIVeDYBGQjJPvfZ2GKUPSW5CWzE=;
        b=kN6fHJ4G1+AfqR0TovLeUCPaSKuvrz6b89kNX7Wb3Jr57xfjkp6AqjbKsV0c8+MuqA
         qT+TOVK34FD5Jtvc6LDLJakw3nLIr5U0crxDjAK9W2TN+cw3Z4J/FECXgRCapotLLT4J
         uQS/qdlIiL2TRUSJYGRSTZvMsPoyvmTPFEqyeccCIpYr9z5SgsUwcLaG9cAfs/jNozDB
         HuJb3L2qw4HoOaSsQwmt+RXyiXLJl72URHq5HkgMNfrcdu+hc8BcvIT5ptxucLi4U61Q
         mVnAkHK5Rkf3FUIrLC9XQPXGWo8ssXUtC32ZDOyoJsEuwwVsGAELeGftmQT0H2qexiYh
         mbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FtlZKJ6zLR8X2TpXAIVeDYBGQjJPvfZ2GKUPSW5CWzE=;
        b=dGOm1NAXPTGYF5Wabd0wfJvAjBhp7AMTn5h9Z6jT3vtJlzEhuYydavpKCPvHGn0wpX
         eHIqZKov5e62dSZ+1ULN/Ck9yIJxNnZ2O/YSImhdqiC8R72KMtgCFAwgk6bIB4b0CuN1
         rSAvY2LmqC7qwDjkpz5FlxX8wlXVkhhOT1GaIXcSZ825aSM8S5pA0Rq9eioMrp8uAjS3
         QmKBgaDG8iI22UnuThVpa2LTszlg9bPzX4fBx+b8MA8NWo29habLXlgRReGkyWZAH7jr
         bXkubfSfDlbFgF3BLfvxS9AbclSwcN2soYY/DU5UeERYERVOQPxBOC7dDBYF0K3GcanT
         Hacg==
X-Gm-Message-State: AA+aEWbph1QcGLcrJK6pikj2xuInebs2Ngujxn7n+aiNbz/rtqtAy3TR
        toacuaZsT1h3iALkjqNLWF0=
X-Google-Smtp-Source: AFSGD/VOdtkCfkYc/dJoMPGXy2lZ1qubEKk+t5P9uKad4YVyoNlzmCigcoVcl7ks6pORw4vzAL0WgA==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr6632179wmu.52.1544621988216;
        Wed, 12 Dec 2018 05:39:48 -0800 (PST)
Received: from szeder.dev (x4db9614d.dyn.telefonica.de. [77.185.97.77])
        by smtp.gmail.com with ESMTPSA id v1sm22491778wrw.90.2018.12.12.05.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 05:39:47 -0800 (PST)
Date:   Wed, 12 Dec 2018 14:39:45 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] .gitattributes: ensure t/oid-info/* has eol=lf
Message-ID: <20181212133945.GV30222@szeder.dev>
References: <pull.98.git.gitgitgadget@gmail.com>
 <4a22502a318a65f144b3b6542cc5e711a1811c78.1544560544.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a22502a318a65f144b3b6542cc5e711a1811c78.1544560544.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 12:35:46PM -0800, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The new test_oid machinery in the test library requires reading
> some information from t/oid-info/hash-info and t/oid-info/oid.
> The shell logic that reads from these files is sensitive to CRLF
> line endings, causing a problem when the test suite is run on a
> Windows machine that converts LF to CRLF.

"What problem?" is what people will ask when they read this commit
message in the future.

Please include the relevant details in the commit message instead of
the cover letter.

> Exclude the files in this folder from this conversion.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  .gitattributes | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitattributes b/.gitattributes
> index acf853e029..3738cea7eb 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -13,3 +13,4 @@
>  /Documentation/gitk.txt conflict-marker-size=32
>  /Documentation/user-manual.txt conflict-marker-size=32
>  /t/t????-*.sh conflict-marker-size=32
> +/t/oid-info/* eol=lf
> -- 
> gitgitgadget
