Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27B8A1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 14:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKHOrP (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 09:47:15 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43977 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKHOrO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 09:47:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id f24so1653249lfh.10
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 06:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1KxugK3eG4ilIUG9zZ4jq7mg1XJb7jMXOE/9ug79C7g=;
        b=rS4v9sl806N8FYTf9+9tIHvNpubctPF4z7pAvqipucPy/nOC9ZYQpGqLSh6zQQ/kSh
         uSljYzHT3vbahblmmHbvsI4CKmWCaP1b8LLS0cqbzfE5/xijkbepWPRm0apQi6isxiOk
         YwxjqYqLvIOeNOEIpD4ugeaX9R6A5Um+1FgcwO1U8ygisV/yi0v8hg//o7/FgRXE/qlr
         GfACM8MOyGVN22ODqULg2swYk5QVHMxQUjI16DeMSiu3TiONChNDJp7HiqfO1mULA7HD
         fcZAJ1a0ui2GHZMRLS70/9jLGPjEqPohd5fcypSYNIer2JU1OAd2m9BR9AyiDmkyMXyn
         5iJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1KxugK3eG4ilIUG9zZ4jq7mg1XJb7jMXOE/9ug79C7g=;
        b=Uomh8jTtBDuCWGtWdCyWJEcUkx4qAmc1s8DWY2G7wY0fGzXWKuSaOKhSG7b/aR4gcp
         hLy0tTu0TRhwTwJSHjPgH9F1LipAec0266K5Vn3z6xAWO7ZodyCRPXA0kG2ahwTCfUbN
         7z//t+wgbiZNSGxeogeu+gNvXGiAZ+ai3WG5g2c2U4PdramYcdiSJQ81F1p3fwIic0im
         2DLyRxznNCna6NKD//UDOeIBric0rnbe4lysj8oP2KIARwj4k3JX8/mt5gVYIn5X5s4S
         5diZP2FLDlmiHRZEQcuRZ0dfVtYknAvXbt+vhZdD/0JchJJxYyooFjn0k8Jl4W+mnLlf
         QL6w==
X-Gm-Message-State: APjAAAUKzEyZ9AxJhuq5gaKrPomB/npIMv4YAXcYJPfqceNjCRSP9I8K
        5GfvqjG85UhgVb2h20cYGciMYnF/A/vsXlzQh7/xL/1u
X-Google-Smtp-Source: APXvYqxSDvIWR5GqRFFnQgpi1QnydNeUEOeIDcHZ1ybFFev3lPEeHvk5yUGoAd8CU8Ofd/Wswpcyq39f2sVsq2jvowE=
X-Received: by 2002:ac2:4302:: with SMTP id l2mr2078156lfh.116.1573224432601;
 Fri, 08 Nov 2019 06:47:12 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Dominic_J=C3=A4ger?= <dominic.jaeger@gmail.com>
Date:   Fri, 8 Nov 2019 15:47:01 +0100
Message-ID: <CAFOfB_LMQBOFK5PzhezcMGshmETY0agVK_iRW7vEayR9=Oyaow@mail.gmail.com>
Subject: [PATCH] merge-strategies: Fix typo "reflected to"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

reflected to" does not exist (according to
https://dictionary.cambridge.org/dictionary/english/reflect?q=3Dreflected a=
nd
https://www.merriam-webster.com/dictionary/reflected)

Signed-off-by: Dominic J=C3=A4ger <dominic.jaeger@gmail.com>
---
I only took a quick glance at the submitting patch guidelines.
Feel free to quickly push this yourself if you want.
Also, I'm not native, so I hope I looked this up correctly.

 Documentation/merge-strategies.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/merge-strategies.txt
b/Documentation/merge-strategies.txt
index aa66cbe41e..2912de706b 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -32,7 +32,7 @@ The 'recursive' strategy can take the following options:
 ours;;
        This option forces conflicting hunks to be auto-resolved cleanly by
        favoring 'our' version.  Changes from the other tree that do not
-       conflict with our side are reflected to the merge result.
+       conflict with our side are reflected in the merge result.
        For a binary file, the entire contents are taken from our side.
 +
 This should not be confused with the 'ours' merge strategy, which does not
--
2.17.1
