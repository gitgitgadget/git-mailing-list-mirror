Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0722200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 19:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933089AbcL0TgV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 14:36:21 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33688 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755291AbcL0TgU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 14:36:20 -0500
Received: by mail-pg0-f50.google.com with SMTP id g1so108533394pgn.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 11:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iLZAL47JMl8iPBLWM8gRBouaQsPc/8nQwp7jmMfrUPQ=;
        b=N6zR5voidvv+wcIWAU5JB2W+uvQsfBhWS2ItWn1y2qp/Mh9qhGUPV9P4bT620LpL9e
         wwdJwVEZZy2DLfEXicuToAsO7h9fX2a/aYWW6YWvgNSlMDJK2tuQ3/E+KwnWTFGkb8vJ
         4rqXsoHBVW7cRcV8PotysCtryZDrPv3hbO+OiegSw6HL1lYzT8kdXJnE4zbnBIZfO83C
         D5n4HsHNRhOhrF47M6bHnfdkI7er0ORxB4rVJiou+VLJt0Gs+Q6QRbYJW2gatekUaZ5L
         A04dceLKCWFRjtxLm40c5LcimoTh1yC9BdUbKpx2TSbAtqcM/kz8vEanwRWntr5VznqL
         OgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iLZAL47JMl8iPBLWM8gRBouaQsPc/8nQwp7jmMfrUPQ=;
        b=hzIStCvqRhM9pn8IorR0pmFtHPCRaAZssvgw/Gh/3EczlANLDfpmaAbVBAODVM3l49
         6frwWMIzf/MxfPQhw9XDweCgf4x+/iMek/6+hqQVUz2zVjd1/qtlYYekuK5cE88k4NuV
         3BOgQnaxM9qTrzBD5OGQlOOmt85nx0I7bOU9aJlbIiOGOLkSOX+imI6H3MWU4rWA6IT2
         bvKUemPBPPdFjIwQuJUaeGQPAL0IcrLtsDoxIZXaf62oGLzeh/ld8jZVDibsglIPPUo6
         SbkDEcE8DZmXFkS1h0OGfGMHvJHJhy0uBMzcj6ML+ELpR/3zab4fIE/5CW9TSC9tHoHn
         O+dw==
X-Gm-Message-State: AIkVDXLNKC/OeyxaKaWjZYExejbM97vWUZPFHvcqfBU/HCR8PMNgAJG8rtRfZf04OppxqncX
X-Received: by 10.99.237.17 with SMTP id d17mr60732184pgi.48.1482867379269;
        Tue, 27 Dec 2016 11:36:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:1aa:810:98b9:be05])
        by smtp.gmail.com with ESMTPSA id y2sm91432321pff.82.2016.12.27.11.36.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Dec 2016 11:36:18 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] submodule config test cleanup
Date:   Tue, 27 Dec 2016 11:36:03 -0800
Message-Id: <20161227193605.12413-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.50.g8bda6b2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A test cleanup and an additional test for the submodule configuration.

Stefan Beller (2):
  t7411: quote URLs
  t7411: test lookup of uninitialized submodules

 t/t7411-submodule-config.sh | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

-- 
2.11.0.rc2.50.g8bda6b2.dirty

