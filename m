Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC58C20248
	for <e@80x24.org>; Sun, 31 Mar 2019 23:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbfCaXJw (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 19:09:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38438 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbfCaXJv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 19:09:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id q14so6551628edr.5
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 16:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LjsMfVl38pbAbuDh951TlGwnbnwiHpJLU5BH9cXibLE=;
        b=ZbbEUh+HcL/4UtQI6QCmBToRtEQTPy8eMelHOMEN7dJ6+CUY7CwqS9vuyNl6Z17gmD
         JRK35hWywz0NhyvMBuA/DcFWc3y1j+mtfprYFm6TMHdr1F0TjPO5W2SKAsLwinPcHOla
         m1hB1bneE4ANRVoFqz95BgdIQsnajCzn6TxJRJOMpPK3ODA3m1OQ55RIa8SysmJg8xJm
         RLvrAKRdpE5+8arsyU5EGiMkmXdYc3ynLvUizwFNGK3J1BF/MnbQyIZFZlDfttaT/A9S
         RV8gF0xh1W0B8d60qsKovpr+s0JBhy35Ut2sjTWtBBccIv8kGnFiDjF5isZPNdvNzKNo
         SVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LjsMfVl38pbAbuDh951TlGwnbnwiHpJLU5BH9cXibLE=;
        b=GhsB9NeXcCvNdunhoc2Kv7DJ+5cAn+80ZY4VTl66wU6FpHm7ygNPp1oqVE0/qOU9C6
         l1K12DelfuaFKuNazbv8PYefFdWuerdJjDrQ0eKzV15CkY+wjach1Q8NumldXIITKwYG
         k2FTtZoXFuh8VUSo58IOurqg1oJ9QqHMSUx4xcneVQm5Bxu5TlL6mniZAcGvbvS3IrWy
         KWPeKN1n1w502ECQa9pLVrtgiHh/oISKlCIiGdqFNoyBQkIdfk1jaKsSFU1waQpBMb0m
         oYDTCqDd1T7BDdDDz6VR92fsRE/Hr2wZpAR/b6I7ND7rKpD0m2a+XfiMBDdfB8PogazF
         5vsQ==
X-Gm-Message-State: APjAAAVB1Uv2TrZBSacujy84oyoMbGR9Dq9RvbqF6v/zFQDi5TK0mq0U
        4JKjAPh1DMWL6KggFnLbsmk=
X-Google-Smtp-Source: APXvYqzugGroIpB8nj/4LIOgHCBJOAmXIPDMNOyUHmkgVU+nAIJPNlpM4Lq303x/oMj8y7kc2AqHIg==
X-Received: by 2002:a17:906:c7c2:: with SMTP id dc2mr32954061ejb.182.1554073789981;
        Sun, 31 Mar 2019 16:09:49 -0700 (PDT)
Received: from szeder.dev (x4d0c00e5.dyn.telefonica.de. [77.12.0.229])
        by smtp.gmail.com with ESMTPSA id m20sm599797ejz.72.2019.03.31.16.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 16:09:49 -0700 (PDT)
Date:   Mon, 1 Apr 2019 01:09:47 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: support Unicode scissors
Message-ID: <20190331230947.GI32732@szeder.dev>
References: <20190331220104.31628-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190331220104.31628-1-rybak.a.v@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 01, 2019 at 12:01:04AM +0200, Andrei Rybak wrote:
> diff --git a/mailinfo.c b/mailinfo.c
> index b395adbdf2..4ef6cdee85 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -701,6 +701,13 @@ static int is_scissors_line(const char *line)
>  			c++;
>  			continue;
>  		}
> +		if (!memcmp(c, "✂", 3)) {

This character is tiny.  Please add a comment that it's supposed to be
a Unicode scissors character.

Should we worry about this memcmp() potentially reading past the end
of the string when 'c' points to the last character?

> +			in_perforation = 1;
> +			perforation += 3;
> +			scissors += 3;
> +			c++;

Here you should jump past the three byte long Unicode character, so
this should be c += 2.

> +			continue;
> +		}
>  		in_perforation = 0;
>  	}
>  
