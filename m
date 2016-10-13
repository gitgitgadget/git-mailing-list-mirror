Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6039120989
	for <e@80x24.org>; Thu, 13 Oct 2016 18:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755082AbcJMSoR (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 14:44:17 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35606 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754927AbcJMSoP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 14:44:15 -0400
Received: by mail-qk0-f172.google.com with SMTP id z190so107816157qkc.2
        for <git@vger.kernel.org>; Thu, 13 Oct 2016 11:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=RS5mLcQ7KoRVl6xxiaFm/JbQZj4iFaAt/4zoXD6eIZY=;
        b=PS/19Jiw1uN/DZcXCqW9IG+KycjBWVxlDft4GbuPAWjSPARdrd1hu9lFrw9sRh5ylr
         XsKvTl/R7hIvorc2ervYDq/eGDJ2Mnw3q0jajNk5mlO5SHqKzTBIzlb7t1AK9B9ULSFI
         4wuF3AUR/Nb+ctQeTkdcj/FRuwYHDtzgxW6U6azIE2xTuK3aC/Ja9SdN6R/ZSb99d4Fu
         bhZHx4TK0SguRoi+9b0iXot7usbDvuOdrmDBX8thLjE5FLqH17/XNSFwv+8X7tmaXS1C
         f1NJpQq+qhV7D/zciAJwSE4maXw28ka9BoaHajI7WIP/u2XBTT+Ckckrl1UVUsRjKzLj
         20yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RS5mLcQ7KoRVl6xxiaFm/JbQZj4iFaAt/4zoXD6eIZY=;
        b=QGhUn5ILNHMpTns8v2EbiHlO8RaJfR61pgXl8E6nhEkkshZuVaUaLTt6yD8741/XXo
         GEqYczp9d5z0Fmh9f4twJ0WEvQpQOADcnrIb3wO+7Xja2z9D64+ZP08U/V3/iTtMenlM
         CHbJ6c8s6rI5aTPCjTIz8Ycbamsh8Q/SBY05KMnofehEv6ksL59qoognEGcISqjlayba
         7aXpfCBjsU1BJduX3O0C/BKehOaVwM4KA54kBkwXdC0rJt4YItvAfwUtSzjkyBir0ObP
         YXKQ2lzND5MDQWYeLGUu5paCCwJFdzpLpnyRQ1Ns4DQQ31eFbOd8/AsxQSEd9Oo4EDzV
         Tw2g==
X-Gm-Message-State: AA6/9RlMgg+ZCzcJhfJcPtIrScFxwTS7LXCf3+UO8XukrO4CGBjHWDvqsoi4l6Vaww9tAw==
X-Received: by 10.194.201.227 with SMTP id kd3mr7886512wjc.74.1476384234619;
        Thu, 13 Oct 2016 11:43:54 -0700 (PDT)
Received: from ashmac.lan (78-83-50-132.spectrumnet.bg. [78.83.50.132])
        by smtp.gmail.com with ESMTPSA id h10sm24564589wje.48.2016.10.13.11.43.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 13 Oct 2016 11:43:53 -0700 (PDT)
From:   Alexander Shopov <ash@kambanaria.org>
To:     git@vger.kernel.org, patthoyts@users.sourceforge.net
Cc:     Alexander Shopov <ash@kambanaria.org>
Subject: [GIT GUI l18n 1/2] git-gui: Mark 'All' in remote.tcl for translation
Date:   Thu, 13 Oct 2016 21:43:48 +0300
Message-Id: <20161013184349.42950-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.10.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 lib/remote.tcl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/remote.tcl b/lib/remote.tcl
index 4e5c784..26af8ae 100644
--- a/lib/remote.tcl
+++ b/lib/remote.tcl
@@ -250,12 +250,12 @@ proc update_all_remotes_menu_entry {} {
 
 			$fetch_m insert end separator
 			$fetch_m insert end command \
-				-label "All" \
+			    -label [mc "All"] \
 				-command fetch_from_all
 
 			$prune_m insert end separator
 			$prune_m insert end command \
-				-label "All" \
+			    -label [mc "All" ]\
 				-command prune_from_all
 		}
 	} else {
-- 
2.10.1

