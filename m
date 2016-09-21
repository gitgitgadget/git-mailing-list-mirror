Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52CC11F935
	for <e@80x24.org>; Wed, 21 Sep 2016 22:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755254AbcIUWIG (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 18:08:06 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38146 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754689AbcIUWIF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 18:08:05 -0400
Received: by mail-wm0-f51.google.com with SMTP id l132so115566627wmf.1
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 15:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6TMqfpieuhx/ChMcoI9Q6CZuxhH6RQIvQhsVLq5zXFY=;
        b=IlPTY85rfdny4fEvPI43ObIlx3BCDIRnETVwCS5dlZeVBfMdWUFpb7GGlceRQNkIOp
         RTBO8v5Q0JCgzD+TxP33vZTLnrzHIsHs08f0VMQXsGEqJmW7vHU1LicLM899EDs0AXbA
         x9q2l/Tbss8fQwOHDvFaOrofoI/Zvach5i8PpRyKkOTU6+J2giDVhGi+8IViE570eda6
         jN6dqXcG0sd7sMKJzNWQvRDnipaTMSbn44gJaOQvATN96yHxXkIEiWo2St2Hs9FFWPX+
         cQXNILMoO0TuN8huAI9d6X7M6vs5ysLEts1XfuhSJuV1klWIlwsVSuXgZCFJ9NByEoPe
         hSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6TMqfpieuhx/ChMcoI9Q6CZuxhH6RQIvQhsVLq5zXFY=;
        b=lY9DVq6gQJOqMs/EUlhtnVbGs56XNWVRJYAPkgd1p7UVXdSVHNjbQrY7EZRxSuhZjL
         HuCT4mrmVutcsCNQm/S8GJYckSLD5oH9fL1l9+ekm4A1UoFbNIWbCg9aUbfNOgbUBTvK
         XmpF5eYa0P4xd98wz/B2vqFcfRysJTFEbeejIl8TsFfFrQtL+tlAc1N1yUPNjv/QDYfO
         M5KOMmqd+TMi0vPx4Tj/ePGruA7xe4w/a+utC7oae7rTdGOFNlaG8HMuUDFB7qaASbF9
         tKY1JyC/tH1pOU7bk957LwQwnCXYUlFkkMCjPr3QVwUTBGGCqUqGtgV1K3AsNKykn2Qb
         Avww==
X-Gm-Message-State: AE9vXwP1b7JotTR9jryxSIdJGlwDUZDCKIEpDaBsx2EV4dPMUovpxmV1zydh9m9JkJ7rum59Zq60GmU6x0fQAdWQ
X-Received: by 10.194.164.102 with SMTP id yp6mr34931864wjb.50.1474495684197;
 Wed, 21 Sep 2016 15:08:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Wed, 21 Sep 2016 15:08:03 -0700 (PDT)
In-Reply-To: <1474495472-94190-1-git-send-email-bmwill@google.com>
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Wed, 21 Sep 2016 15:08:03 -0700
Message-ID: <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another version of the first ls-files patch i sent out in
order.  In this version I fixed the option
 name to be '--submodule-prefix'.
