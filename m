Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDEC61F453
	for <e@80x24.org>; Mon, 21 Jan 2019 08:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfAUI4w (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 03:56:52 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:46366 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbfAUI4w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 03:56:52 -0500
Received: by mail-pf1-f181.google.com with SMTP id c73so9802639pfe.13
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 00:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yH4w1LKzC5PIUSrhyDfXHhvtPIqan9R/5L79L+Mw29M=;
        b=k08hI3ks2le+9wYvxPFuqiHk7l47KV8g2EyvnM6SORFyY5SJxjibzGhCLzUVU7MYws
         DPqV8Gda3G5VIttc1YOgMX5E9/fDreM11gxzs/VoZiznJeiL//PKGwWMWFjpV0SyM132
         9PwABcQzsADeRd5DIg7+uZ4fTC20lN5x5MNpDUpJg6BB3wARNNuk6+ACtG9HKZq20tqg
         MH6hX8NvOAxF4Rsqw6AxzhC55zi30a7yM5uCRH4f205Lzw2mZpmYGErRvUx55AbGZ2a5
         HQIue8VLRGA9nRLkWUCxzOQPpkCUfIQbQ5FRuhLNazayNJe95aEXdFY66U8U9zrISpEg
         KPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yH4w1LKzC5PIUSrhyDfXHhvtPIqan9R/5L79L+Mw29M=;
        b=i0wXCX/Eukh9h1YraLsxpHe0lO/EwMfxAZDoxvsHBn0TUBG9FJj6Z7W4OkWzNCKLcM
         cvPXn6BVmVk0fu1MF6ifxqJRSr0Q8gcBMET+hxQClNacjpZ7zIFvSiUVyBl18IQvBoY+
         8s4BCREmNK19daA1nwxMHM4OVxTmTgB8iq/HOiv2kklgund6ZKlUgwdT8ALV7rU8/0TV
         3ia7YPcheORcBo0HEtok+ynlsJ1eCHzeynKcZS3ix8679FfmZ/CoPgJNYrJKI8+NTeWk
         Hc8gpzUa3IozEaaf/hcIipVB6KS12m2U9A4faN8YrldeM31EgN9r318rb7WlL1ErLx5N
         rNRw==
X-Gm-Message-State: AJcUukco3ocKebrciFZ2uQGaStcecr89bYQvgX7P31CrrnGGrzgR8Med
        XfyN19dfjv3q/Er1XpvDci1cqkBMeTA=
X-Google-Smtp-Source: ALg8bN7ko7qSd/DpRLN1ZfZO8VEWHd4CJvoCXq6qFbvsYJB9YiKS2qleHCPu8Y8mdW8F/JO2Hxx2Mw==
X-Received: by 2002:a65:500c:: with SMTP id f12mr25433351pgo.226.1548020148543;
        Sun, 20 Jan 2019 13:35:48 -0800 (PST)
Received: from lglitch-pc ([27.62.81.101])
        by smtp.googlemail.com with ESMTPSA id m85sm16582126pfj.171.2019.01.20.13.35.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 13:35:47 -0800 (PST)
Message-ID: <eed52a8c6592c6893134e29905fb960b25cd7b10.camel@gmail.com>
Subject: Re: protocol v2: More data transmitted between client and server
 since v2.20.0
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
Date:   Mon, 21 Jan 2019 03:05:43 +0530
In-Reply-To: <d8ef0c1e5f48952c6190672bc26244a02b8e9bcd.camel@gmail.com>
References: <d8ef0c1e5f48952c6190672bc26244a02b8e9bcd.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oops. Small correction in the message.


On Mon, 2019-01-21 at 03:00 +0530, Kaartic Sivaraam wrote:
> .. The commands given there worked as mentioned in the blog
> until Git v2.18.1. But when I run the same commands using Git v2.19.2

That's Git v2.20.0 not Git v2.19.2.


> or the one I built from source in the 'next' branch (at aa96b0ce6b).
> I'm not sure why this is the case. Some observations below:
> 


That's it. Sorry for the confusion :-(

--
Sivaraam

