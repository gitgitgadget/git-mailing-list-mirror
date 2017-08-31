Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD09F1F4DD
	for <e@80x24.org>; Thu, 31 Aug 2017 08:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751023AbdHaI2m (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 04:28:42 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:36623 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdHaI2k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 04:28:40 -0400
Received: by mail-wr0-f175.google.com with SMTP id p14so60255wrg.3
        for <git@vger.kernel.org>; Thu, 31 Aug 2017 01:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=gtpnpZ3FUHzK19ECvniydaYeMyCJXBfT5FdzJfw3eD8=;
        b=W4XauXmWYJI5z5tca0EHQj336L7fE69t1G7wYztNiXV49rqNQps2i86mJlZXgZGZ+4
         jp/frVhT+BkdpJjGa0vqTEzrhOdztTOzoYSQa807wDaDUUPKwGv6kHyApa1QZck2pj0i
         hhSEsWwV4uueIe/k7uPtFWs/Lp17XjJ+6DqmxzaYuUyMLP5z41DbZSrao7otu1EZDihC
         QvsXgPsI1lAIcDqkN+pvPoGd5fnI6DP4p6fBrtC5WQEvBrePfpTZFDL673EkKg7Kmqxc
         iyotHINqHc44OOXEu8z2QSVVe3x5Y1haRUMXnwA3fWm1ZZKKJ4hujcwIAEcphyAFI4eb
         jOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=gtpnpZ3FUHzK19ECvniydaYeMyCJXBfT5FdzJfw3eD8=;
        b=HHv7eOVQkOugG8BTI8Cle7br0/cYHpwzLa0HPOYptZ6n55nzaDFAY121GQtyUlwwPO
         I08EXIyWiaxz/9RjUk0CTvIF1PNXYg1RxPmWbjElfJjlxuJtCwgWOoYsbqa7uKl+cLv/
         b5/6zko1EkRUJJqJ86rqdK4HHPVdScwxNxUpI8lgL3MMPHGk8td+5ET6J+OXK6LwmVxH
         r/EkM7i2wtEM84NNUxE41TWi8Ju+kxvODWDBZkQktnauS1C/avsmOZGjBABHt8kI8Mcs
         V0ZbI3oqET5/huNYydp4GuGOEpkDLqIIe/Jfp0qkwiavn5lA3UBdXfhCnw/J2L7oVetS
         /edQ==
X-Gm-Message-State: AHYfb5iQgHUkcfVZIsOqFxgxkSdi/6JwLwNSGQ1l2JD5EPiAYyIglkr7
        I9H+yOwIDy4Hmek9ZbM=
X-Received: by 10.223.199.84 with SMTP id b20mr2515877wrh.21.1504168118723;
        Thu, 31 Aug 2017 01:28:38 -0700 (PDT)
Received: from potjb0bjc2.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id w74sm9975110wrb.52.2017.08.31.01.28.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Aug 2017 01:28:37 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: git-scm pages deliver outdated Git docs
Date:   Thu, 31 Aug 2017 09:28:35 +0100
Message-Id: <21957FF0-CABA-4B93-8BD0-42EE28197395@gmail.com>
Cc:     Jeff King <peff@peff.net>
To:     Git Users <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

looks like the git-scm pages deliver outdated Git docs (v2.13.1):
https://git-scm.com/docs/git

Is this intentional? If not, who should be contacted?

Cheers,
Lars



