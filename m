Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72416C33CAD
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 13:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F220214AF
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 13:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgAMNuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:50:14 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:50900 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgAMNuO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 08:50:14 -0500
Received: by mail-wm1-f51.google.com with SMTP id a5so9760253wmb.0
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 05:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpcvOKvMDx/rnmQMtskgQXDbPK2A4KyM4d2utkoRp8Q=;
        b=r+t1fTRBlXg7hilC2mrZPCttmio70gfyMuZBGTRNSWuTjG0IDp6I7zv3/P1HhymKFB
         DF7+8KyyUvYqMHtg5SMeZu2vwsAm99r+1OR4tiUuwv6x8CA2nAZe3EoT35df5wTQCVkA
         SWRnyv0dNZnDd8f4zPuCgOUVanQyef3TBXNBBQunoQPn4ikJY6p/U15RzZ0jNMS89IUs
         uQMPubTkNcW7IlEFoAj2AvpZWQTz8+XA4ArhuWUPzNDVz2q3PVseKPPcmedHgeQhmVcb
         iGiYGY44Cv9g4ZI05e3M23GMJgwwRyrW3ghFbnaLN5qGWy1/6cSOvUNUjsjF+BQm5N1A
         ggng==
X-Gm-Message-State: APjAAAVg0XX4LGSpE+JIzWXyJmXITyQnX78Gcd7kx9XZ2AkoXxH5+KNK
        8bJYHc309/wHPFwgDbApJASW08ScWcxxLPhso9QNXg==
X-Google-Smtp-Source: APXvYqwupkehhuRrwoPexZHGOKszn+vXl4rrrCejJshX4P0eZGpVVkVvMcnJn/47UPjL73DuBGftPfCZRxiVeU+hxi8=
X-Received: by 2002:a7b:c246:: with SMTP id b6mr20030078wmj.75.1578923412563;
 Mon, 13 Jan 2020 05:50:12 -0800 (PST)
MIME-Version: 1.0
References: <20200113123857.3684632-1-sandals@crustytoothpaste.net> <20200113123857.3684632-18-sandals@crustytoothpaste.net>
In-Reply-To: <20200113123857.3684632-18-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Jan 2020 08:50:01 -0500
Message-ID: <CAPig+cTZKQ_0eZuMSYbaL9u0k0SJGeuh-N0uJxALTfyzP9Ab1g@mail.gmail.com>
Subject: Re: [PATCH 17/24] t5318: update for SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 13, 2020 at 7:41 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Switch two tests to use $ZERO_OID to represent the all-zeros object ID.

Missing sign-off.
