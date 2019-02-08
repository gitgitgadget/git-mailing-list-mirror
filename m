Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A4341F453
	for <e@80x24.org>; Fri,  8 Feb 2019 23:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfBHXwT (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 18:52:19 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38070 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHXwT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 18:52:19 -0500
Received: by mail-it1-f195.google.com with SMTP id z20so13362146itc.3
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 15:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHjsBl8quLcuR1saUa1tyJgFEv056s8t2IkEJveFje0=;
        b=hdX4M28y3BW+FsYh2Enox9jD/y7ZrvgOcQXegIZhOvR9Tfc5CBlkPyIajM88bc9VO8
         kempVwky0XF0E9Wm8xxFoRiCVL3irt66rL4mOxVmT1flSOQN+wlYopn+6YqOkFTcq+1W
         ErA/i1iYkNcUSaEQxhb7iEsMrP/JjNe8OLRki/TP5xcPriuXdVNCMq7jfaFmXQqfiZ7c
         7SUIW3XzkcInJLYXaj3h/7s/lC+6JDBdQvC7lM1WfLUYjKpye6krJv8Y9/+pVtHfBSg1
         P+7yqlt5hWUr/FrKRRfz6O1vkHSA9/WxkZaNL09RSODeqkGzBM266y7Cf2NF0RZWV+RE
         3pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHjsBl8quLcuR1saUa1tyJgFEv056s8t2IkEJveFje0=;
        b=LEnSjCf2PddbPJOo7Jyizr6A3ImVafUxmYkD463j5QMCrMo/Wzg+9MMxYRPVwUFz5u
         NUgnIybSE9HHtDy4mLV1LGVwX6Cqvpe/LoBkXZM0Py62iM0HBKa2vcD5uR1/mvbh2WI+
         sdyQmMNZLLORTr059fjo7710E15hBkU1cWBDKxZopT0OFo2QDRkQsVcugsTs/HGGp8BQ
         k7UePIOnf75wdqsljJedHiU98M99x01Akh0I1vA2dh992HYD8E1ypjIjxWCVmig3saq1
         ExKNpsOxgorwJWJDAcnfRxLUPDo7/yPSiyWNMDGsOg0JJfCV1Dy01r72/a4U/yfLcjcX
         oqpA==
X-Gm-Message-State: AHQUAuYB0uHofTK/KwBsxsIlhyX3kkHYmdlf4kGZ2/tOhYdTV23Xr2dp
        cPJQQdpE/WeXd8HnjRisEhF8bAh2d+6UaTvRdHm4hRNHgLU=
X-Google-Smtp-Source: AHgI3IZ0WP2w8hSjSMUV+9O9o+Th/3oZZhc8E5zuh75QG++CwJaBW9KPlzU8GmDK8xLgoamd4XxR9txkaGdfqkceyCQ=
X-Received: by 2002:a6b:b408:: with SMTP id d8mr11425569iof.138.1549669938291;
 Fri, 08 Feb 2019 15:52:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549534460.git.liu.denton@gmail.com> <cover.1549624679.git.liu.denton@gmail.com>
 <77af7e4b2fc094d8cd31164625ef3339e97e1cd5.1549624679.git.liu.denton@gmail.com>
In-Reply-To: <77af7e4b2fc094d8cd31164625ef3339e97e1cd5.1549624679.git.liu.denton@gmail.com>
From:   Denton Liu <liu.denton@gmail.com>
Date:   Fri, 8 Feb 2019 15:51:41 -0800
Message-ID: <CA+eFxx4DWiFY5aqbggQWCLQE0AnWhOvYMjgyPhui1WGSNqQtZQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] submodule: teach set-branch subcommand
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 8 Feb 2019 at 03:21, Denton Liu <liu.denton@gmail.com> wrote:
> This teaches git-submodule the set-branch subcommand which allows the
> branch of a submodule to be set through a porcelain command without
> having to manually manipulate the .gitmodules file.
> ---

Sorry Junio, I forgot to attach my sign-off to this patch. Would it be possible
for you to tack it on for me please?

Signed-off-by: Denton Liu <liu.denton@gmail.com>

Thanks,

Denton
