Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EC5D1F51C
	for <e@80x24.org>; Tue, 22 May 2018 22:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeEVW1Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 18:27:25 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:42178 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeEVW1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 18:27:24 -0400
Received: by mail-qt0-f202.google.com with SMTP id c4-v6so20515137qtp.9
        for <git@vger.kernel.org>; Tue, 22 May 2018 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=UjpvEaff03PVDm0ZPHXs3ThGhQyXTEX5boLW7BI7/Xg=;
        b=Ee0/30LTrGq47u0Riwrmry7hI5vX5YCww0e1+RZ/K11H6t2xZSspKGetlc+NVU7cRT
         EIiEbgn5RFSIUestMYocjaocgP8h6+Q0+TdJyxyGRebk8q7D0bSeN827OxBoxCt5jC4A
         OGbB7YImm9vGJ8TmxzJ/yhmJ+Z/rCD8gE9K4Dshoy9+xGY2B5bX8iXWU4JpcFjtunQtD
         pb0nBGmADAHvcFtJ4dCLRDO7e1nRv0zTfRu/oPnDyrl/GeG7qt56bELSfhGOpyrcc0Kd
         QXaNU4ZwBReU+RrYd1jjnP2QsXVuxIhW7Z4lHQvE5stTMlLo33TMO8FKNcAqplzr1NK3
         EXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=UjpvEaff03PVDm0ZPHXs3ThGhQyXTEX5boLW7BI7/Xg=;
        b=g/mv/dlD6oCyWEJRz1D24Xz4tbAF1ZRJ8AQyQcXIuhnZVyf90WpxGPLJUB5cQABRoK
         K+mmqYSJ/Kgju5TeXVClkcRc4ik5h200gNsDHYqREqA6zl84PJiya+D7BN6LqWpdc4ga
         SS+Frg1Z19L5zUoZHcRzX0+B4v1VVYXU5cSFuV/772r8g6SYGiaCBBgl3xNclKNVxgn6
         zpHD90F5PNlA+kVcsjU+0sJY2S5V0wZLURAPvpqJJASYAf8sO/Mw0uFtiC8L/tF4B820
         wlf2ywmwy1s0aP/yM5mNjnUPykV0SUzvD+To853tioNEWGoFKFOSK1jH+LOk3Vo5/SFj
         SGtw==
X-Gm-Message-State: ALKqPwdfJ3J+bv1iIfp4mJOxJsJXmJP7+vnUPsBqHanClhhUAEjqF920
        aXDx7rhS6HKIOvNWOB3UQ16s651YDl14mn1bSFYORfLQIolGY4pSlarg5sY8x+h1xzLfUBHqq9m
        U4MWO2k3JTO6X2tKDX0QDAaIfQF+1aI+P53N3x+zDikZTeZSRnkrb1KnreA==
X-Google-Smtp-Source: ADUXVKKXoi9UdPCtOKcDJlxT+d7rxa0eyHmX1Rbg3hTP02CDI4G/InTq42+t8Et7y/JflnSeDuL9NfP59Dg=
MIME-Version: 1.0
X-Received: by 2002:ac8:41cb:: with SMTP id o11-v6mr236258qtm.26.1527028043590;
 Tue, 22 May 2018 15:27:23 -0700 (PDT)
Date:   Tue, 22 May 2018 15:27:18 -0700
Message-Id: <20180522222718.81173-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH] config: document value 2 for protocol.version
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the config documentation to note the value `2` as an acceptable
value for the protocol.version config.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/config.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a05a88fec..ce778883d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2637,6 +2637,8 @@ protocol.version::
 * `1` - the original wire protocol with the addition of a version string
   in the initial response from the server.
 
+* `2` - wire protocol version 2.
+
 --
 
 pull.ff::
-- 
2.17.0.441.gb46fe60e1d-goog

