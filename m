Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C7E1FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 19:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757967AbdJKT1S (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 15:27:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37127 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757163AbdJKT1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 15:27:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id r68so2788631wmr.4
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 12:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uvpWExyf+14fZOSmG9XzXzAIARVfoPia4rQkT97ibV4=;
        b=GZt1eqy/bj0N9N7PSkXM5tGugGRqXuvSNG+7Eq+PfBMvB82qbIlBSLyv6ozq5VxQbE
         291B9tnN+r5EFlKbg6EvDsEj0gXr/S9wFER3v6OoVBSTSPrHOk5Zt0cKYSTyE+Uhu/tC
         BYzqHwbihvnOxzZNTssE6MYbWqA9bcbpb9K1nqbyCt0PB5QoTStuyfpUs/NEoUBwU3wE
         BRgxW2OFD/f+o7M3uUqYY0FxwgEBb3nUAyds2ou7PCui1rmKS7YhpFeQwyuiw3CID1hy
         gS5rppQXvVCWtW2NLucxsVl+VJkEhSQ9t4sFz/H4MCOeA4augvJekmp24au73xgqlY8t
         rAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uvpWExyf+14fZOSmG9XzXzAIARVfoPia4rQkT97ibV4=;
        b=tLVtAChCOM2rL1Uu7KMVQY6PSt9BdzzfeF8wI4qLUxcT+HQhuh9kx8tIocgKp79VhO
         ha2YuzVkVQKHCvHdYxOOVHqqnMl/KCBmDH5B3acyOSNnAB7h/zhtKSYRBqGkF1C3N84Y
         jciGyeJ7it83Fl1xlL/rhRsj2isrdM4pn7gRR3Dmb7h+dNLPCjbELvkNab32zBBtxf6H
         PXj7NYIon/hs0kv1qpw9/Ix3EzjDqCTYBKfKzTBf3tiKQbwzcuXRcTv+1VX4lInuvg5k
         dWgZh7UwE6hzION6nz3Np8woAS2ngxC7pOlk4RQVSljgMPvk6TRoLmDSPUoUYyDcEyeU
         geuQ==
X-Gm-Message-State: AMCzsaUl1xy02RcJksLL8PtA9Z/muiHwyi5DHhnQ2Inn+Iha2Czc20Xv
        V1GTDZNfrNTmHZAO4Z2jrAxLgwYE
X-Google-Smtp-Source: AOwi7QA6QO21pCs8w2DbLU7kwwSEJdlG9h5wArhD6iQeWAnFxGei0CzDyhC2IsVt871LpQpHFVsXkQ==
X-Received: by 10.223.145.105 with SMTP id j96mr40534wrj.273.1507750035576;
        Wed, 11 Oct 2017 12:27:15 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id v10sm12330611wrb.92.2017.10.11.12.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Oct 2017 12:27:14 -0700 (PDT)
Date:   Wed, 11 Oct 2017 20:28:09 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     =?utf-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: how can I conform if I succeed in sending patch to mailing
 list
Message-ID: <20171011192809.GD15399@hank>
References: <CAC2JkrLfcUzipRPhUHiVEMipsPVcia6ku+QK7OwMJrME-JtAzQ@mail.gmail.com>
 <CAC2JkrJV7XdRyLiu3fTLZmLSJzU3GX_2rr6sQcUx-w0-BZ7f1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC2JkrJV7XdRyLiu3fTLZmLSJzU3GX_2rr6sQcUx-w0-BZ7f1g@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12, 小川恭史 wrote:
> Hello, I found a mistake in documents, fixed it, and send patch to mailing list.
> 
> Sending patches by 'git send-email' with Gmail smtp seemed to be
> successful because CC included my email address and I received it.
> However, I never received email from mailing list. Of course I'm
> subscribing mailing list.
> 
> How can I conform if I succeed in sending patch to mailing list?

I think that's just a feature of the mailing list, where it doesn't
send you an email in which you are already Cc'd in, or something like
that.  I received your mails through the mailing list.

You can check if they arrived on the list at the public archives of
the mailing list (https://public-inbox.org/git/).

> Takahito Ogawa
