Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE21D1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 19:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfHLTQO (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 15:16:14 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:35104 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfHLTQN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 15:16:13 -0400
Received: by mail-qk1-f177.google.com with SMTP id r21so77872790qke.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 12:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bg6GHKkmc4wsomm1VhIvxQ3nrx15uheZSq5E3FpbWs8=;
        b=WU7xZCZpDHrtAib3RWudG/zeYgytzVNnUCs2QdHI2PoUlyoUjqX+1I0amQOyUudQiY
         ckNwsj1ELkE8+hnPDdEox5H+mhWjW60mhT+18KCp8M31jse2cu9wiyu+iKFblJNRnq05
         f9dVdZzAEhsLaTfHS2XLvdYnf2cchy19iiaqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Bg6GHKkmc4wsomm1VhIvxQ3nrx15uheZSq5E3FpbWs8=;
        b=a1DKyZNnniFgfctU46vjq/ImHHcOM4FK5/1R0pG7Fm+Sp3RN6q8O8w4SyOhlZXGp87
         yYGAJVhqYDX2/bYnoLv1Oq69KgDs2lw6mvw3hwMSQE24UP0Egms8DjPirKnhdicVpxBF
         npKB69ER5HG6wAqbPQMSVKZMcmq1p/238Pi5tu6u63ujrLoyrHoGkZ3RcW8HxMWYTEch
         bGsub/AT61ZTrwiqCtSOQwAiZ+Dxk789NegXds+x7wZhG4B36rZtSHez6oiVd8Xr/1sd
         QQhF2bO72BgUXgtTsV2N5526ToKs+TaB4bRR3UvKZjeHZe/d7+6O4w4hGpIpwf8FZD7t
         wXGw==
X-Gm-Message-State: APjAAAUV17RNU+Skz91pQ0j7avEke/Ec7rqpjCVeRXF2NKKt8h08oFqB
        o4MnkK2/cBcNvD8FV32tJoSfCQ==
X-Google-Smtp-Source: APXvYqzO5PMoh5lrLdveIToIlLYfs2uYP81qwVjPpz8xgRz+DTWVA7SQHGW4FlE9t+kfJ9E/IdHP/A==
X-Received: by 2002:a37:bd7:: with SMTP id 206mr31328808qkl.440.1565637372431;
        Mon, 12 Aug 2019 12:16:12 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id z2sm10130710qtq.7.2019.08.12.12.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2019 12:16:11 -0700 (PDT)
Date:   Mon, 12 Aug 2019 15:16:10 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     koocr@mailc.net
Cc:     git@vger.kernel.org
Subject: Re: How to get gitweb setup with nginx + uwsgi?
Message-ID: <20190812191610.GA24499@chatter.i7.local>
Mail-Followup-To: koocr@mailc.net, git@vger.kernel.org
References: <88cc039d-2bf8-4c1d-90c4-486ff661c1e9@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <88cc039d-2bf8-4c1d-90c4-486ff661c1e9@www.fastmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 12, 2019 at 08:09:22AM -0700, koocr@mailc.net wrote:
>Hi all.
>
>I'm setting up a local Git server, with Gitweb + Gitolite.

We have it working in a similar configuration, but with CGit instead of 
GitWeb. Unless you have specific requirements to run GitWeb, I recommend 
you use CGit for your web frontend, as it offers many features GitWeb 
doesn't, such as caching -- plus it works really well with uwsgi 
(git.kernel.org runs in that configuration).

Best,
-K

