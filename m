Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 829051F597
	for <e@80x24.org>; Tue, 24 Jul 2018 22:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388719AbeGXX2P (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 19:28:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37309 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388632AbeGXX2P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 19:28:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so3843292pgq.4
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 15:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eLDFVQQYJdvRfKXXg7NdaiyanISjjN/kSFc/xVHPFVc=;
        b=bbEUOVrFbCWnnXiwdl3Q6CRaVS7MkWmhdhU6myMhhKzv8X7JoQRI9PALpxJwkO5F6x
         oV3sWT2yu4OB65xxFbhsE0L9BdMabC+j2aF6VbVKnVhBuQ+kQyZdiQQSUdLABdC2DbRw
         a3jhHvhDRBtrhgH0u3dhYldw5nlES1bJzBL6vbT5plEGRVRyFNwxVUtBWMfUs4egFTqU
         3LHcF7DmTBh7zpqiWn65QIrSVMNIL63lAbEHJqnVptyidSSwCwS4g6Ol4kLGfG1xm0D0
         V6nmH9153p9EwTtNZyGWjE8W5R1vamBHpJldY+Qv8hp6wPL+miETDjShdLYTdwa0roQs
         5c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eLDFVQQYJdvRfKXXg7NdaiyanISjjN/kSFc/xVHPFVc=;
        b=QTKkMHAWmUAk4dAI/AA3joUoa0tGQyFSCDlELnma3hFOHO01ebe/Rgtl5txDgA31vC
         vOrRVdcm15y+0DklpYSMmPkSth1BgYXKWFfcebaTO0yuOvqN+MpaCnLWIk7j/TYwhUnn
         6o+GIJyiA8uRU6R6Bbw9BZQJ00NvXOEenaX06frJpZIFXOezizkPlU1AkxiuPo/G+hoY
         iN1R8Yt0OE9IYIx8T99pjeKRvzJem+8D7+1N6C/ywTx70mh6Hebt4xhthl6qJF1z1CTm
         +ZqwjtEz4bDe6Va0JzmJBrGRL4iGrVcdkqeX5iHnjrZhzU9WYyWgtxjzb6oRqnTcKDBP
         UO8g==
X-Gm-Message-State: AOUpUlFslBrep/UZK3DBA0ak3z5uB9FE6ksDpvKhmbR+eA5Tver0KO1l
        FpHud7jpumxWRma+uHbShFs=
X-Google-Smtp-Source: AAOMgpeiIouQ91RSQDR3HRaHDqtz7Y346j7gqhMyMm9JvclssrTO6dG/CCdRyizQZ/3AD8tl7bnhtg==
X-Received: by 2002:aa7:8591:: with SMTP id w17-v6mr19504138pfn.77.1532470780412;
        Tue, 24 Jul 2018 15:19:40 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k12-v6sm20202276pfj.30.2018.07.24.15.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 15:19:39 -0700 (PDT)
Date:   Tue, 24 Jul 2018 15:19:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] pack-protocol: mention and point to docs for protocol v2
Message-ID: <20180724221938.GF136514@aiede.svl.corp.google.com>
References: <20180723174807.28903-1-bmwill@google.com>
 <20180724045233.GB208393@aiede.svl.corp.google.com>
 <20180724181913.GA225275@google.com>
 <xmqq8t60xv7l.fsf@gitster-ct.c.googlers.com>
 <20180724204733.GE225275@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724204733.GE225275@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> If so I suggest we move away from the term "pack" protocol.  Mostly
> because maybe at some future date we don't only want to communicate to
> transfer packs.  So at the risk of bikeshedding (and because naming is
> hard) I think we should begin talking about the over the wire protocol
> as just that, the "wire protocol" or if we need to be more explicit the
> "git wire protocol". Thoughts?

Sounds fine to me.

<bikeshed>You can call it Documentation/technical/git-protocol.txt,
since from the context it's clear that this is going over the
wire.</bikeshed>

The main point of what Junio said is that it means the docs should
treat "git upload-archive" instead same way as "git upload-pack" and
"git receive-pack", instead of artifically separating the archive
file-oriented and the pack-oriented parts of the protocol.

Thanks,
Jonathan
