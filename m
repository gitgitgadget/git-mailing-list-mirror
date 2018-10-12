Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95C341F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 16:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeJLX42 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 19:56:28 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:36956 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbeJLX42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 19:56:28 -0400
Received: by mail-it1-f180.google.com with SMTP id e74-v6so18980521ita.2
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sYH6vQ9cWwrgt+DhCpIpyh58uu2BIYRxO/HbbJyw95c=;
        b=qlDj5WA4FX5d3q841xKYDI4j/F5AgsR4kSaqDstr7ROywnSR3szaCvtVY9NsKtxiMZ
         L7rEbGl+E5hDB3zGMRzr/nEFPfV+Ou64DbZ4ENDGHZfi9B612YqVa9aAJSxwrS/A8GyD
         QALExaoppV3m4oe/tNIciSHq9hFFUuvMGQ2FLmB57i2bi7xMLiUDTTwImX1I3s6Z02t3
         DwC+nsfmEMtG0z/n/cAPvdeVWXageatKqxZ0IXJy38DHquXQFgrm1IhlNWj2ESs5Ynu2
         HlPdNSE7HjviD1ZSZlznYpveCDoTrmUTDzVgDDnngox+nQDVA4p+KI84+CpqclOGiKbL
         Idiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sYH6vQ9cWwrgt+DhCpIpyh58uu2BIYRxO/HbbJyw95c=;
        b=Ha1hmP5mWRDMsdGgMmGJEvAjmdINOiF6YeyaiS7wLgnro2+ZYj1DLaqwvnzif8TGJA
         zAa1GwTLOdPSZiJtYdRgV83AM4+cKjXFHEutFvQFgrPgNANUB3nK0hQ8oyK8b7fxce8J
         5k5E6bLQeYosuFz/SN4aLNN0XseYM+c1z2pg7pki8uggfvbVeUZqPyB906REkJ7OdPJX
         HYGSmUzmK/GTAOXku8z4TR+UOXTFrw2ps5RZRgewbDaySF4yjXUHaxz7UXgDzW+KSIPo
         bpvmDLH1wyTC1sV/cHv0IVOVJZcUFsKg17C455OpqHKW6iyl8+JFgArdGcZpIUybGAiF
         m0gQ==
X-Gm-Message-State: ABuFfoi0bZk5mS1yXNVQIA9oAgHV8FxjbDpln8GA4eXksEW0Ftjyfe4G
        E+98B+legpG0qoCMlpZUti/GbtN+1qrWvhxluTTlog==
X-Google-Smtp-Source: ACcGV60xWIaxEqMpuGsnhncHmTZxF7gmuRQwDWe6PKZdZcgoLquxbst10XtJaO7D4gih13aiLpUV/FLneHYj3rH22kY=
X-Received: by 2002:a02:31d:: with SMTP id y29-v6mr5461689jad.98.1539361392643;
 Fri, 12 Oct 2018 09:23:12 -0700 (PDT)
MIME-Version: 1.0
From:   Farhan Khan <khanzf@gmail.com>
Date:   Fri, 12 Oct 2018 12:22:19 -0400
Message-ID: <CAFd4kYCTuLMZ6UDk49MASbZfhwjgUcmfeyd6jZS5QO9-LnzLCw@mail.gmail.com>
Subject: Does git load index file into memory?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Does git load the entire index file into memory when it wants to
edit/view it? I ask because I wonder if this can become a problem with
the index file becomes arbitrarily large, like for the Linux kernel.

Thanks,
--
Farhan Khan
PGP Fingerprint: B28D 2726 E2BC A97E 3854 5ABE 9A9F 00BC D525 16EE
