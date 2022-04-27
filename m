Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A95C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 20:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiD0Uqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 16:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbiD0Uqp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 16:46:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B51C0D
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 13:43:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id r9so2433919pjo.5
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 13:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KDWvEwPuwhAyGXmWEQSTOup8mN9ps8V3yH6LWd93dcU=;
        b=LfeZcgtsixszPv2mQofVUSudunCEhXPo0zaYkGzseoTQRvNHhvXf5oEnIUyO4NtMSH
         yvVWhAasI752Br2tN/jlSe45ULE6zy7HaOPgR/PWJz2QGUjq4YN7pPKzz4tQWEDhtFWy
         DPV/o+KiAeJA3sV20SdQYY7illgUnPAMTW3rWvL+85cGwYo7L2wSx2WXoGa/VyvlRpI8
         SRts9k8Q0iTr3KqeCAP70LFmNnSAEPun0DUJv2ZYhLv+JNtkt9AI4FUFk6HSCL/0+TMP
         9Le1cuuECKRCbz/qvjppzX9I3vTKHsA8lbPr4IKA9bvs2H8WWMNmxu2ZXvudnYyHovmw
         jfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KDWvEwPuwhAyGXmWEQSTOup8mN9ps8V3yH6LWd93dcU=;
        b=NMAhbCAOspsBosDK7azaryjhMXsDtHk0n/7YjHlSqd2Z8YhogG+1Ql7gqRD8w6OBm9
         1FQyunifHsv0/fSmal3CeLaOr3tFMtnHiudtaPKqWGy4I8Fz3BjBmTmQ6VNFAEtepcE1
         Xiw7FMYSwCHUYjMlROQn2ugcEVqCyA3Gw+ne2jGksWO0f8leA1NTt/yr5Fo7Tm0bU1vR
         TLsPI/XH86750+uHcap2pddPI8C1FNbMBQbT/1UJANN6hMHRqJqv7IQVDgslNWV8MhhM
         b9jkylAzStLOG7+F05pX83p+LRlNzeY4ct0uuYVf0LFqZSa6CDPDjjB/xP7Fiwc5SUmD
         vKEw==
X-Gm-Message-State: AOAM53190iEnxROPxoEk4utyYr7UWg6y90OL/hld6ROrgGo9P6qhjgZU
        E5A3JDzClbtJAV5p7aUsx78E
X-Google-Smtp-Source: ABdhPJwRK0nBBn1ENv+5FvUgu/ncQvxqe79cIdtF341RcmxkEPU/+zccKpOJXxyZLGeIhw7/tAH2gQ==
X-Received: by 2002:a17:902:e94f:b0:14f:1636:c8a8 with SMTP id b15-20020a170902e94f00b0014f1636c8a8mr30336588pll.130.1651092213132;
        Wed, 27 Apr 2022 13:43:33 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id g12-20020a056a001a0c00b004e1307b249csm21123181pfv.69.2022.04.27.13.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 13:43:30 -0700 (PDT)
Message-ID: <ed4a0e46-a45c-0b05-fc35-f82e377ea231@github.com>
Date:   Wed, 27 Apr 2022 13:43:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] MyFirstContribution: also explain cover letter in
 GitGitGadget section
Content-Language: en-US
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
 <afb80b8e9ee022cba9373f2191ee1619e5897b09.1651086288.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <afb80b8e9ee022cba9373f2191ee1619e5897b09.1651086288.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> The "Sending Patches via GitGitGadget" section mentions that the PR
> title and description will be used as the cover letter, but does not
> explain what is a cover letter or what should be included in it.
> 
> Mention the purpose of the cover letter in that section, and give
> examples for the title and description, leveraging the excerpt extracted
> from the "Sending Patches with git send-email" section in the previous
> commit.
> 
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  Documentation/MyFirstContribution.txt | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index 681bbefe9cd..96da32f7cef 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -808,8 +808,20 @@ https://github.com/gitgitgadget/git and open a PR either with the "New pull
>  request" button or the convenient "Compare & pull request" button that may
>  appear with the name of your newly pushed branch.
>  
> -Review the PR's title and description, as it's used by GitGitGadget as the cover
> -letter for your change. When you're happy, submit your pull request.
> +Review the PR's title and description, as they're used by GitGitGadget as the
> +cover letter for your change. The cover letter describes your proposed
> +contribution as a whole and is ideal to mention any context that might be
> +useful for reviewers. The title of your PR should be something which
> +succinctly covers the purpose of your entire topic branch, for example:
> +
> +----
> +Adding the 'psuh' command

Typically I see patch series titles follow the same "imperative mood" as
commit titles/messages (see 'Documentation/SubmittingPatches.txt'). I'm not
sure whether that's a rule written down somewhere or just convention, but
for the sake of consistency you might want to do something like:

	"Add the 'psuh' command"

> +----
> +
> +Your PR's description will used as the body of the cover letter.

Including the line "Your PR's description..." is somewhat confusing to me as
a first-time reader, since I was interpreting this section to be the
*verbatim* text of the pull request title & description. If this *is* meant
to be that description, then the note about the PR description can be
removed. That point is also mentioned above, so it's probably not needed
here anyway.

> +include::MyFirstContribution-coverletter.txt[]
> +
> +When you're happy, submit your pull request.
>  
>  [[run-ci-ggg]]
>  === Running CI and Getting Ready to Send

