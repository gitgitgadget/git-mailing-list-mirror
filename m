Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D2C81F790
	for <e@80x24.org>; Tue,  2 May 2017 19:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbdEBTJP (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 15:09:15 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34096 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdEBTJP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 15:09:15 -0400
Received: by mail-pf0-f175.google.com with SMTP id e64so1531921pfd.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gzpcRUDsf8B4vjK6w2y/bdH7ooWQ317FqYtxFEdWQN0=;
        b=uYyKq1sVCVSp/lF1F4nydMvfi+Wesso6TbDaJoGJg5+ZKxmTYUFQfzyfo1XmPRlKOr
         rCcEzvJ0JKfI8ub4KDF9EbN2/tmIu0GxgUwApL+DDN8aEaQJodwjU9feP42T7DMYlaBS
         Kc7fQ3TDZa4N4TslZ4bZVNtUl29yuRcYpw2HIJEagzNo32s4Gka2GIotM6d8l8B/J5j6
         1MbHwV4qbVoMd8gCG1HS3fn9ZsJtQLemQ0XndepRjsIG4fXOnxMq+vkmlLI1fioBIMPb
         XDKXMZh6bnW3o8YChe3R7RIoBCjc9FySzHoAFQb61wMP1lg92Aif2YYrDMDj0n3g7bDZ
         hErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gzpcRUDsf8B4vjK6w2y/bdH7ooWQ317FqYtxFEdWQN0=;
        b=e6zjoI5dkeLrAdiVaSjJSvz3uCigUu2PGCX0izmXPuEoQ4LrvV+FjnBW6g2BrZwOc0
         hL/p1ASHtkHun6+hfawBSYaS6iiZ9k2plVh0vyKystw0IEO3XsDJBbfw7Mw6sAqxhz/n
         hclmPhz41g5fIsBUhxRD0FnvhRNq0UEQyL3KJf0jfV4/ismIZlJRf9Lq4UCw/tqlBc2J
         Qfrjq/WSCOJMcKnf+ScyGrknzWBL6TTIZ2vz5cS9Ea1ya/fwI/9HDmILxoHD2iO0E89c
         xHoUgV5WveMMyX+Tym+A2vsmoI9n29FG7U9aVZwb03RIr0BHm5GDvYXlwjmolbKFrXZM
         huQw==
X-Gm-Message-State: AN3rC/491Er0k6TSNdJm8DN1dLah2N2ZW8cDkLczS8y3Z/rsJKYpJKTf
        tPcK/VbK3TNgaO/R
X-Received: by 10.99.106.138 with SMTP id f132mr34155517pgc.36.1493752154259;
        Tue, 02 May 2017 12:09:14 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:bc40:7b3a:46b3:66f2])
        by smtp.gmail.com with ESMTPSA id 194sm4311345pgf.62.2017.05.02.12.09.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 12:09:13 -0700 (PDT)
Date:   Tue, 2 May 2017 12:09:12 -0700
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/53] object_id part 8
Message-ID: <20170502190912.GE181268@google.com>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01, brian m. carlson wrote:
> This is the eighth series of patches to convert unsigned char [20] to
> struct object_id.  This series converts lookup_commit, lookup_blob,
> lookup_tree, lookup_tag, and finally parse_object to struct object_id.
> 
> A small number of functions have temporaries inserted during the
> conversion in order to allow conversion of functions that still need to
> take unsigned char *; they are removed either later in the series or
> will be in a future series.
> 
> This series can be fetched from the object-id-part8 branch from either
> of the follwing:
> 
> https://github.com/bk2204/git
> https://git.crustytoothpaste.net/git/bmc/git.git

I've looked through the series and overall everything looks good.

-- 
Brandon Williams
