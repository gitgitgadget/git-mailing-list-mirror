Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1D161F404
	for <e@80x24.org>; Thu, 16 Aug 2018 23:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbeHQCLT (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 22:11:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34398 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeHQCLT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 22:11:19 -0400
Received: by mail-wm0-f67.google.com with SMTP id l2-v6so16755820wme.1
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 16:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=IPE7xP85DH+cKZG+IW/4+70A7N0M4lWKeGWjMxywrEg=;
        b=VmWI2yfFvHgpNVXbaDCiTNRVuSZEGuzJdzPAzGA4YNKyYouYaM+nlioHK462JskRdP
         039za7LoRgOMTr8emEPfho3fuXlFjiFtO7lR7v+0IjANaES/4hrXn1I0EO8CWIRI8xvI
         y5OFyPXmF1tu33pPlh0kVLoq6nULP/OoAo7GIpaHw4ydQ0fZ6lvxBFfmd2mqwl2MzZm/
         CM3FjHtJVgOZv+8oqPZ6xCvbfAAb3WpWvrycBECtbHiUBreewa2nUiMD7ccnC0ZwWgxL
         6fCc8ahc3r0BAZE6GwoNQp1uF/tpBA+B/6W3jz9cSj2ZqYDXhH5cVqBujuMQKTjMxIF2
         upCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=IPE7xP85DH+cKZG+IW/4+70A7N0M4lWKeGWjMxywrEg=;
        b=Y+MspfshZ5rQu7JAa4G5901DjJsozDdpa2Izv9nZHZXLJUOX/NC8PKM8qGUnmH7goD
         D/h93Xj14cjq/92FQDDu+c8ZjCAip9ISKMjdFtqhAgr4MoZcUnAl0dAPWkiBufaN4Iya
         iDFb3E1VKo+ruUiI6rPX1izJmpc2CwwZToDBVEMiR+hkrIgyqnyz1Rx4MKfgvFFM2zJf
         rFljAN1pj+Qce5zd3Rrz0WR7FjrwIxSLxhhOBLjgwEvi6TS96grhnWyurs954Av/DHEq
         AFT3KCLAdR107E9W69QHOc+EZPqIAJ9Vy/v4Jfqq8tGCvkHDGcqy2z2oI8jm5u3RzPOl
         uenA==
X-Gm-Message-State: AOUpUlG705sfHfzzEP1eJCiPl6i7D4lk1P2CE+49bFI2zYHAPNr63Qa6
        RuzkSV7ikPhYbCcAdc5yXA0=
X-Google-Smtp-Source: AA+uWPyxBp3TrZmMeehpEqO2OkMblDr29ABrT1UPG7j1DW0vmpBd25JCw5T1KPHsCAmkUVqSRVE5TA==
X-Received: by 2002:a1c:8d0a:: with SMTP id p10-v6mr17759614wmd.121.1534461018497;
        Thu, 16 Aug 2018 16:10:18 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m129-v6sm18266487wma.1.2018.08.16.16.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 16:09:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Git Project Leadership Committee
References: <20180816224138.GA15490@sigill.intra.peff.net>
Date:   Thu, 16 Aug 2018 16:09:31 -0700
In-Reply-To: <20180816224138.GA15490@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 16 Aug 2018 18:41:38 -0400")
Message-ID: <xmqqmutldi38.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here are _my_ opinions on how we should fill the role....
> ...
> So here are the nominations I came up with. If you'd like to nominate
> somebody else (or yourself!), please do. If you have opinions, let me
> know (public or private, as you prefer).
>
>  - Christian Couder
>  - Ævar Arnfjörð Bjarmason

FWIW, even though my opinions might be slightly different in some
detail (e.g. I would not place as much weight on "ideally a
non-professional person" as Peff does), I pretty-much agree with
Peff on both the selection criteria and the nominations.

Thanks.
