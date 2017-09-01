Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 886DC1F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 22:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbdIAWKl (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 18:10:41 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35663 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752400AbdIAWKk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 18:10:40 -0400
Received: by mail-wm0-f42.google.com with SMTP id v2so8641296wmf.0
        for <git@vger.kernel.org>; Fri, 01 Sep 2017 15:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+2DjGw32NL+SZ76i69EPmG+A8BjpLmVDGFxrMA/WD4w=;
        b=pYbWrb0TaxfwUx4aQynesaOt1LcAdWi7c65QtTlnV9Y0IRRxUbUN5zUSshbY/cmAlq
         TkKLNA2mmFMEtcGbbvCFLGGnMKajjnScUo3VSbnq0EYBti6On98jrhmdUfMClysIWJ5L
         wAYB2KQHqGI0TRNYXGVodeLOsVwxIIq7ecCLj2wnp7jdXf3V5B2g/etF5z/zrwXvQ6+Y
         ObHM5J+vesL/g2JywgeVGc+bbJeeEzSO56ik8JGmCG9YErpoRoRH2Ku/QJbRyEg+WAhr
         6RorPLdGX5SyaT1p3q4HKGdYKnAU1tZzdYJ3kVOX4Pe+FHYbGih0CUInV4FhaH7nWTlX
         4zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+2DjGw32NL+SZ76i69EPmG+A8BjpLmVDGFxrMA/WD4w=;
        b=NAAOEgf5oeR2boLSUNIRZuX3214Lmm9y+a+F+wF1T7M4C3HrQ4O0T0YtomSIHxQhGb
         cPtKyX+htPQjmtpxrmKLgZGm4Ultr0Wcss8XfTCUQZezfhFqgT+5cgzJEYHEH21rHVCW
         9X1DREfnITEsk9jzMt0Nm15ae+WUHKlUl0n76s4oLzlTaMHA+K1L4lwAnPBWys6X8uWR
         p35N1y/BA5L46JmH7EfC1Nbpi1nF5YjwuSZ/w1QAXyg07bWlbXumEM6NBcgNgwNqLvpy
         +ZyGdDvzwRGY0N9V5XVqNtf0agt8Lu7DT1YIp7faf2INEDjEwH8hAhJJrEHb0YrC3smf
         2qWg==
X-Gm-Message-State: AHPjjUgQoPehFIu/sYj7wHvrazgm0f9CR0+q+0PJq8fwNLch7f745hNa
        eJL9tkHTwA+MzKSYIUw=
X-Google-Smtp-Source: ADKCNb6rjQRWWbFUOI4VZ1+OYSYh6T6JFoIJZi0dX8LX2L8kIwCDjGfpvclobI3Hn0E6t9e8OhSoDQ==
X-Received: by 10.28.30.129 with SMTP id e123mr1252596wme.35.1504303838858;
        Fri, 01 Sep 2017 15:10:38 -0700 (PDT)
Received: from bucjhrlm12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id l26sm708593wmi.46.2017.09.01.15.10.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Sep 2017 15:10:38 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: git-scm pages deliver outdated Git docs
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170831183734.6sukpdpvi23h3d7v@sigill.intra.peff.net>
Date:   Fri, 1 Sep 2017 23:10:32 +0100
Cc:     Git Users <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <6133C06F-D17F-442C-B68E-18DE4BC470E8@gmail.com>
References: <21957FF0-CABA-4B93-8BD0-42EE28197395@gmail.com> <20170831183734.6sukpdpvi23h3d7v@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 31 Aug 2017, at 19:37, Jeff King <peff@peff.net> wrote:
> 
> On Thu, Aug 31, 2017 at 09:28:35AM +0100, Lars Schneider wrote:
> 
>> looks like the git-scm pages deliver outdated Git docs (v2.13.1):
>> https://git-scm.com/docs/git
>> 
>> Is this intentional? If not, who should be contacted?
> 
> The docs are up-to-date (and a cron job keeps them updated when there
> are new releases). I think the issue is just one of presentation. That
> manpage in particular hasn't been updated since v2.13.1, so that's the
> highest field in the version dropdown. If you switch to:
> 
>  https://git-scm.com/docs/git-status
> 
> for instance, you'll see "v2.14.0 | git-status last updated in 2.14.0".
> It's actually sucked in v2.14.1 (you can tell because that's what's
> mentioned as the latest version on the front page), but there were no
> manpages updated between v2.14.0 and v2.14.1.
> 
> So I think all is working as intended, though there may be room for
> improvement in the text used at the top.
> 

Thanks for the explanation!

- Lars

