Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1931420281
	for <e@80x24.org>; Thu,  2 Nov 2017 16:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934086AbdKBQBP (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 12:01:15 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:46218 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934009AbdKBQBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 12:01:12 -0400
Received: by mail-io0-f169.google.com with SMTP id 101so51497ioj.3
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 09:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=L02+h0GF76ixSXbhCEjHp6CEBSOVWxigTERF6fweQ/A=;
        b=jqtYMDw5GV/PKLMsJFqezBvnhjX+TBlTgwEBD3jDha3+GFc2VK4jgRKsblsnKpvOh4
         JVauzW8t6rWOqSs8vEFR/P4jI3XX9yErbQ01mczv7sVRG4H92Mwhaoi5Icx46F89pupv
         UidVhH9PpzTiO5coTKWucQhonneAXBqVSFYy8Gr7oDkZOaFaABytl1NJM0CfHY4BoO97
         pkxeNNXfKv9ZoX+16KlWaJRYtG7RlJZKy5h7SzuCpZSPoil+h1X6wsOeXiUorzQYA+jF
         l6AsK36c1q4gcM8YPn5n4duFMjKxcAbF5uZKNXED+Jl4Nmt7jR008UnHrG3JPeyfbzQK
         UY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=L02+h0GF76ixSXbhCEjHp6CEBSOVWxigTERF6fweQ/A=;
        b=HCBH2JK9Uj/a/Eu9r5Hi9juPegc1ivkfpqvLDMAn6xtHkDpfdF2zECGZux/Cr7HZ8q
         TKMd8zjKXRuxzvUcyrdc6TrN7DkhPvJByJcpp/MGrgclr2Ft27rYKqVlt8cdXcn4lhRB
         nTDKChADe3pGP467e11oQx1sz/QAnoIFxmqhc22G9X4A7PaFk/YEhm17Z5jNCenUFQc/
         XJ32IoldAC3+MNJ999WrSP0gwLrVDvcX4D4aFXhMh7M3GfC7MHFx5oKbtTmrf15eVugL
         LlMa3Pe8Mvye5qjOBqUmD9F79+rlN6GpF60T6rAXz+0RDTMSKrGZ7E9lVBK2PXz5rJjM
         /Hzg==
X-Gm-Message-State: AJaThX7RcdS4374dMm4DEqPIKuKQBEV5qSGS+F7MzjyRJTLqRt3Qv/vt
        hlrMexiJePGqNvjMUXndpzoRfIb3r+I9VDaMXJvGSwzZ
X-Google-Smtp-Source: ABhQp+T7csk2oyi6gc0NY5CA3YCdrM7vjTXCYs7QbhBMVzKLIbgDdnEr375WIVEtwpXX/V4GcyXTXZJscKvRjk+HQeA=
X-Received: by 10.107.184.66 with SMTP id i63mr5040292iof.17.1509638469985;
 Thu, 02 Nov 2017 09:01:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.22.15 with HTTP; Thu, 2 Nov 2017 09:00:49 -0700 (PDT)
From:   Yaroslav Sapozhnyk <yaroslav.sapozhnik@gmail.com>
Date:   Thu, 2 Nov 2017 12:00:49 -0400
Message-ID: <CAOAxMp-vAM7mCWuanj69coM09zF-Sxe=G=-XMd_RmaAne8qFvw@mail.gmail.com>
Subject: Git libsecret No Unlock Dialog Issue
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using Git on Fedora with locked password store
credential-libsecret asks for username/password instead of displaying
the unlock dialog.

If the store is unlocked credential helper gets the credentials from
the store though.

-- 
Regards,
Yaroslav Sapozhnyk
