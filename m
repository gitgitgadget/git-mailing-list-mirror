Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6890320248
	for <e@80x24.org>; Tue, 26 Feb 2019 07:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfBZHEN (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 02:04:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40210 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfBZHEM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 02:04:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id bj4so5756283plb.7
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 23:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5UXxsbLJ+d/3XhQ3aEOZqsLCBiiQX3b+9jSGbc8U6RM=;
        b=TZoBJqRHk6ueB9H9zMaIFh5FrrkinwscYcCmUQL4XaE7o0UM1g2SZwg9xF7SK6tMzt
         nlNUjGmRc83OnjoCp/kR5EWba38zun1q+0iLvBjjsNGBBfwqHQEHK9XJ5E+dvBoXd5kq
         7iIKduShs2XF+l9Wr8Jg276S/K4Hl67x2fOVfQL4zc8kXcY4z+U0PlMu1dQJa9dTC5F0
         DYIGNq6NoeH3laUcJx/m5pogo8O11I3wv07qDxmM+kcOzgP20T0l+hqVPHXFD1Rhjaqc
         D8MMBMT9pzC8PlgPeDpVthG4lDoMdlMBRCzIL8hXaLvldRHZTwlITr0Uq9EcJI7kzdps
         I+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5UXxsbLJ+d/3XhQ3aEOZqsLCBiiQX3b+9jSGbc8U6RM=;
        b=GlyT/QLnMNqwRitzIbiKxksRXFG33b4h9NWxEBOVknASIMtdLmjeecaBnjHBuZvmaL
         hEvAlZx3O55gKk/qUVF38EW2e9yDbvw5HYUuB0EtORaznoRm5c9L/EcqMBYntV8wbolA
         SM3wCzpyBpjL5r4NnbUrwwlNF0h9slBkhcOaTfz/5fLM96/D2gH0D9KHboyyxlqupAl+
         NgfYP6vq00RW+WVhr9Frsi5AL6DJLOiQSFP8Fq1yRm/So54MqgULRFBvopyuP1CZFA+Z
         gIN9pMZWya4xmcaqrexTJMvzv/SYnfy7l69ievImOp5w3Wlwl4fqu4pq0Kzy3sxHTpLb
         cMLQ==
X-Gm-Message-State: AHQUAuaKBCOsomB2tGV34IcaXRFoYR/tj7+Hy8FF90q/Bwy5v9P66Mlx
        Hf0u/rpwrgoZ6JTOtAyOsFY=
X-Google-Smtp-Source: AHgI3Ibk4orPhPLfsD7KlHtb97+CqIlYPntRTg47iSAg7xT9HKG41H0ldYMrTEqkY4qAYx+3+DqmMw==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr25217588plo.265.1551164651889;
        Mon, 25 Feb 2019 23:04:11 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id u14sm8794391pfm.66.2019.02.25.23.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 23:04:10 -0800 (PST)
Date:   Mon, 25 Feb 2019 23:04:08 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [FIXUP] Fixup on tip of jt/http-auth-proto-v2-fix
Message-ID: <20190226070408.GA117495@google.com>
References: <20190225220841.GA3248@sigill.intra.peff.net>
 <20190225234901.65277-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225234901.65277-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> Thanks, Peff, for noticing this. It's because the client sometimes sends
> "0000" as a single request (that is, it flushes, and then before it
> sends any data, it flushes again). And post_rpc() assumes that it can
> always read something - which is usually correct, but not in this case;
> we read in stateless_connect() first, and if we read "0000", we need to
> tell post_rpc() to not read at all.
>
> This is a fixup on the tip of jt/http-auth-proto-v2-fix that fixes that.
>
> As for why the client sends a lone "0000", I'm not sure, but that's
> outside the scope of this patch set, I think.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  remote-curl.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)

Tested-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for fixing it.

Is there a particular patch this should be squashed into, or does it
stand alone?  It the latter, mind writing a commit message for it?

Thanks,
Jonathan
