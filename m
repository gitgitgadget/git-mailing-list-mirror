Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ED821F453
	for <e@80x24.org>; Wed, 19 Sep 2018 17:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbeISXAl (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 19:00:41 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:52112 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeISXAl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 19:00:41 -0400
Received: by mail-it0-f52.google.com with SMTP id e14-v6so9390750itf.1
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 10:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cH3EOGsHl0PXoPRImINKJvPy0Z4yzrgFfpBZOA/vioc=;
        b=EdLacutFl/l7fB0FGteQuzmwv6GHTniZsSksxtN7WK5b4VVpBVtd/Wqyrh9KB1Nx/p
         iGEWemdAgNxF8BuQ4J4Uiek8RQ80+DLcQ5PG/T2QjWkb6R650uvrv5cCrtsZt76hcd1+
         f+g7GPU+EoNXPRt5Msjom+GOIm8BTj7i28k/1p5unVuy3YYip4XzTE6QlfaXuJy2AGwK
         AFQnSKPeLGsNKt5gaU+EzT2K1vcIlVHijgGf/1jZtaR+iU8eQ8eHnImwKUJsElReBq/Q
         gVBzCgKJEL8w4WWDPHcCBst/5D3Jb9SnIspBzBBguC0tjruH1fHbJcumNv+WpDgKVKy5
         1TSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cH3EOGsHl0PXoPRImINKJvPy0Z4yzrgFfpBZOA/vioc=;
        b=HUpdcBPMJS7W7sxNdu2EzirxDotv7VS7R6taxH7Lxlc0tBZsqiL36jWfzh4IGbpYAp
         JP6NjF2z5tyK1zxKQkE/G8Fb1iFclxwOJ0ckzhzkHKvI0IzJiFtZcIwdvoY4cydgSyMu
         1ZFLPcU29T8pIKfI4/a+Z59CZ+yROfG1C+aGwL1ODtLG8brDiNnAUzEuA1+zvAhiKH0J
         SwSqkDRvwuHjNgO9N/zWGhwyx+QA1EnAdDXFcOI8VlKionMe1tHcIZrt4klm/MRRtO6t
         b/sCwyTH6/m2O0Yc47UGjrPf6VOYdg+D8WCmZ8XmJTdoUqt37RCGRk3gng/4+Cb9oEGl
         O6sw==
X-Gm-Message-State: APzg51CDcFYH5HcIcDxX4KdmbxbSExCjOPfP63w9OjyL5f+FixU74Hnu
        42g2jMYpE1V8vzLjyMyahVsnOQ==
X-Google-Smtp-Source: ANB0VdYmDn3DRDY3fAwd1RcLcXHBZ/7Exh06m348vBLjEQ+ur1IcrPGFOUHaEDEqSGPDbkRjlEryYw==
X-Received: by 2002:a02:1857:: with SMTP id k84-v6mr33152838jad.104.1537377705699;
        Wed, 19 Sep 2018 10:21:45 -0700 (PDT)
Received: from localhost ([173.225.52.218])
        by smtp.gmail.com with ESMTPSA id b85-v6sm6323700itd.37.2018.09.19.10.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 10:21:44 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 19 Sep 2018 13:21:43 -0400
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/2] git-config.txt: fix 'see: above' note
Message-ID: <20180919172143.GA60492@syl>
References: <e81bbd0e714221aac47b387e7d1e1572af32aa8f.1537375024.git.martin.agren@gmail.com>
 <377b7cfa36c3b23150005f7faec02bbc4a325bd7.1537375024.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <377b7cfa36c3b23150005f7faec02bbc4a325bd7.1537375024.git.martin.agren@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

On Wed, Sep 19, 2018 at 06:38:19PM +0200, Martin Ågren wrote:
> Rather than saying "(see: above)", drop the colon. Also drop the comma
> before this note.
>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>

Thanks for both of these. I should have at least taken care of 1/2
myself, but I am appreciative of you doing it, too :-).

I could take or leave 2/2, since I usually write ", (see: above)", but
I'm not sure if that's grammatically correct or not.

But, either approach is fine with me, so both of these have my:

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
