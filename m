Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2970D211B5
	for <e@80x24.org>; Wed, 19 Dec 2018 14:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeLSOc5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 09:32:57 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:37042 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeLSOc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 09:32:56 -0500
Received: by mail-ua1-f50.google.com with SMTP id u19so7040584uae.4
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 06:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=m54cGwsi7g1BsqGW1uysnxiFYyXy5w+Cr+0CXKQCrPo=;
        b=BMynWjboIR+28t9BJDQBJZNyp3IF7twRCf4b83H6ZLjmCcJItkNQX2mMZaDeQKYh9i
         flcOWK4lZUu+zAFv9GtSKZWkGeZb6/OmxxSYioPlkOHLQvG7GVkBbLwEgOLkU2KfT4B5
         2L3MS6rsSP/PcNffWQGkwDq8G3ZWSZ5xLTw03MUWfDyP4qOQt648vFYv7rvKiy5S6WKH
         aGPJ4znH08OGlVmrqfkIIKO1dBxVL7cuWuQrp4/GahFNwt/yxQvkZSo9F/MbNpIoQc3P
         IkUrEdZgIUTLWj+wSHfMyK04OqMWSzmIgzUqYCy7gOgElKrMQPtw8JJupKgghWCwP+At
         gmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=m54cGwsi7g1BsqGW1uysnxiFYyXy5w+Cr+0CXKQCrPo=;
        b=JWI1qr5oDvU8HUXwRH2mjA9bXVcluqqbTHSp/yDjRu6zq17aBy8dWxUVmFNOC2fP6V
         RCNlfjpD91naCi+gfsjYXHo/ZHXVI0YyKlIkWVFLtiyImxO16YccAXTDVTgG50W80mri
         P5swswIafM6pcdDlAcNAhRygjEBvw4Tsl8whjc8eez6efRciXxnhpPUAe4U3gWZ9MdZA
         eQ35JZKld5vZqXIZLrzhow4ZbiDBRHvacKPt6nSaJPd/9JDk0eVt+1Oeozq3iBSNBJM2
         ikfjuaJygkVksqvAX9mh4+/9u2uKkalPvGTx/Flz71c5H3VA35weEucJFkffek/jZF8G
         8YIw==
X-Gm-Message-State: AA+aEWY2IV6JYSGO58E1LuVf7Es+doMmL+FL7e3pYoYRSfBKTDXtMO69
        woRY/rT+TpAnV4elshFudKumDPk0nK7Be5UB7OPGlA==
X-Google-Smtp-Source: AFSGD/VkPV+n4tZqcTSFUOhFvcqWAMligfdC4UcivxFAx5AO5G4NQ6uULZ9YzUJI2JTlNzN4klBaxbaRHccloXOxVp4=
X-Received: by 2002:ab0:216:: with SMTP id 22mr3560170uas.28.1545229975209;
 Wed, 19 Dec 2018 06:32:55 -0800 (PST)
MIME-Version: 1.0
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Wed, 19 Dec 2018 16:32:43 +0200
Message-ID: <CAGHpTB+8v=pr1+hh-Ptuo=5Vv9d9AD0ox9ot1576XwOLFdihdA@mail.gmail.com>
Subject: Built-in rebase doesn't execute post-checkout hook
To:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The new built-in rebase feature is much faster than before. Thanks for that :)

One problem we found in it is that doesn't seem to execute post-checkout hook.

Please fix it.

Thanks,
- Orgad
