Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44A4420401
	for <e@80x24.org>; Tue, 13 Jun 2017 01:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbdFMBHw (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 21:07:52 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35606 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbdFMBHv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 21:07:51 -0400
Received: by mail-pg0-f48.google.com with SMTP id k71so52375393pgd.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 18:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MnSAe+LkVLHj14LedkMPdj17A/v1ea0bzKp7w6lV0Js=;
        b=KqgrQjPk0/+RQxKJcZqGpsOSE8qVkDRrPafBKE9xL3N8FUTYcKfVMHwtnNh7mgWlev
         rb3Y/6Oy2rut/o42hZqaRQQRYbEu9SlHWST6rASDInynLh9PrHapKgGTWJTjXBy4VjhQ
         wuqYKQmkKxtLuYV6tTUxRp4nzOpPObOaFYueI9mCKs0+41RoO/zyHye3QIZJwxA7Gisd
         1njw+F6ZK7HTcBPILAVURPe6xW/gjbYmV8gl+frSpcIhM93x1lgpkUbCjsh5+YLq4CXV
         8eCEulSXdxOJEnzjzhaBXX4ZT0V7aFAXDvX8h6YXf3VSPasnxoDPEN0yN8TGSpHArD5z
         lYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MnSAe+LkVLHj14LedkMPdj17A/v1ea0bzKp7w6lV0Js=;
        b=JrYy/xzwzOlZD/GU5uB8FjLfWBaYTiPe9JpKCuHEnL7Yv8zNEDxfo4UamqHDrHFVnz
         nNCg5VPtcMGtUvn9XM1z+enZumy0oNKzWOcu8yDQF8HZ8+mEcotSPfZoAN4EWLiIEAaq
         3WNwcAi9XtIMsX8fBgZ7vH0XxCXhczItZDkezFdGbuqN/UKB0FjKAoKFccCjNs+Cm1LT
         gOBollIj4jPAWARFLD3cJyQQZO45PCldl3TwZQvBgFytfNSg6m5QMj6X+oIWEEpH8D/e
         gqcyUQO3dHz7/9WaiMNBQIonO+8yE7Uig+cojmVvXzsiiynG5aRBVSKIF6SU4Zu0NVax
         t4cg==
X-Gm-Message-State: AODbwcDzeH48irEak7WqjSxhgH0YKd/fVVhBMnqf+GBaM5HhskEf4uUk
        PmK6uQ3NU3GplRTZviQ=
X-Received: by 10.84.233.201 with SMTP id m9mr59246550pln.291.1497316070587;
        Mon, 12 Jun 2017 18:07:50 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:e453:89d5:deb:c7b6])
        by smtp.gmail.com with ESMTPSA id s88sm82364pfk.16.2017.06.12.18.07.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 18:07:49 -0700 (PDT)
Date:   Mon, 12 Jun 2017 18:07:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 0/4] config.h
Message-ID: <20170613010747.GC133952@aiede.mtv.corp.google.com>
References: <20170612213406.83247-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170612213406.83247-1-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:

> Brandon Williams (4):
>   config: create config.h
>   config: remove git_config_iter
>   config: don't include config.h by default
>   config: don't implicitly use gitdir

Patches 1-3 are

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I'm very happy to see cache.h getting shorter and less intimidating.

I have some minor concerns with patch 4 that I described in a reply to
that patch.  I'd expect that after another round that one will be
ready.

Thanks for a pleasant read.

Sincerely,
Jonathan
