Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E17C001B0
	for <git@archiver.kernel.org>; Sat, 15 Jul 2023 23:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjGOXWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jul 2023 19:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGOXWb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 19:22:31 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01254271E
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 16:22:29 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76571dae5feso312184285a.1
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 16:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teknique-com.20221208.gappssmtp.com; s=20221208; t=1689463349; x=1692055349;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=doKJRIX7j5YL6s0GXId4PlmV6tpL7kk5CozVIRzpDMs=;
        b=HOGM8ozS17Fw+ByxczPOmoLIc8X0zvedwtNpsq+246YcaP2ObRqJkBeTu4h0mrUL1i
         oKN7x+/WcXUvnCXBj01H/+ohfTroYHqKtU5PTdq0igN1rR9pfj/ITjCHNnLlExlZq7sO
         y9gTzHAFOXwbYxmQZXRtDQVOkuno2C4nJ22AiqQfLNGL4iShsPoPu9wogM/iVLknMZpm
         gviguMJkX6ek95ZzTp5+zm0i9u86tnVzyHaKGSBTBNZ321Fb2i+ytIMDj827oFXSqFj/
         EUiX2mHBm+liN+F6VvZK7+e0GvPIVGwsJKs8z4tEKpxhPhD2jWFOl0By3e84OYlaWmhT
         oqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689463349; x=1692055349;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=doKJRIX7j5YL6s0GXId4PlmV6tpL7kk5CozVIRzpDMs=;
        b=Ymos4UEnl4qqvkpnKqxI9Zkd9YUy4oYDvYL+UD96SGwl315H2xElTICtlQyGcdqNk5
         GrdZztEeKtRTbLnANbvFCtTj13e29YgFZdRIu7zw6xaS4h5vuWIp1wlLlmP4fFR8/rQm
         KW7WE/JUFEnKwIoClLx7pZZ6W2bnhNVlPYpyAsWBgQJrZAyMpHsobvd4ZS0y1DuraQuI
         //CvOD4Nwx6M9Lg3d8ZE4tkEgXPHKa8EHVxxYx8lovoi/uewoYrqD5l68/Me3i1KrZ2F
         j9u4DUMKZqIzVa4y7GaMeAAkhFefDneu7ZICGEjhubY2XcuMSoN2S3rfo3gbkG7LbmT2
         ZVww==
X-Gm-Message-State: ABy/qLYITgMoREqMpSAoVFpeKER6bY4EionKp1aHRjNh82qtp7LVE0JO
        qp8H9KBhOfLA1yBlhI1G+CXhNS867hW0ZrRY4BLGcnqnKOuMZ0+CG6/lMw==
X-Google-Smtp-Source: APBJJlEW+J2BcaEObGsM0GV+ul++EMNkyZYS+iMof648I9QAfUYwLUi1FYd6j1HdUE4S/uPpZrl9DIQlXkSGVeVm4E4=
X-Received: by 2002:a05:620a:8fc2:b0:767:359f:920 with SMTP id
 rj2-20020a05620a8fc200b00767359f0920mr8099758qkn.11.1689463349026; Sat, 15
 Jul 2023 16:22:29 -0700 (PDT)
MIME-Version: 1.0
From:   Tom Isaacson <tom.isaacson@teknique.com>
Date:   Sun, 16 Jul 2023 11:22:20 +1200
Message-ID: <CA+EiEZ+PBLEtQ1bD_TnsstT0jNehAs2CGgYXebEE4aweK=kmgg@mail.gmail.com>
Subject: Parsing git send-email
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to find a way of parsing emails sent by "git send-email".
Does anyone know of any existing solutions?

Thanks.

-- 
Tom Isaacson
