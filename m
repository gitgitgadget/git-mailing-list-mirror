Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4511F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 10:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbfJJKGn (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 06:06:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37020 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733296AbfJJKGn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 06:06:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id p14so7121505wro.4
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 03:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=DjQcnKFwIGr5bQV7y2PDd9XPvPX70iLAhkYayIGTIx8=;
        b=m4cikf9WJTMUinSO68Pml/Pj8LXudpbckdGmvLa1ah6LJUCWKGP6FarFaN4gguMp1u
         3EB71opbEKnr01ggNFjwg0zHJWjnY79z03ahOGEeGLX7EGWLjOKTmk89bjhfovbCiQXH
         JWCzXVqkU+B4Ocrx0/nkm09L3dTXnC6+sWZxOZkXcOxbPm47HbKUR2wbekIOk9zsoari
         jkChHmzZP/G1BRkqtAynDeiYr4cMvqRjx1xJ/hyqbFDRIlzuweNfm+wYf6tzfPuNknA9
         HqEAWrpy8zywqi2PAZL+hf32PPFb58E6wbca08XGNSonq9TtkuihTc48Ki2F0R1nvnX1
         WO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DjQcnKFwIGr5bQV7y2PDd9XPvPX70iLAhkYayIGTIx8=;
        b=UWI6SU/7WuDp008dkCbk4Tga5ySaUk+Hec/V1ZFDaxpNuVb9dQifZnlvq3LA4/A1KG
         d2KEAqvg/rDm9YbTe84mzvrzSzXCIiSnLMHFY9f7xNxRAp+J2ny/m7D59gZpThNCFe3d
         W9ql3JXKjA/1kyhH7T2RSOVEXFvKTL0SZQdBDjizH1ecciUtvMZH/fPtTFw8KsgAPo9r
         5tC/ohZufXLbFsIy7Nj/jEQI8pUQtdKjpBDIP2omd9YgfhdyNtRUTt7qnV9t/K3z8ACK
         h2hxGfCHWOTpqP5rmJEoMqO8GivVn56UxVMTTaHgSEyHm+uCWySMseCnlVimT0t6zl/8
         Efug==
X-Gm-Message-State: APjAAAVfHT/7kAM+9qcK4rB5CLpXbPPbgXrXpJXgcwrc3ah7iP/GxbJz
        q71SIFIVostrRTKq1GXY0+HeyB3a
X-Google-Smtp-Source: APXvYqz4Rthmkyg5q0RgsCDFFGpo2zgT2Ak/F9J0Ga4yJy62Z/nQc6XI1W8vONoN/oB2vuEPfaPrWw==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr7565182wrq.292.1570702001385;
        Thu, 10 Oct 2019 03:06:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm11513355wra.89.2019.10.10.03.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 03:06:40 -0700 (PDT)
Date:   Thu, 10 Oct 2019 03:06:40 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 10:06:39 GMT
Message-Id: <pull.384.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Make the description of git stash save clearer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an attempt to revive the discussion started in 
https://public-inbox.org/git/0102016b8d597569-c1f6cfdc-cb45-4428-8737-cb1bc30655d8-000000@eu-west-1.amazonses.com/#t

Johannes Schindelin (1):
  doc(stash): clarify the description of `save`

 Documentation/git-stash.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: 70bf0b755af4d1e66da25b7805cac0e481a082e4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-384%2Fdscho%2Fclarify-stash-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-384/dscho/clarify-stash-doc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/384
-- 
gitgitgadget
