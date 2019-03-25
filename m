Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 905F320248
	for <e@80x24.org>; Mon, 25 Mar 2019 20:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfCYUnb (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 16:43:31 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:55360 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfCYUnb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 16:43:31 -0400
Received: by mail-qk1-f201.google.com with SMTP id g25so5135240qkm.22
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=e6uuvLx20eJ1sK5FP1Iop1cO2n1TpZlJu5LeQThesYM=;
        b=d3HGM9UvnW4+dcNiFjbGyX90jF7nQLWvXwxNn6pZyiXU3S5DW5jrnj7GiWwZ+ElJwD
         WyfrOJ3LhS1yOKNMUKFJ6+batSQmUMX/MhzRdbEQOCiqU9wGMPb2rX4Hph7trqqEoOp7
         YIAVSi4IfHTrFJJrk4lHGkemrV0/AnH30fff+YgoN1JHbshdBRESfCqI9l52aOCAVzzm
         MyRQhuXGDgSV0rCgv9j9gEte04lposEcsRUaU86ONxUaIaN5K8b220/2V3vHiT3G032z
         NSqV5ou5J6ypASUXYy0y2TEMITSGEONJPkagHQgFJtZsHGuVZQ6baP6OuBCNNPMaRgrW
         Cj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=e6uuvLx20eJ1sK5FP1Iop1cO2n1TpZlJu5LeQThesYM=;
        b=Vs/vnJct7GKB4Yia3hrOLcPWn5EpZ+gwJ/542SGgE8yuj+tYChnhZTqI2L25d1nm2c
         eSkRAbP2krN57/pVA65ny2ezHU4evNs0gNSiBh3NIaf49gWT6eGpTevqmMKnoENlPPPz
         s6Cvbdb0PwM4/RDi7O9FbUGT6AifLxw2Z4+q9UrgiwlXSzA5qrQ8DNroLtfXY2GU17xf
         TFP9Goep+qERufRhi0O4TTQvtNUIFPFAW9F+iQC8HtiJWX7yIO1QrdGx6GnlZicYFoKM
         Kuzljj9g1/bkhlc10Mn+aGHMhNFG+kuUKHA/xeO56gptNVF0juRfzTfLv7C998LyzVLQ
         soJw==
X-Gm-Message-State: APjAAAVsxFAbaxszWtqVBDhS6z5JV1hlGIGu2eSh8UiVUkW6PspqKlBD
        PVfFlY/78kPMrss/b1hVKkMriTRW3AEmADSqYIWJmttqgd2ATS4PJFsOYGYaIhQUpIKwS6FY6FX
        ZsErYxzjKyVkt4QvfzO2J8Vyp+LwC4FkrZ6XYwHIf+AHeQr1UqQpcoANvw6bTjP4by6zcngzkeV
        /x
X-Google-Smtp-Source: APXvYqwMIPG3JhH1ijDPOuO3oIHUysInmJOCK9Lgo0Ze6YUatsNiXolMxjWV1/gxPbziRtVag8ihWBFJ6Vz+g4B4HOR9
X-Received: by 2002:a0c:b018:: with SMTP id k24mr22586236qvc.218.1553546610448;
 Mon, 25 Mar 2019 13:43:30 -0700 (PDT)
Date:   Mon, 25 Mar 2019 13:43:21 -0700
Message-Id: <cover.1553546216.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: [PATCH 0/2] Last big GIT_TEST_PROTOCOL_VERSION=2 fix, hopefully
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is built on master+jt/test-protocol-version, but should apply
cleanly to master.

After [1] and this patch set, there is only one more small thing to fix
or mark GIT_TEST_PROTOCOL_VERSION=0 at master+jt/test-protocol-version.

This is very similar to [2], which was neither reviewed nor merged,
perhaps because I had another patch [3] that I declared to supersede [2]
and that was merged as bd0b42aed3 ("fetch-pack: do not take shallow lock
unnecessarily", 2019-01-10). But it turns out that [3] was not enough to
make all tests pass with GIT_TEST_PROTOCOL_VERSION=2, hence this patch
set.

[1] https://public-inbox.org/git/20190322190139.151189-1-jonathantanmy@google.com/
[2] https://public-inbox.org/git/20181220195349.92214-1-jonathantanmy@google.com/
[3] https://public-inbox.org/git/20190110193645.34080-1-jonathantanmy@google.com/

Jonathan Tan (2):
  fetch-pack: call prepare_shallow_info only if v0
  fetch-pack: respect --no-update-shallow in v2

 commit.h     |  4 ++++
 fetch-pack.c | 54 +++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 47 insertions(+), 11 deletions(-)

-- 
2.21.0.155.ge902e9bcae.dirty

