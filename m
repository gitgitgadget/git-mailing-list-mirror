Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEA3D202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 12:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbdIUMoS (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 08:44:18 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:50967 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbdIUMoR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 08:44:17 -0400
Received: by mail-wm0-f48.google.com with SMTP id b195so1436733wmb.5
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lia3pwrtHUkr/f5Mfuv1kbwy6mkUL1XtezHhw3Sm4qY=;
        b=Bno95eN2jdu3Y8Dv8vAJ7tDJiqU0M0xwmrWj9V47ID6QqGbx6ezM+k4kugQ4JplTLe
         OEQcic4h8TiMMxB8xWE/UZkmywFtDr7G3/omqEhmigJkYkAJD6dlAjhTx1Q3OUowk2wa
         YHrLBriIL2HrGM/ZtEHgfqGN9m56mc81KczpR1W49yTTB9/Nbu6+4Ari9R2F1VWAt5H2
         wBpiRATnTC+FW8q4h3dTQx/kokbtVR0xhgqVWAsCCFGQUidef9Bs8DhXmjjofPurld/b
         mpU2tx8pc1KTTeQX5nT/pJ4u6bna11fJkg56wjvRVmu4n3igjZJ2slgVLE+MvPioNSL0
         /EXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lia3pwrtHUkr/f5Mfuv1kbwy6mkUL1XtezHhw3Sm4qY=;
        b=oY38INGGI5/j1OKLbcvTfMmKmyk4YwZ7u3etvJGZAtR24J/tEyGusolNifdF6g4Gb5
         u36EN6l0/pPGKxNbnHEmUHBRlFZrESCq9j+JxPNjbwleqbJs6Af9MjjfZBngNruNUxR2
         iCkqahfVAzJK7NoTmeQqwnBdDu0Vb6yEkowi+8y8NtRCelW6GDmvOi2Zkb7EcORjBBSX
         bvv9GR4QTs/vV6KTyjdILhjFCQVNvsQfp0NncUFZGiP+scg60ZvDGXSmxiiY7qTzl0CC
         jPnpP559FoAp2B5dUDn1t8LXCMR6BNYIkVElh8KULmsXTYis+m+KkNoG5q756RB3O8rT
         aQ4w==
X-Gm-Message-State: AHPjjUi06iIkcgUUkWzx99o5xVWKSxGc1HQ3qdAYdPcC9FkxDc1u6ZC7
        B6EulZDEVQgv9h1uHLl7ygGoDk+RBhQ=
X-Google-Smtp-Source: AOwi7QDUrC1xsdNlFljYks6lWs0q8/j8gijdeOly8Fixi6lNWycTlJCwQoF3x6598CkaN0t689TpXg==
X-Received: by 10.28.227.68 with SMTP id a65mr1023720wmh.88.1505997855761;
        Thu, 21 Sep 2017 05:44:15 -0700 (PDT)
Received: from hanwen.roam.corp.google.com ([104.132.61.99])
        by smtp.gmail.com with ESMTPSA id p59sm1494778wrc.75.2017.09.21.05.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 05:44:15 -0700 (PDT)
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, sbeller@google.com
Subject: [PATCH 0/2] Two small comment fixes.
Date:   Thu, 21 Sep 2017 14:43:36 +0200
Message-Id: <20170921124338.26626-1-hanwen@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys (2):
  Fix typo in submodule.h
  Document the string_list structure

 string-list.h | 6 ++++++
 submodule.h   | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

--
2.14.1.821.g8fa685d3b7-goog
