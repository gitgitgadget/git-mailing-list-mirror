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
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A9C20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 21:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbeLGVkR (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 16:40:17 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:33859 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLGVkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 16:40:16 -0500
Received: by mail-pl1-f181.google.com with SMTP id w4so2402036plz.1
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 13:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=468Kd/QwMLYL1z2MLQgzrGI/znh5ETST0cnBIALbAbI=;
        b=UwJ3psDQcgphi2+/EiY5V0xhm5Ap8E4crVWe4i6TUHl99h0XNEYhlk1ybvBdDo7mzg
         79Aalbl1WPdoWJ7teFeVCtsYdsNgRMFGDJG/H7Ei6WRIaXtMcyxF9teJdgq9iT14ybtZ
         T+MNOAMsFKkUibkLvXj76aE6woA1dXuJpwEbaVLe+D8kmtDxjh6GBng43v578xrOwSqQ
         L17cbE7oKuwMikVZS4wnTR2G3oee8UTdHi04K5w7wTRWnhOdEbWknDWzM7OH5aEe0RwQ
         H3r3uhcKYhd5/P9Ju4bJcm/vN9PigC1XvSgVeCDAxrn6gmxgWIyvUrxRoLJtBMxjUwuq
         Ez/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=468Kd/QwMLYL1z2MLQgzrGI/znh5ETST0cnBIALbAbI=;
        b=WXm1KX/5bKBAEyqiRk6YV4x5Tfw7zKrHfNBtAvTPRqJZ/rZg3R7/lt6blc7yynmFcA
         7DJKv2xUkvHGrTsoAmEDHoQuLrBJEE5tuuADot28OhGlIyww7zNvAj6EMKsNUzfholP7
         P2URriYgaPQ+sNVOSDQNhzCUK3AWztrSRxjAx9GLd/xNvMQWJsLAZfWT+0DJsZsDHvV7
         A7mGbwRuo0HooaGTvkOa/EV0+eooUacRgfJFGur1bitPeGWqdMhtV1hCaMrF6194Wlou
         hKk47EIinwAbCUqrKKXtZSI+kLpP4loTcJo3QXJhJgwarCjQAOJ36lKiK84TjNycofbj
         c5ZQ==
X-Gm-Message-State: AA+aEWZUMXvX9WUYnC7QEvvA9Ccvo96vJznDluKd4TV1XW1ttUvqUEfI
        Jaozq+1U++V2dxH/KQ7GQLA=
X-Google-Smtp-Source: AFSGD/VoKum3mb+XKtm+M0+2PailKbzskyieo+P8qU6jmPYvGQTxH51UfW/OvAu4TaUYqWFiSqz4Ng==
X-Received: by 2002:a17:902:a411:: with SMTP id p17mr3650198plq.292.1544218815773;
        Fri, 07 Dec 2018 13:40:15 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id t87sm12750559pfk.122.2018.12.07.13.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 13:40:15 -0800 (PST)
Date:   Fri, 7 Dec 2018 13:40:13 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bwilliamseng@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [PATCH] mailmap: update brandon williams's email address
Message-ID: <20181207214013.GA73340@google.com>
References: <20181207205621.49961-1-bwilliams.eng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207205621.49961-1-bwilliams.eng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Signed-off-by: Brandon Williams <bwilliams.eng@gmail.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)

I can confirm that this is indeed the same person.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Welcome back!
