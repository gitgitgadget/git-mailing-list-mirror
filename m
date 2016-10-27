Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1BE20193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942746AbcJ0Waw (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:30:52 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36165 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933403AbcJ0Wav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:30:51 -0400
Received: by mail-wm0-f52.google.com with SMTP id b80so61931714wme.1
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pelly-co.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=9pu60QHCxz4UVUhlH6rJaIUCJ18iijRYgFH9w/AWiI8=;
        b=UeZj0AOipFm1vqtAuGbwz8ceWVK4ikQgwF+3DTxIZ6f3dgBK7qcmStBOKHhNZxSReK
         vxvI6tiD64iw0hXXOfAKz8gkiE46ExMGYQE8V6YqpxKHfRtwLEqX5OG4ttZ08o185epW
         DtqWunFVNYOOfJCh/CMhRxfeQRNiACzRMvBpl0FNLJV/4cywnc6oI/twP5j1wfH7DVaa
         35XtAtadoxtmIbZW0tY9mXSZV5fsEMeN95LhvWSSCH8pFM4Ocrr+eNM5aIuiueSlj+Ey
         ziAL0u17j38jnTGYCj48sk3Ft4IM6HMzc36V0mF5btAG2gZ1y8cdgUr7PEDChucUbt5d
         JTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=9pu60QHCxz4UVUhlH6rJaIUCJ18iijRYgFH9w/AWiI8=;
        b=MOzPfZhEe6yG4Y42/bNGDuQDaI3pyZgw5EVPxfH6cz2sMsW0qAiv3/dRkibySS39JW
         wLm4zPs8hZO0H/noWgkjDJ/o2he3zWJ4VIwdl86UQD4eSHNTiF+K5rH7L0Dpi7anlJgj
         qYmBAui7O7HD7v1huEHZy9fJKTjRhwtJEVb1bUfe/C7r+x2xoIF56A4WcY8bbiaqEkul
         OAfGYTvy1AMeWhH8cnbB8DR8fDYheS9qNuvFe5a8GvVtRqo+kajWuN0IaHekfRFPv20i
         XMN/u/B3TO3B0becspt1vJfXJqic68v+4MBIHr9vlF6hqlANviWavu/ln+kbWc2ZhJpU
         J4oQ==
X-Gm-Message-State: ABUngvejNLVoMZvpUg0eclVlaqy9ekGOH47N117FZsTqQkHGjrSZlvBrDvZO3xxsLFa27A==
X-Received: by 10.28.45.198 with SMTP id t189mr604002wmt.52.1477607450181;
        Thu, 27 Oct 2016 15:30:50 -0700 (PDT)
Received: from [10.3.1.6] ([49.50.252.82])
        by smtp.googlemail.com with ESMTPSA id rv12sm10824923wjb.29.2016.10.27.15.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Oct 2016 15:30:49 -0700 (PDT)
Subject: Re: Expanding Includes in .gitignore
To:     Jeff King <peff@peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
 <b20b458c-440d-df09-d2c7-e510ac20492c@pelly.co>
 <20161027205508.vqw44zlbnqpj2cvd@sigill.intra.peff.net>
 <20161027210753.btc7zbndhdocsbwa@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Aaron Pelly <aaron@pelly.co>
Message-ID: <ad01f925-dcfd-4b98-6998-73965c72f69f@pelly.co>
Date:   Fri, 28 Oct 2016 11:30:44 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161027210753.btc7zbndhdocsbwa@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/10/16 10:07, Jeff King wrote:
> I think it does
> introduce compatibility complications. People with older git will not
> respect your .gitignore.d files. Whereas $GIT_DIR/info is purely a local
> matter.

I know. I don't think it's a serious compatibility issue, but more
important people may disagree, in which case I'll have to review my
stance. I think the pros of it working everywhere outweigh the cons.

I will say that I am a proponent of consistency and obviousness. I would
rather this worked the same everywhere or it was a completely novel
component in $GIT_DIR.

I don't think I like the idea much, but it would be possible to
magically generate an ignore file from a directory.

> But perhaps there is a use case I'm missing.

A new repo where the dev tools haven't been standardised yet. New tool,
new file. Simple, and somewhat self documenting as a table of contents
in .gitignore.d

