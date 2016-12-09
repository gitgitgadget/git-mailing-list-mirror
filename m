Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21AE1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 12:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbcLIMb4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 07:31:56 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33725 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbcLIMbz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 07:31:55 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so3768464wmu.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 04:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=SCZc1q6rBbgJ4nbbcae5KdeAnwgaTWP6ngC//rabsVM=;
        b=Nrs4JqokF62t5paRsQW+HGu6OSLTv0uMwNU6mrLV8PUojS4OLq0H4hWiht0XJFqp6h
         derQ3Dk+5hu08s0fn4uQhicR9Wz/TCVsaYtFrG57ApLja9mITvDAeRYP+LWjb36YeZpE
         j5JIQRkx/c59QQzwXEDU/GiPQHETrarvdW6rGupD33ujyYYh90sjb8U0GZot2sUD6tKe
         kSYveOeeAhyaAhoFUOG71IbopOgPniWaT9a/uGrHwBZbfbiTL754FS1LLzPTO8qlZuS1
         r66Zhk3DQ5alWjjapGxFrEbkrqlXAAm9Cf6/n7cyH35oWA2UZ+7CvZzehtOLh3rlNJl2
         VThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=SCZc1q6rBbgJ4nbbcae5KdeAnwgaTWP6ngC//rabsVM=;
        b=K3n+ur81891ZktxSeFhx7x+2rHZ8ogoJbA5mb9dvni8qDOy4f7ghAoBld6EUDS3uCO
         gl0QzjXLjLhGC7J/6vwMoQz71D2Y9CQY/rm5udcsRCGBwamoWQjNKEQ91I/YWGleIigj
         aWa2cRvRhoYwnW49Pg6NR7UEhWOQCuALQef1x0wJZeh8DbyxCwkU2mzGzgtgcHzBRI/W
         4O2wM1I62RkIvgPFHCIGi0rHLPCpnZAqCWI/+u5Oq3QIyRpCaVlgDsPVHSdJHNlWP9oS
         ufX7CZd0RbMY9yh5/1+dsiwJJjKPYmmKpdgXS3+/gw+B8BGUgpaCeWyeNglYCRNjnhLe
         Hm3w==
X-Gm-Message-State: AKaTC03bk3ZggZfpmqB6ah1f7JHV7bWC4dZfMUjStKg72qFQPcpBYtLAskYtFIxa9B/tdQ==
X-Received: by 10.46.14.9 with SMTP id 9mr29782743ljo.59.1481286713964;
        Fri, 09 Dec 2016 04:31:53 -0800 (PST)
Received: from kristoffer-SZ68R2 (uib-guest.uib.no. [129.177.138.114])
        by smtp.gmail.com with ESMTPSA id u12sm6417437lja.4.2016.12.09.04.31.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 04:31:53 -0800 (PST)
References: <20161104214357.32477-1-kristoffer.haugsbakk@gmail.com> <xmqqd1i356ql.fsf@gitster.mtv.corp.google.com> <20161110230605.pwgzhai6xhud7pnu@sigill.intra.peff.net>
User-agent: mu4e 0.9.17; emacs 24.5.1
From:   Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] doc: fill in omitted word
In-reply-to: <20161110230605.pwgzhai6xhud7pnu@sigill.intra.peff.net>
Date:   Fri, 09 Dec 2016 13:31:52 +0100
Message-ID: <87shpxl1vr.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I agree.  Just writing "... what the plumbing does ..." is clearer and
less redundant.

I'll probably be sending a patch series that includes your proposed fix
sometime soon.

-- 
Kristoffer Haugsbakk
