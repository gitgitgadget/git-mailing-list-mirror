Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79FCB202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 01:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbdJTBLy (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 21:11:54 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:44666 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbdJTBLx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 21:11:53 -0400
Received: by mail-pf0-f173.google.com with SMTP id x7so8581054pfa.1
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 18:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id;
        bh=VZQeLKBDX4eduF8ThM0N21pkztT1m4d6a7YokDMqHac=;
        b=URlzCeTUTIXB80jq7JR4Kw90JKL5r9UZGW8ys34bjOe72o12eFdr7WoMZDqWtTG4qL
         aKBHh2icemivkU5ickVpNyu0H//CH6Zwmz2DWdweM2s6n4lMuirUC36M8hN5tRhxvTOS
         mmYRQczQEa3UFVMsDalxCD5G79j/YmTnTatfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VZQeLKBDX4eduF8ThM0N21pkztT1m4d6a7YokDMqHac=;
        b=NILYjekPGvmRuFiB2WRr2uertJvGH5UQ6GEULQpX4C6g2SXOc5AroxAvgJQX3W1HRu
         oMU0sPwisv0jbQrIrx1iTqRFcC8P1NCw2mU1ZLowgFxPZINabMIME3ZKIGDj4dyeqXyo
         SrVY6xybhou0HOxAXw2w8MscfOT87Hiv2lUhVww1haCadnPtQY7kLTRMUKUSG1wjWrMK
         1ZUIWgPST0+GbsKVvW/EPb9v8AS0+Box4uSieGsKstkrqemywqkYyPQTVeEBWV9KKtlr
         Q1rAQd55X7gVzsk+5VsJP5SIy1Q13OKDtDTN6TPIiLUNxgDty0MDNccfEpF2Ho0Hfz7j
         d4uQ==
X-Gm-Message-State: AMCzsaXAU0ZKNvn+v3D+vGKxVW/Vhhmby1beuG8jYAlLGxYQji0LNg6U
        68WC4yxjTU6ZBAlsy3Qo1GI2LDzar7k=
X-Google-Smtp-Source: ABhQp+RLlnZNanaAcbPOTmv3jFd+eYs3RiRR/O+51eqYKOJ3+GimSXQ+OqzO9JxTTFDObAs5Dr1TVA==
X-Received: by 10.159.218.142 with SMTP id w14mr2926324plp.310.1508461912581;
        Thu, 19 Oct 2017 18:11:52 -0700 (PDT)
Received: from alexmv-linux.corp.dropbox.com (V160-vrrp.corp.dropbox.com. [205.189.0.161])
        by smtp.gmail.com with ESMTPSA id x19sm403583pgc.60.2017.10.19.18.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 18:11:51 -0700 (PDT)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Ben Peart <peartben@gmail.com>
Subject: [PATCH 0/4] fsmonitor fixes
Date:   Thu, 19 Oct 2017 18:11:32 -0700
Message-Id: <20171020011136.14170-1-alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.0.rc1.417.g05670bb6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few fixes found from playing around with the fsmonitor branch in
next.
 - Alex

