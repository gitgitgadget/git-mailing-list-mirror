Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85861F803
	for <e@80x24.org>; Thu, 10 Jan 2019 00:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfAJAwP (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 19:52:15 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:36921 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfAJAwP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 19:52:15 -0500
Received: by mail-pg1-f179.google.com with SMTP id c25so4061137pgb.4
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 16:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TfufLW7jJqfeRkHEz6/UbeGuPG1p1YTWMTO6/RcO7lA=;
        b=rJ69rhwdCveE99kZpJDIqO591WxFpzmMOjoPhKrI+2xxdkHYEb+kY/neVf5Gd8/gRe
         GOGxejGEKdcSJwXva0joMVhQPS2n+8cG+Z84+DyYq8N7W1N4VRYjbm+mvnk+eDZdVydr
         CgeAbLIxTYkQ2RabZ47Npa6EKmNu2L/ipSAT6IoaJ/VMZO3pGUMfIjWd1yEWuLpg2nA3
         FrfXYFm+TIWd8jMJecb+uWIUyI6krPfy6WYxJ9bnuwS9IiZw+2F66gptfKy00rKvKJHZ
         /Q5OzYhb6bqHDNcBDZeZDCavOFbpBTPqD9zsn0mAkDyoGhRBk2vpAHeZT8BnRm+H/6Jb
         YtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TfufLW7jJqfeRkHEz6/UbeGuPG1p1YTWMTO6/RcO7lA=;
        b=MtAFPVX2nJBhY2bgts1ulSWInrUqpSR7BtCtnR9FdADmKx8VPGSnaFJvuPjLoqBZIn
         zoMrupZcclcA0e03CpLHGUQzafgVHvofjWOPRrlLg6xGJR3QCEFH+3UmMWPWSnOquWWj
         iryjyOQq5mjS5th0nS8hL+9QVJeBLGXnS5QRaldP1w0ojyL+ZN8SgsLOQx5WRIlFs9Bd
         7DkB6pljVScPiEs16YIZWoMfiizCiK5cgyeXmejBMkWjZH351WKdhQLzj3irvinl2ejm
         7xf4exDLp46zeuJTR5RQOQqCH981SsGG7iOs+IkNhkbOVkQpcyLyA1U2mddS3pQ8loCX
         llcQ==
X-Gm-Message-State: AJcUukdcdXEVGU6quoCpr+5tLZTNaVHyDgsKc8Q8SZHmxaopCHoXoMHe
        GuExxuzSSK9UP3N4zz0vzdyHhMLG
X-Google-Smtp-Source: ALg8bN6zxEm1i8L0KkyzMGWsqLLPNCBcRl8cglLFWWZPJtVFgt8o2B87LH3ua+m8kDD+/f6Ng2oODw==
X-Received: by 2002:a62:8add:: with SMTP id o90mr8031992pfk.210.1547081533668;
        Wed, 09 Jan 2019 16:52:13 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id h69sm88457248pge.4.2019.01.09.16.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:52:13 -0800 (PST)
Date:   Wed, 9 Jan 2019 16:52:11 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Petko Yanev <petko@fourcirclemarketing.com>
Cc:     git@vger.kernel.org
Subject: Re: A quick question about donation and partnership
Message-ID: <20190110005211.GB257275@google.com>
References: <2db2976a-12b1-228a-9c37-d31587af41b1@fourcirclemarketing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db2976a-12b1-228a-9c37-d31587af41b1@fourcirclemarketing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Petko,

Petko Yanev wrote:

> I'm writing to you because git-scm.com is a great project and I want to help
> out.
>
> I'd love to contribute with a donation or in another manner you consider
> acceptable.
>
> In exchange, all I expect is a do-follow backlink to one of our sites.
>
> Do let me know what you think about this proposal.

Git is a member project of the Software Freedom Conservancy, a public
charity that provides financial and administrative support to open
source projects.  You can donate at https://git-scm.com/sfc.

That said, the project would not provide any quid pro quo in return.
In particular, it wouldn't provide a backlink.

Please refrain from this kind of mass emailing in the future.

Sincerely,
Jonathan
