Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BD491F597
	for <e@80x24.org>; Tue, 31 Jul 2018 17:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbeGaTSU (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:18:20 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:51264 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeGaTSU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:18:20 -0400
Received: by mail-ua0-f202.google.com with SMTP id m26-v6so5436165uaq.18
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eexrPfoNnRgXtpQVfGsdmfKeP4DdrpGUVh6O0CSyuKA=;
        b=Cdjq55gzyIC6dijM3QxTcCcyHO/kCoFLqss4vVd7hxcMKaPzWXVXOAZka9z2XRJlkQ
         FuP7rqSnA5h9CYCeAMl9zSTffS7DQj9XKire6EdQU0BMYfPi9bm2evS6F3Jdy8sEKAic
         xNiVf++zY2veoG44FG0sAOJsDMpdvVt7jIOFMQmX5ECVs2Q1ZriI6StYeVpvsqcSXOxg
         rZy0EgkS+weoVP8rBGpvqxXqMkWUIC/ACNsr7UIap91l45/OAt3nwIYL8mrE3VzH0kqr
         QqfyPD4ggpjk1STMDkSq5rso9sgPpBCmVXm2JifZbHVveErxz0DRHKDdVAIAOYG0+gZx
         Bk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eexrPfoNnRgXtpQVfGsdmfKeP4DdrpGUVh6O0CSyuKA=;
        b=KUY/5yW3k6LApgwlVCq1NFmEsbhd+0Scqez64FnbjeGrlqLcJ5Yqqk0jpJ49WD2BUu
         ZOJ6U4ajISthqVVn4tezPO8rUiBP3RdqSKBQA44Gvea+kyFGOaDuFmMOGno++R/HHaHv
         G7Zrvkr/Yq9C2m4r/9clG7Uu3Ko6WXSvHcZ9dc87fGWPECXj//Qqlfm5kZocPX/R5+q1
         OfNxO/gOWAj7jXJrhSxksBmnuBo3uJg1U8awTeg7hJO4vx+BR3Xc4TVTrAwN90KIdAj0
         lPHTM+moYZX+L02x5Zv/87ys0FzvrXEuHx5ouuJyvsKE+rWnrSu+QvKof/9KB0oKEeVR
         iN5Q==
X-Gm-Message-State: AOUpUlHJ/8qrWnzcUEaj43ylSMv17GHbFbAfjWfYxQdzFcUzHod+wb0t
        o4YdGHPSerkYVur27wGdFU51SsHpEfE=
X-Google-Smtp-Source: AAOMgpfouwQ0GnmMNMquZFW5NWfYsEFnLj1egMy9ZiYk8UgzqQ0WInfboNKRzJmMQnNWGike422jrKLLPSM=
X-Received: by 2002:ab0:268b:: with SMTP id t11-v6mr10666117uao.101.1533058618351;
 Tue, 31 Jul 2018 10:36:58 -0700 (PDT)
Date:   Tue, 31 Jul 2018 19:36:49 +0200
Message-Id: <20180731173651.184716-1-hanwen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 0/2 v3] Highlight keywords in remote sideband output.
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

squash in Duy's patch

Han-Wen Nienhuys (2):
  Document git config getter return value.
  Highlight keywords in remote sideband output.

 Documentation/config.txt            |   9 +++
 config.h                            |  10 ++-
 help.c                              |   1 +
 help.h                              |   1 +
 sideband.c                          | 113 +++++++++++++++++++++++++---
 t/t5409-colorize-remote-messages.sh |  47 ++++++++++++
 6 files changed, 170 insertions(+), 11 deletions(-)
 create mode 100644 t/t5409-colorize-remote-messages.sh

--
2.18.0.345.g5c9ce644c3-goog
