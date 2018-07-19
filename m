Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCFC51F597
	for <e@80x24.org>; Thu, 19 Jul 2018 18:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbeGSTF2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 15:05:28 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33346 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731994AbeGSTF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 15:05:28 -0400
Received: by mail-wr1-f51.google.com with SMTP id g6-v6so8985853wrp.0
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=HVcT4cAt4wNwovESxbM1yK1azoAlK/c1BYO8H2xve0A=;
        b=CVXP+LevtCXN2tbayLZ3wzNyatC95bfIh86nZJr56MWChNu7b9+zuoIfArRm2TMUGp
         kDOj87kkAXG7d1AyW9s99RIhkYrXuScBQy5E20d3xKnhXTC0kIFe8Ubfxram7VPOd3g/
         7TkiZ3GifhoV/vOhNAR+7nd+CShnnuJu+XXQSynl6p/mNVx1GbXsCV7bLhJ8fA5aDAkI
         MJyWpzQa7860FivX9xuf2JFNdLC4QwZdESeKYuQflOdNub3UWT+N7mYyGNYf2jWIKOSc
         ZC/hTdJ0kBodgdTIOK+pItubj6fuyIjl5QCoOZIcy9Yb3wj0+nB8j28jUiJ8ZyAwa0fU
         SfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=HVcT4cAt4wNwovESxbM1yK1azoAlK/c1BYO8H2xve0A=;
        b=HFnPR3b2cNbXb5W1v4Jvkvjb8Zzfot064FYCp9q15lOSaR7ZOPhTv4s+Pjh5/NQ+7/
         Ev9zeP+4s1eZf/RCjYUaWaz5jpsRDdfiuReLlGxC7bYOVlxgRjk5oJWouuMziCJ9GO0a
         dmtTQ4O37vGtHp82mnOriRWEvGLDKCSPH9QpDIXY5WJcLNy6a3iexW1eDXg7KuYBBD2e
         3IYT7IOs4q9kSaRdq+Mq1Zuf8B1dA9nsq6c0EXIS26GJGGFagboefJuxJja4zqcLffWA
         KExlIXVMudtD1wXNi6aotanXdH8BNz/d4irh8wCecSX8RiIdcXZlEby5KMFYyRgbZIlx
         X7KQ==
X-Gm-Message-State: AOUpUlFYQghKHJNFAWuRvKTyo0dawgf/1cDy5Icd4BAfNmSoezlEI1ES
        exsCQHDf8BLxTk6HSw43b1w=
X-Google-Smtp-Source: AAOMgpcxstOXWvfM95eCve8gAmjYGo+3RlqP1mzEb2IS0tjAHTKsC+ru8DeVNQdUkjPKqWWUYe/5GA==
X-Received: by 2002:a5d:4acc:: with SMTP id y12-v6mr7708515wrs.132.1532024466560;
        Thu, 19 Jul 2018 11:21:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m17-v6sm11207268wrg.65.2018.07.19.11.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 11:21:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 02/23] archive-tar.c: mark more strings for translation
References: <20180718161101.19765-1-pclouds@gmail.com>
        <20180718161101.19765-3-pclouds@gmail.com>
Date:   Thu, 19 Jul 2018 11:21:05 -0700
In-Reply-To: <20180718161101.19765-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 18 Jul 2018 18:10:40 +0200")
Message-ID: <xmqqmuunf5ny.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> @@ -256,7 +256,7 @@ static int write_tar_entry(struct archiver_args *args,
>  		*header.typeflag = TYPEFLAG_REG;
>  		mode = (mode | ((mode & 0100) ? 0777 : 0666)) & ~tar_umask;
>  	} else {
> -		return error("unsupported file mode: 0%o (SHA1: %s)",
> +		return error(_("unsupported file mode: 0%o (SHA1: %s)"),
>  			     mode, oid_to_hex(oid));

This is no longer sha1_to_hex(); the "SHA1" in the message should
probably have been updated when it happened.

Cleaning it up is outside the scope of this patch. 

#leftoverbits
