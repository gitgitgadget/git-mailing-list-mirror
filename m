Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC8920292
	for <e@80x24.org>; Tue, 18 Jul 2017 03:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbdGRD1A (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 23:27:00 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36828 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdGRD07 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 23:26:59 -0400
Received: by mail-pg0-f66.google.com with SMTP id y129so1086682pgy.3
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 20:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=atuT0VvNxjskyN78T0Ielsomys80as5eaZVZq8usdu8=;
        b=l2Gpq5HRP1gV69yQ4EOg66z9emXYrZpHCWZWZI8yxHdunkAO3BD5pBKGh8FNa0CpTP
         bltONTrdn/2Qfc2+TqCv7+/OSzGSxyZ9l9+QCtxKCWLq53uUymdLKwBfV2z6kJW/maRb
         DL10qrdodmvsQOAutYcw61fwRjj1704MYZV9SqUotE2b7lVUbfyakYoUWEu1PahOvwsm
         y/9e9ad+WhXOuFTvbRmib469pUMd5oqzBQAiPEm9BJoh+OAoGFyuhVdg1iuf1xqEf6i9
         9wbrUjC81AxXBxAxR1dtMoMirgYxQO6swzarnWAKxHRH0xIrHtk32U8j6o0B6jl1yVtW
         m5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=atuT0VvNxjskyN78T0Ielsomys80as5eaZVZq8usdu8=;
        b=q1YbbQ+5ctGknfHR/nTPQexpKJspVo5EJ/VYFCpw7Gzy41FTJREUni+wMOgjA96vWl
         nDMf6UIK5lI1Lz+JCB0y6xLQdUflnuWdSkPIzUVNabIw2jvDo1R3kyA1hnyxNMMIyQge
         TPSEhcXt0AehkTgFKyjfng40/JWWzGX8sAJeboRgER6SUl7/7U5ir407NGs4FehCjkV4
         zo5uvk4f90ftON7lQB54KC9DSCkPTfsS95XqLpx+c0361Qjc5j1O2isXQgqPiZN3Paj3
         pNeY4iPcVmRUjbCg3A4IGIm2o5I39mp3we8RlSu6g8IgOnoZVbVkSQISHq6KXDBkwWS6
         zwGg==
X-Gm-Message-State: AIVw110fQ7TMX4+rgbCj8oEeSbwiWyB4ZUZ1g7Hguiy9qm7UZfABoI2l
        ObxXKhfCbrIFzg==
X-Received: by 10.99.119.194 with SMTP id s185mr831854pgc.256.1500348419230;
        Mon, 17 Jul 2017 20:26:59 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id z6sm1145742pge.20.2017.07.17.20.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 20:26:58 -0700 (PDT)
Message-ID: <1500348436.3691.2.camel@gmail.com>
Subject: Re: [L10N] Kickoff of translation for Git 2.14.0 round 1
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     worldhello.net@gmail.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Tue, 18 Jul 2017 08:57:16 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

As a heads up (and because I have been pulled into this thread :)), I
wanted to bring to the notice of translators that the commit,

b884244c8 commit-template: remove outdated notice about explicit paths

*removes* a message ("Explicit paths specified without -i or -o;
assuming --only paths...") that's currently being translated.

-- 
Kaartic
