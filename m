From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 15/16] Documentation/technical/pack-protocol: Mention http as possible protocol
Date: Mon,  1 Jun 2015 17:02:17 -0700
Message-ID: <1433203338-27493-16-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:04:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfq-0000kR-OY
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbbFBADQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:03:16 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37056 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbbFBACz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:55 -0400
Received: by igbsb11 with SMTP id sb11so74956483igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ssZrWoL5BpZUT0KhxasPEh+++Nqh6fb5+X58K+CeMek=;
        b=E6RK/Keutm5jsHnhlBIJTtRvkEzz7drivDoJfuWXodZZOalQ8liI23ok3XO4vMUrbh
         vdaCwN1ZKCHlnCCs9z4iwSpDHZzr52rj2eASGrQHTM7yDiKzphGKOImDbCwV+9dZOFip
         MlJmdKQr8rGk2IHyc0DA1oH0Pzu+TEIREVCxppMHqdzyldTtbWivwzOCDLvExieQVCzH
         ot4JC5A+RAtsrnV811d7gli+ZHjb/txvZwbqriUfhqKqL6oyYA7hAg0keZxwTPNosc2h
         BjOYdYwzFy4apV6V/thUIH4S1p6cSUr5qwGhpqE1a6lrqzjAJVupV0BRyVvhe5NuiSi0
         brmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ssZrWoL5BpZUT0KhxasPEh+++Nqh6fb5+X58K+CeMek=;
        b=Sg2lGtupkt4vnMPqw+MyaKdOT5yOml/xigIwGoWuni/8/EwPWHXSpIYsrsE4DpW2CT
         j3LmJ6lXBfSH0i4JlKJ43We8xRjEM27se5lfNlZnDqGeItFiJN9kShB+4HFsIOUL7JjN
         eDwFBTNT+yZiUHq9Bcp6gPL1y6SMWDLbzQ9cWJ5K/yXRSoE1OiNEjtTDclV7C4+akGNR
         r9Wr3QqHus7gZEeGOWMy/yZtEtxqtSRqB2c6fnRAXrst/ecEDpX5cDA1ShCflCR4qPU6
         rvAr2+lYmVKp/pgknk3Cse4ucb3S7+4HHBWwKt4bMd6BPd5WczQU12EUDEwXnpjNv3nk
         9NCQ==
X-Gm-Message-State: ALoCoQngv1wYhRgHr+Gh7PVwOEocOLbyK4r8YFLUCFYGMZoq2NZORoqdlQremZhQLiW5BsYZv2xO
X-Received: by 10.42.15.20 with SMTP id j20mr31743600ica.16.1433203373095;
        Mon, 01 Jun 2015 17:02:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id h138sm11492341ioe.2.2015.06.01.17.02.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:52 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270484>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This may go unrelated to this series as well.

 Documentation/technical/pack-protocol.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index fc09c63..4064fc7 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -1,11 +1,11 @@
 Packfile transfer protocols
 ===========================
 
-Git supports transferring data in packfiles over the ssh://, git:// and
+Git supports transferring data in packfiles over the ssh://, git://, http:// and
 file:// transports.  There exist two sets of protocols, one for pushing
 data from a client to a server and another for fetching data from a
-server to a client.  All three transports (ssh, git, file) use the same
-protocol to transfer data.
+server to a client.  The three transports (ssh, git, file) use the same
+protocol to transfer data. http is documented in http-protocol.txt.
 
 The processes invoked in the canonical Git implementation are 'upload-pack'
 on the server side and 'fetch-pack' on the client side for fetching data;
-- 
2.4.1.345.gab207b6.dirty
