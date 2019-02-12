Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A751F453
	for <e@80x24.org>; Tue, 12 Feb 2019 17:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfBLRAw (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 12:00:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39107 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLRAw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 12:00:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id f16so3797493wmh.4
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 09:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=k9Xgn89Nhth1B4lGigipEtrBalqkVP1/+VbMVauWb64=;
        b=nLS0e04eiKr54F4eK2WZ8uCDXMGAsCpe9oSmRhtofBzQQCvwJLsmxrT3XXHhO0Be7K
         bCCHf7aJaBz42QBfkKnq56uxooW3RcT4mv+swwhPy/Jb+kkiiWRTira2QDy3wRpgzLNl
         3YDZtdVgt1+LXQFXzim72KNpfcO6otC7TW2w2cUoyr/ommV2w8NO0/pFp0fAh4F7Qkg0
         kT6vM5mQ1JpSuxEbZdVUKrDxMOMprHbaZnCd4w0Wn6KtxsnOwqsPmKFRQdBdj8vTXJc5
         TNGiCBRq6/jdn3Ruzy/fEFtHn4ZnlyqBWaruvbE/aYPMcEgRD95Jic+xW8L0OEWG9KLz
         BeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=k9Xgn89Nhth1B4lGigipEtrBalqkVP1/+VbMVauWb64=;
        b=H4uSEQqDKJ3M8hI7A4OZWzwKk9R5MHtj4LJyfGiGM4M6eIA5ZCkPBBDTvwsFEmr4Jv
         cbsfVjU+yYS4xSGaIZzJN+IcO2eo+M3ClbkAj8UsR13SA1E4BS5eKfRSt+sx35B2kv6K
         hvDABlPNnRtXjUYDs/zFtOARU9ypp/RYtjAADTL89ugwYYfq35BiRc8eJInltLNTyynh
         S2tANXCGusg+2KYYrPlg9ViV5IiOa0soHrCzqxFYo7Icv9JezBNVhkjZJtifVvoC7WOT
         i+tKfvAkUXDvvyEarrMxWsQmBUByQ/bSM0RpbJsgMZrw8lL65wsCvUYNvarg5aiB0l7x
         wMIw==
X-Gm-Message-State: AHQUAubF23n3nuAEk7N6qU2CU1pnTCIl/4o4rSYQjDm2BTU44WF6VGg4
        fF4zcQuYRKQM7r1F4Fp17dg=
X-Google-Smtp-Source: AHgI3IZ7IHGbzuGTAe8wcWVNInrRf2SXSSLRHUF9wCqVLNHVGDzzgvi0eoDutDbHEgwiforJjaIoqQ==
X-Received: by 2002:a1c:c489:: with SMTP id u131mr3292993wmf.127.1549990849865;
        Tue, 12 Feb 2019 09:00:49 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s5sm3814108wmh.37.2019.02.12.09.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 09:00:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] RelNotes/2.21: tweak "--date=auto" mention
References: <20190212063247.GA21872@sigill.intra.peff.net>
Date:   Tue, 12 Feb 2019 09:00:48 -0800
In-Reply-To: <20190212063247.GA21872@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 12 Feb 2019 01:32:48 -0500")
Message-ID: <xmqqpnrxdjr3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In the feature that was eventually committed, "--date=auto" doesn't do
> anything. It was generalized to "--date=auto:<format>".
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/RelNotes/2.21.0.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks.
