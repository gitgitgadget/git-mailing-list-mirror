Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88A1A1FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 01:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753390AbcLHBKC (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 20:10:02 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35657 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbcLHBKB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 20:10:01 -0500
Received: by mail-pf0-f181.google.com with SMTP id i88so79797044pfk.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 17:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fimXH/Rf4KaIpe9v4fXaaLuilS+sgR/23LcE25Jr/+g=;
        b=Xp9GEsAlyUji3u6/91s2MpEeDjTIe1OX4qZbfvren+auWNQiT/bP1gwfaP6IQ6GXBJ
         s0byxwLH9XRiI2KidHtL/sooK1EiCBp0kSC5GGoVIwKt8GPCexgQ03rcm/S2IJP88Cu1
         djSZs8jZy4EgUJ7uNAWGUBCAGDdhG4YZd5Fun7iXwBwbPHea9LZYfAgA/mq55xEsQRpG
         vwePojpT42e7fmjIJSFq7nhcRJk8qQUVYMkcGatJMIKz/cnVLE/HNkPBqwQjH/oUkiZn
         fW6acPWxwzpForyA5Pp2n8841KGCgK5y5v8z6XAZTSGjk82EOTEXA7T8/ryJYxwRNz4m
         J2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fimXH/Rf4KaIpe9v4fXaaLuilS+sgR/23LcE25Jr/+g=;
        b=eyFFGRVSk/oNZKF7R95OFqF7KqfvnzU4FZaI7VQ2b0MR+HdcjbKBP22zLb01Oa/3oJ
         JM5Jh1sJVx7WTFyvauelcsyqMXNrmDmPHbxquXIw8xbzpo6vP1NdkTr/GD3xXUf6aemv
         3kzQ1qsomybqkRpZNq5LeNfpGu3nB78AU5NNkEBimMfwyyP1KwjIDm8TE06Pa75Q6U5x
         GCKWY2gB8a9LUpmmuegS78ezbJBwiCqYMJRfbRH/ZbGa1NsYU3haqnn5x+WJ3NyUOkfT
         X1tdpggIWanXQsAenEXBLGRAz3fAkGzJr0JE1xQtSccEEKQEZfsyEEVMA5WP6cjWS1hP
         Jp/A==
X-Gm-Message-State: AKaTC00mMuNaAbNISMPSolGiYFoy8odVX1JFHCLRD4WEOIWhU0+dCwKxIw7DZDWXBtvOm58J
X-Received: by 10.99.47.7 with SMTP id v7mr128208400pgv.39.1481159400490;
        Wed, 07 Dec 2016 17:10:00 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ccae:4719:31da:e07d])
        by smtp.gmail.com with ESMTPSA id o126sm45400502pga.34.2016.12.07.17.09.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 17:09:59 -0800 (PST)
Date:   Wed, 7 Dec 2016 17:09:58 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
Subject: Re: [PATCHv5 5/5] submodule: add embed-git-dir function
Message-ID: <20161208010958.GL116201@google.com>
References: <20161207210157.18932-1-sbeller@google.com>
 <20161207210157.18932-6-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161207210157.18932-6-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07, Stefan Beller wrote:
> +		argv_array_pushl(&cp.args, "--super-prefix", sb.buf,
> +					    "submodule--helper",
> +					   "embed-git-dirs", NULL);

check the spacing on these lines, looks like there is an extra space
before "submodule--helper"

-- 
Brandon Williams
