Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E19AC1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 20:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfJXUsr (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 16:48:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38529 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfJXUsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 16:48:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id c13so37310pfp.5
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JlGtL/HRNvYRGG29/Qb3TxtIZNuVGsaYJT2pqt/UnDs=;
        b=WClDTNY5aW4xjVFjPlvVGby7269y8G4vLdFuKLtxIAvt03jz0AB2fhFD6NX5MCyh5O
         gkzlNsvV/VOdTFK7Ee7Mxbp+4DS3hTnXhgBdHC35s+nHkO/zV3J94Kcz/5L7i8h+4EiM
         wex6uGWLEbAY3WUCscnf15moedB4N9xtw3cNFSrQmWx4o4fYke+ev56HtHfdFHfs+6dc
         8RIdZPJURg2/Cv4199MAT8BChfx2vuXEEC3lv3OCydbFfDxSTH/msj1XkpuynfB7+/1R
         t7Jmw2dRgUWeD9ExDiDUgTLEclVl4NCWAmKt5BA1Z0dbf6ZwHx/13d80wMJw/8ICPsZM
         b8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JlGtL/HRNvYRGG29/Qb3TxtIZNuVGsaYJT2pqt/UnDs=;
        b=siXnTDekjveErvBpNgGripd2Ynwh9QEfyh76COs4GDAEQcfKnlhEQc2g2xCQ19hJAn
         TxVFZ/xTrnU/JryCTnm1JoxcAJE1ILsn9sqKjZ/wIamo/zDG2hfNkEoU9H3vc9WuydCd
         VOFqhEKd7PVplnh3smJsm9Hv+6q1auw8WH0AL5raRbng3obsJZWJ4lW0JX09CaiZh3fT
         CjRM164k35dl6mAkC30k196xvMdXTWP1rjP2yYArbLMpFvNCr2UVuSUwpmVMsq1bwxaJ
         mIcVL/OAa73nd22UUm2wHpECvmDXqHE/0Da31kW/8CYU5P5l8k9wInOyW2SHiEBClyPT
         fVpg==
X-Gm-Message-State: APjAAAX8uB77HI3DCZc8z4iUuOkPHfQ3C0VQdGEHYuio6Obn9Jrc5XLw
        Ne/48OsMZAy+fCHmCLHD0olghag6XfE=
X-Google-Smtp-Source: APXvYqzExbIsprgcXB2/JVrCrhstK+GZEQ4jeKLr4zrTgMvnLZVGYcdAHmVBuUm73wQ1A/ArjSqfxA==
X-Received: by 2002:a17:90a:cd03:: with SMTP id d3mr9423016pju.137.1571950125505;
        Thu, 24 Oct 2019 13:48:45 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id q30sm7271pja.18.2019.10.24.13.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 13:48:44 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:48:40 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] documentation: remove empty doc files
Message-ID: <20191024204840.GH9323@google.com>
References: <pull.412.v2.git.1571815556.gitgitgadget@gmail.com>
 <pull.412.v3.git.1571916551.gitgitgadget@gmail.com>
 <ee64a075d3074718a47da4ed369cee6923d0b460.1571916551.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee64a075d3074718a47da4ed369cee6923d0b460.1571916551.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 11:29:11AM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Remove empty and redundant documentation files from the
> Documentation/technical/ directory.
> 
> The empty doc files included only TODO messages with no documentation for
> years. Instead an approach is being taken to keep all doc beside the code
> in the relevant header files.
> Having empty doc files is confusing and disappointing to anybody looking
> for information, besides having the documentation in header files makes it
> easier for developers to find the information they are looking for.
> 
> Some of the content which could have gone here already exists elsewhere:
> - api-object-access.txt -> sha1-file.c and object.h have some details.
> - api-quote.txt -> quote.h has some details.
> - api-xdiff-interface.txt -> xdiff-interface.h has some details.
> - api-grep.txt -> grep.h does not have enough documentation at the moment.
> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

Thanks, Heba.
 - Emily
