Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 984F81F404
	for <e@80x24.org>; Mon,  2 Apr 2018 12:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbeDBMFn (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 08:05:43 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:46398 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeDBMFm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 08:05:42 -0400
Received: by mail-io0-f175.google.com with SMTP id q80so17634936ioi.13
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cGkKj012CD0XH3hZXHTEgy6CX8/fYol4Y7J341B0N4Y=;
        b=DBCVsbwqphynpUayWvAWnUeIfrCIXBLEuUSyy38h1Mq74XGpu0Ot3e1KDbzLp3dgjI
         MNdkxiADCiqPBkv2qPr3up1mY9BnDSGSxNqIDOidcV6AI8Si+sTIUPan78GplnvMeDyB
         ujzJqE3+j+RSSxFaHoL+jXg6oxAOVuesqU58mjbXzJPbDcdjjZ1HBU5HHsWJpTMxHunA
         GmaYHVkTdd7GQAikE6qWcoNFEH13xVnHaqWjDoR11kam9jeWbyo1zjL49pF0HfGnXZ98
         /IgEI/DHyUsy3pt86RwAaoVFnHDVwc3bebIzVBze3JS5GQX2iFS9zvz5VnfmMkjF9dku
         PP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cGkKj012CD0XH3hZXHTEgy6CX8/fYol4Y7J341B0N4Y=;
        b=VZhsekdGGm1jXekgGmypOoyXdelAPe8lRq+kAvjLZyB6iQUafQA+hOJl/iPS35+ZLU
         1khOzhlUp6XFru1HEnfHHWyW0IJkWow/SjEkxG//SEFNyN6r3BOBRlY/Lw2ynmYWSB7L
         cmq69k3UpHvt3LWD8hpLFriDjeHwcPjpvGBXgDmblgdOV57EEA8ftIJFXpD1s5iILIpH
         Bu73xAEYtEPawxrc0Dslg+d8YdThvjJFpWZfKaODCMUe1aSLDK/CmraMovbdcxobdedj
         C0l0ClDiTgMhIJSGHer0KV7ms274uYjm1/yYF2pu9VxSDWvmp2xvj7HEhXugRva3/wuj
         5mDg==
X-Gm-Message-State: ALQs6tC96E+03t0EI8aLwEeI+u6FyPA79kb9gMBLiITxKQZ3uWpWGslY
        Svh5gJNdYiCwzn3mslOElcYe0rdIabTOG7ag7ZNrkA==
X-Google-Smtp-Source: AIpwx4+XfCXU2iSTU9nTkp6LEzAPU9c9FITzsmpNWD9WZLTJVBmcn1IjCBmC/wkLl4e/7dYW1RIZZOJPukyKVkHg9pg=
X-Received: by 10.107.48.19 with SMTP id w19mr7917534iow.104.1522670742343;
 Mon, 02 Apr 2018 05:05:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.85.4 with HTTP; Mon, 2 Apr 2018 05:05:01 -0700 (PDT)
From:   David Hoyle <davidghoyle@gmail.com>
Date:   Mon, 2 Apr 2018 13:05:01 +0100
Message-ID: <CAFGVh0zWuqa5HswE7JAx3-bOSGGaRAgLa6ULy--+yn_iD5eJRQ@mail.gmail.com>
Subject: git log --oneline cannot display dates
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using the git log command with the --oneline switch, you cannot
add the --date=<date> switch to see the dates. The only workaround is
to create an alias and use the --pretty-format which doesn't provide
the ability to colour the branch and tag information (as far as i can
tell).

regards
David Hoyle.
