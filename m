Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7911F463
	for <e@80x24.org>; Wed, 18 Sep 2019 10:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfIRKaO (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 06:30:14 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:33452 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfIRKaO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 06:30:14 -0400
Received: by mail-pf1-f171.google.com with SMTP id q10so4141025pfl.0
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 03:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sYBNUeh2rBWxEpIyB2CyUo/iag4wHahaRvymjJBR9es=;
        b=Ii9zngTAxdwHj+dBtzP9pg8LH+BsnVZr2xl745B7bAG3FQXSr7ZaMWBQ/mu8C+XDlz
         nktlyuuuWe9aCJriV51fZ+kcI/7ohfvVAKhWsBhf2gAV8sHSuKez4TmQURsx7KRR1SZd
         BJ3Ka8r799fw0XVIzze+lN9L2PhTiWsoL5dow2UU8pzgbD2VOc6dNtlUr+5grCkew9cX
         /OCSZKX3spfZF276JJ8zCqVrHMmYjSwuDsF9T7IbMy+XNZl4zg8+9VenWTvhgbAcKQ6u
         JAeyLwIMIuE+1nmIZRb+qKi6Qc5GeF5UryFn4ePLtIkg5ItD89XRDnFzfpmYz5e1W/zZ
         SIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sYBNUeh2rBWxEpIyB2CyUo/iag4wHahaRvymjJBR9es=;
        b=Fe5M2PQaeFogA9DEql7hpUtuzaXQ2N17gYtUdjwX42rxw4R+H5rv/IiIRp9mo7C0NM
         GL5JpS3z76TtQyerIbP/2nvjHVuBijrnRKwgTa/h7wC3PDBbpiJ5TIHCR3/lBi+JFxFP
         WAMJHzZaLWIcVSWPTZuO5hwhQAepMdwmFDHhzIZEG0cjIty9CKqVGzFVnpo3zv2yTvyf
         i6Qh/enLmBndPLnLIuGyNtOejizjsRAEBNmIzGM7jj2JZoSHNZ/GBJ9YUOg3yqLmgYIn
         2HJuujWoPqXu6mAuvyDFigeHp1Y4c5ojFJQBgJohZ3lmUtabEs3sWAMCW2GsHwAm9yxH
         rT3g==
X-Gm-Message-State: APjAAAVPVlbSEPm+RPoxpz7Ne+jmkAaxQT1kOGUU28yefBMWytLRZNLP
        iQSGzsINXrQXQNbY0NSnIEvnjI4DJEI=
X-Google-Smtp-Source: APXvYqw8GigndFxhaHW3hqY9bEHRIekkJ6n64gaG6MnjG4zTUNuLn7SXqDa/LrZF8aWc2gPwwwjZ/w==
X-Received: by 2002:a63:2026:: with SMTP id g38mr3212699pgg.172.1568802612983;
        Wed, 18 Sep 2019 03:30:12 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id d14sm1812176pjx.8.2019.09.18.03.30.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 03:30:11 -0700 (PDT)
Date:   Wed, 18 Sep 2019 03:30:09 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Subject: [OFF-TOPIC] How to contribute to Git full-time?
Message-ID: <20190918103009.GA113977@archbookpro.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Sorry if this isn't the right place for this but I think that this is
probably the best place to get in touch with fellow Git developers ;)]

Hello all,

It's hard to believe it but I'm going to be graduating university soon.
Since I work on Git in my spare time for fun, I'd love it if I could do
this work full-time.

I just wanted to seek a little bit of career advice from the people on
the list that are sponsored by their employers to work on Git. What were
some career decisions that led you here?

Thanks for letting me bother you,

Denton
