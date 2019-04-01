Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C272920248
	for <e@80x24.org>; Mon,  1 Apr 2019 10:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfDAKrX (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 06:47:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39814 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAKrX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 06:47:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so11360679wrn.6
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=YxRYA3LVuV/LL79azomBsYlO33icj8+6F31yZUaqNbs=;
        b=Qk3HhEZjHTB9DCOs37Npl0W2uWOBn1i9mB+IhV5iM/4QnrFgv+iB4J0D/mP3vMGWEq
         7BI2KUnnMxPZEkWiGba/JX2J99gaR/Jd3P4oofZAOcQgsxal15gKLvNAphe1VRMAz8GY
         zHo8NufUKodrt9Kv1a+NwcxqDuwf/ywn1fFcuFRtm3Eh4gLgjc0L+AQ0oIDJ2FN6/ayE
         OQfmWFloPnuX7dInAd2vMDoqmQShKYXrZDMVI76BZotXwwpX9ccxfb9KJ6W7NeM/VchV
         jFt2kK7GvatrHUox/GtGwPQm7wVObjYE3LH9oN7x23Ugzy5Phf7tfUjteniiSP5bly6Z
         JMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=YxRYA3LVuV/LL79azomBsYlO33icj8+6F31yZUaqNbs=;
        b=lQtTL9Ip3bS6gFexX+HFEa41rNn9GAGg36gExiwtFZWDqtWh0VIarX5sa/VOnjhTB1
         3ncDSiha2HQpz/FIjPgCU9khWCt70ENS2oNZkTGcK2ySHw+1TDzVL4alTOX2BmSZ6ubG
         a/ecxjiHo70l81Ir4iiETgM05C244AeLzCcHlZ9RyvIjd7F3FmO4HqaEc6z1c9TcyRmb
         rJSHLNCq4hApeWfDVnzS0n0zBDzJkYDIwJFl3eP+ji4QawR/K47B0fUpjq6u+wjCLz+1
         tycxgES4gjB/ypFS2Rzug5k8NVV1GLaHlt6UKlkWAWDGI2RDleP/6BGADhP1XBzvYXx1
         EGCg==
X-Gm-Message-State: APjAAAW1Kk8owwzYmdi8x1hYVaYUYalB0Ht2CJ9DGzWgYqhsra9f6yxg
        V/cB5P/RsAmfe0FqCu26Pb8=
X-Google-Smtp-Source: APXvYqy9/kwpTffeimC0WkgtZ6+SH9B1roxvjGB2yjLTqTeKHq5itWjsQNZrX+zCRV468MYsYH1Ayw==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr6807770wrn.108.1554115641750;
        Mon, 01 Apr 2019 03:47:21 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id s18sm8974560wmc.41.2019.04.01.03.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:47:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] read-tree.txt: clarify --reset and worktree changes
References: <20190326120939.31657-1-pclouds@gmail.com>
Date:   Mon, 01 Apr 2019 19:47:20 +0900
Message-ID: <xmqqmulauhmv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
> index 5c70bc2878..12a25bc954 100644
> --- a/Documentation/git-read-tree.txt
> +++ b/Documentation/git-read-tree.txt
> @@ -38,8 +38,9 @@ OPTIONS
>  	started.
>  
>  --reset::
> -        Same as -m, except that unmerged entries are discarded
> -        instead of failing.
> +	Same as -m, except that unmerged entries are discarded
> +	instead of failing. If `-u` is used, updates leading to loss
> +	of local changes will not abort the operation.

"git add $file" makes a local change to the index at path $file",
and reverting that local change is what "read-tree --reset"
primarily does.

The difference cased by presence or lack of "-u" is only about the
working tree files, so s/local/working tree/ perhaps?

I'd also phrase s/If `-u` is used/When used with `-u`/ if I were
writing this.

Thanks.

>  
>  -u::
>  	After a successful merge, update the files in the work
