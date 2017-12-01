Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E9220C11
	for <e@80x24.org>; Fri,  1 Dec 2017 03:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbdLAD4R (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 22:56:17 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:35942 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbdLAD4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 22:56:16 -0500
Received: by mail-it0-f65.google.com with SMTP id d16so1056039itj.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 19:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FhgtsBIA2C8ukHp/E+qkXru0RtLEuUvBOM99ZMj3wNg=;
        b=qvaAurwP2hKN1r5Mg5zM6gckPTU8SwlzrCPHBFq7HHTzbKMzQ671Msf/e3anCashDP
         SnQU7abb+ywGt7envMtaA1vKjhFxNp9LOiPwhkPKb4ZiagF96FwiIuC/W8B1FwJdbU6n
         +TollpqgjmzyHOlkHJdG+SY4NxSQLzRhLnLkKqqgB0GXjKY+yURRHSNUaY1btkSFbz5K
         KN/d3/0Sr68bKVMJRygK4ZpmUMygGCwWGjv7xU5VgAHaBK+I4lw9i7j0z9JcFpYRcs4r
         VaMA1+kjR2NzoElpGZ7pU0bRndQc1N5kAa+WlR58uAotdsnru4eK/b2YKnxlkK2jBCwN
         GINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FhgtsBIA2C8ukHp/E+qkXru0RtLEuUvBOM99ZMj3wNg=;
        b=kwL1b/IFgkW/DG//UQGX7MW/iVT0MQC9MymGbD8Vo+81Rj19nEy6xoFvNfGT/Hp9D7
         ofwNj1lbB7hv+eO3kvC32+TboGThcomuO38hevg72nX4+QExS/o9DzMGs/pQvWMcxDnl
         +QN9swIAcFzQgWB25quX1uoLH9KiXWjFlTQlvrDbVJK/iIElxz+CtwygIRcbU2qD280O
         ixbV7ayngySUhdq+yJZDlfnJCWWHlfp9njpICLrp5nLsgI+TJjy9vR81KeKQL8wd05/K
         s6wwdnMRCqj7U+k/vsx8p7pCQyQbVJLDK5O7XpHd5dQzwWHd+oO9l+PRga9iT8ZTFod+
         516Q==
X-Gm-Message-State: AKGB3mJwPqFD37q9BTWFXWErWxhDBrlCwGNEM33zQu5gJo9A1FlwZPCz
        wWp2Gvh5MQCs5vDTPyIgAZE=
X-Google-Smtp-Source: AGs4zMZhIAui/nwOnkt3Y7Sbj6jepeyT8VzwSn0YW2cBaP8sraxE7WUzDxIFLHFdByicVK3qALg8fA==
X-Received: by 10.36.138.1 with SMTP id v1mr179800itd.103.1512100575594;
        Thu, 30 Nov 2017 19:56:15 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id c8sm40645itg.15.2017.11.30.19.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 19:56:15 -0800 (PST)
Date:   Thu, 30 Nov 2017 19:56:13 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH 1/2] t/lib-git-svn: whitespace cleanup
Message-ID: <20171201035613.GK20640@aiede.mtv.corp.google.com>
References: <20171201023239.26153-1-tmz@pobox.com>
 <20171201023239.26153-2-tmz@pobox.com>
 <20171201030453.GG20640@aiede.mtv.corp.google.com>
 <20171201034212.GD3693@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201034212.GD3693@zaya.teonanacatl.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger wrote:
> Jonathan Nieder wrote:

>> nit: it would have been a tiny bit easier to review if the commit
>> message mentioned that this is only changing the indentation from an
>> inconsistent space/tab mixture to tabs and isn't making any other
>> changes.
>
> If only you saw how many times I typed a subject and changed it
> before settling on the terse version...

Heh.  No worries, it was a really small nit.

> How about:
>
>    t/lib-git-svn: cleanup inconsistent tab/space usage
>
> ?

Sure, looks good.

Thanks again,
Jonathan
