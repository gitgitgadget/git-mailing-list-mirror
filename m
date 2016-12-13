Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91ACF2042F
	for <e@80x24.org>; Tue, 13 Dec 2016 13:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbcLMNGD (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 08:06:03 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:34341 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbcLMNGC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 08:06:02 -0500
Received: by mail-wj0-f196.google.com with SMTP id xy5so16347637wjc.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 05:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=kavUNMj6sK7JWqlFFDTH9eRFBqlxVRK1RlSWxgv6pBc=;
        b=KkYFrjgS6xb98kzenQZzz9d5NxGoruZECcZISO7aGKV2kPTLb6EsYre1HqdqfCInQl
         +uREiXkIum+cXaBMaZBrXpqHe801BaT4asvtKVEepUunX0lfd0ThIeB0jUi+8XP3K66A
         yhm7MHU8/2MEWjnMO603y1mqcFZPWU1Q3/+Pv2CpvC2b1d3mNLAYqTeRnMJ4osvxsZ+Y
         h4I6G8D1wcB+3SPnl5R/8WUvvJOrOy71Lg88lEgfNLWzYb1Lc3cXpSzVJzFvfcr+VQBh
         /YS62mFN0SBF02dDa39RljnwUT/CfXt8S1DCD7Fp/GIqcCh982U2wLcHheCrUxxhmElI
         SP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=kavUNMj6sK7JWqlFFDTH9eRFBqlxVRK1RlSWxgv6pBc=;
        b=TTaoEuybnG2O2YrqHyJCICLdKxLe/edwWBO7xhVInF3XKoJkz2Rm07l7RDwaJnsX0g
         lvvzIh+R/M4qvqNwLUDKCply1ujxFrhmaD+S0mOTS3o8jDfnjnP/zsHAgZdafHuAXGWv
         QljymC3626VW6/SH0xPIsxlxzbCjWhAXAPbYB7EYtU01Y90AlSYRg+aEqRHA9rUn/6B5
         OLgSpQCdu2j/Efoz5qrrvtfF8mdBwZTW9AU3OvDEV7w9+xlTa5fHEd9GzGNEHlZzsx1l
         kjlQfCUmXZkBZVBNkbGkNDF936ez5nuALa8JWpVx/nnVKgwdF5rRTa543w3NKD2bEHu3
         w9pg==
X-Gm-Message-State: AKaTC01Hn2+l9CZVA/Xac5Ey/bEzQa/1wL4IxAGn0iZeqEiPTNt/qpHrGtREtuTW1/mRdg==
X-Received: by 10.46.76.26 with SMTP id z26mr42280941lja.9.1481634360155;
        Tue, 13 Dec 2016 05:06:00 -0800 (PST)
Received: from kristoffer-SZ68R2 (uib-guest.uib.no. [129.177.138.114])
        by smtp.gmail.com with ESMTPSA id m129sm9884139lfe.6.2016.12.13.05.05.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 05:05:59 -0800 (PST)
References: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com> <20161209155112.2112-2-kristoffer.haugsbakk@gmail.com> <88A192B34B3D4DDDA47628687AE458D3@PhilipOakley>
User-agent: mu4e 0.9.17; emacs 24.5.1
From:   Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     git@vger.kernel.org,
        Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
Subject: Re: [PATCH 1/4] doc: add articles (grammar)
In-reply-to: <88A192B34B3D4DDDA47628687AE458D3@PhilipOakley>
Date:   Tue, 13 Dec 2016 14:05:58 +0100
Message-ID: <8737hsj7wp.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thank you for reviewing this series, Philip.

Philip Oakley writes:

> This looks good to me.

I'll add this header:

    Acked-by: Philip Oakley <philipoakley@iee.org>

To the commit message of this patch in the next review round (version 2
of the patch series).

Let me know if I should add another header, or do something different
than this.

-- 
Kristoffer Haugsbakk
