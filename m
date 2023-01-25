Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6BBC27C76
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 18:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbjAYSRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 13:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbjAYSRM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 13:17:12 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41A03668B
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 10:17:10 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q10so991429wrm.4
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 10:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uZ3IEIMypfWwqyhk8gvyB5tms3nj7My71VAht9Et2DQ=;
        b=FCdU1vrS65Htq8EMyrTLjmVQ4dJ4MjinvihME/gGOaNy6KR2KxRRguuLC6HPuaDPNJ
         LD7Gpg7OfnMMS9jb9MGOKVebINYv/mikTkWxSRqEcxjpiu9f8EvbPXPOG5/RMGQHqB1z
         2AiWzGZknDcxA5HRH+noD2nHPgsBYgGfFAot998oeHt675RjXphfm4JynCdMCKqTgcwn
         cOzbRWYgUvrYgRU/9KRhojTaQ2oJqs2QN2B39AE5p/EDBolYK0dTNfdZG/SWsRVweZbJ
         LnKa6TCPl9GnP854n0FeyLHaxysaaVufQhEx7gY2T60PBIQNANDERtmLBvYa3sTw+UjO
         D+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZ3IEIMypfWwqyhk8gvyB5tms3nj7My71VAht9Et2DQ=;
        b=QYXV+tJ3KnFTTn3DJaV1OPXLMu0xVp4wFzwJDmbgvnRaRxlgtJFU27GfcvdF0GhWrL
         g6sqqcWQznyjscNE8h6wnTviyzlBBp+aw0R56c4Si68ZAtif9Dr03WNLOCzgvc4H9fZo
         U47Rx0/30RRXQc7ANXC0lGIDibfGZUnTmVthXtjdvpY0W4IKR/VYQXiYiHV9W/R8I1C6
         eHJEo13hfYI5idGR545bFKHkTbhTUplIAIumq0+SJI8oOjP7ly3vBk/nx8gAc8aJqp9P
         7P03lEVwNbzB45RS7bg72Jg0HnAXvEG4PwGUgYD/PMhMb8wKjS1VT5j6dodqdjWyb95c
         3Mzg==
X-Gm-Message-State: AFqh2krDkopBT8/R2YbkvPFHpGMQc4EbW9SzHc4YG7E0CvfoQNcX7i2d
        6ou9OTF9JE4SNM/NiM3issQphi6Ihjk=
X-Google-Smtp-Source: AMrXdXvzJ1PopTX8TAze89dv2v90V95K6RKReg7ddQ/lrxNfymAu8mCy3GvDmmdOTKflaaJ2qmwa6w==
X-Received: by 2002:adf:e195:0:b0:2bd:d26c:ccc4 with SMTP id az21-20020adfe195000000b002bdd26cccc4mr35594104wrb.42.1674670629219;
        Wed, 25 Jan 2023 10:17:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3-20020adff943000000b002bfae43109fsm4917523wrr.93.2023.01.25.10.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 10:17:08 -0800 (PST)
Message-Id: <pull.1442.git.git.1674670628292.gitgitgadget@gmail.com>
From:   "Paolo Benvenuto via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Jan 2023 18:17:07 +0000
Subject: [PATCH] fix italian expression
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paolo Benvenuto <paolobenve@gmail.com>,
        Paolo Benvenuto <paolobenve@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paolo Benvenuto <paolobenve@gmail.com>

In italian "aggiornato rispetto a" means "ahead of".

"Up to date with something" is to be translated
"aggiornato a qualcosa".

Signed-off-by: Paolo Benvenuto <paolobenve@gmail.com>
---
    fix italian expression
    
    In italian "aggiornato rispetto a" means "ahead of".
    
    "Up to date with something" is to be translated "aggiornato a qualcosa".
    
    Signed-off-by: Paolo Benvenuto paolobenve@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1442%2Fpaolobenve%2Fpaolobenve-italian-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1442/paolobenve/paolobenve-italian-fix-v1
Pull-Request: https://github.com/git/git/pull/1442

 po/it.po | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/po/it.po b/po/it.po
index c31560834d8..47a0ab0f8bf 100644
--- a/po/it.po
+++ b/po/it.po
@@ -6545,7 +6545,7 @@ msgstr "  (usa \"git branch --unset-upstream\" per correggere la situazione)\n"
 #: remote.c:2105
 #, c-format
 msgid "Your branch is up to date with '%s'.\n"
-msgstr "Il tuo branch è aggiornato rispetto a '%s'.\n"
+msgstr "Il tuo branch è aggiornato a '%s'.\n"
 
 #: remote.c:2109
 #, c-format
@@ -24606,7 +24606,7 @@ msgstr "Impossibile trovare un commit comune con $pretty_name"
 #: git-merge-octopus.sh:77
 #, sh-format
 msgid "Already up to date with $pretty_name"
-msgstr "Già aggiornato rispetto a $pretty_name"
+msgstr "Già aggiornato a $pretty_name"
 
 #: git-merge-octopus.sh:89
 #, sh-format

base-commit: 5dec958dcf965fc75e0f459f8e8ccf9c9f495b15
-- 
gitgitgadget
