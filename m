Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9772620248
	for <e@80x24.org>; Sat, 23 Feb 2019 23:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfBWXjS (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 18:39:18 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:38849 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfBWXjR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 18:39:17 -0500
Received: by mail-it1-f201.google.com with SMTP id r136so5452210ith.3
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 15:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S8rsRG253FiyHhRqr1XywDsN5sN75U3Ea+uBHZUYlhw=;
        b=o0tbI1wNaG1VOplL49QY7UjLT/t8QZWCg5uVRU7YCgTB2xSSE/jQqwzbY/WPjbfyaj
         5L3NC1BYJFFVzxFLJvG60PBDVgXHr67S5fYA8GC3XVktAL6TilHX1v6KUseqdDa2XDnT
         22tPaKrnO3tRM7+bOExQICZat4A5U3fTIEs8RWMChUjFxL1PSm0iHnuB0vbiS475VR3A
         MVVvcZBdLwXj/SlN9EF0umYeWg+Lfiyeh4ZJXXaejoL+Ga9nQYmTs19DkbAinuFGHUMB
         1dhCBnvcb4mzmsUvEdK0j/ZUy3/UsYhg0xELM8cxC2jUvpeXZpU2WhLeFB26PLucAC30
         uFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S8rsRG253FiyHhRqr1XywDsN5sN75U3Ea+uBHZUYlhw=;
        b=RGT5yEJKfsoP+WIRmQJkrILup0/x4MSAG+WNMi07Z6kBLgQgvwrN+gHgXRBhxIivUE
         1h9QC5uI4KXIfCA4gxxBs65KpAcQnruDg6t444aHgT5ivFj+22n9SVOXlMGGGstmEx1F
         3SB/iVTk9gRvfvVbIeF5R4B0BSnn84DI80rqlNFuOLa98f6bKlw1FZuHl1Y5YQMW183k
         44kchuotSm/bdEDVovsLZdP3+sNM0SZB2FR+pR5NUASBEbAwgWYNI6lKJ/dKIrJe/ayn
         VhU+HNx9bLA5G61Gbv+aaOAqdhr4coFd8F9mffkx/9RyvXb5KjFMlik5SlGWwc0TyM66
         S4aA==
X-Gm-Message-State: AHQUAuZQcQXS4GwSn1t9YcTKr8G6XVJRaiqRXU8qief/tdwSXADexzEm
        /iLDLKkmx/3dtrad7qQe94seh/r4o/xEwiDK6vtvZDYJNzHfV9Km0uzl9Aj+HMPPStCMAL8n4ts
        SRThBTUUhJHbCzHMn5J1w4/6sBlci1WOIQA3pzSmtboUStxLCAJoiQp6j1jZ2HvQRBgE0KDPcii
        8f
X-Google-Smtp-Source: AHgI3IYAZFcN1jEfjvU1xxlc/Cl2QuNN8ZQqM73+ZeTLApOoMYlBpO8P+xRUpYRBHIVb8yEzt7VUId5hBvqbmy/AdMBX
X-Received: by 2002:a24:330e:: with SMTP id k14mr3458607itk.39.1550965156530;
 Sat, 23 Feb 2019 15:39:16 -0800 (PST)
Date:   Sat, 23 Feb 2019 15:38:59 -0800
In-Reply-To: <cover.1550963965.git.jonathantanmy@google.com>
Message-Id: <84fa3f27a8061ec3e53a935374fbf701f40b6584.1550963965.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 5/7] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/packfile-uri.txt | 79 ++++++++++++++++++++++++
 Documentation/technical/protocol-v2.txt  |  6 +-
 2 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/technical/packfile-uri.txt

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
new file mode 100644
index 0000000000..97047dd1d2
--- /dev/null
+++ b/Documentation/technical/packfile-uri.txt
@@ -0,0 +1,79 @@
+Packfile URIs
+=============
+
+This feature allows servers to serve part of their packfile response as URIs.
+This allows server designs that improve scalability in bandwidth and CPU usage
+(for example, by serving some data through a CDN), and (in the future) provides
+some measure of resumability to clients.
+
+This feature is available only in protocol version 2.
+
+Protocol
+--------
+
+The server advertises `packfile-uris`.
+
+If the client then communicates which protocols (HTTPS, etc.) it supports with
+a `packfile-uris` argument, the server MAY send a `packfile-uris` section
+directly before the `packfile` section (right after `wanted-refs` if it is
+sent) containing URIs of any of the given protocols. The URIs point to
+packfiles that use only features that the client has declared that it supports
+(e.g. ofs-delta and thin-pack). See protocol-v2.txt for the documentation of
+this section.
+
+Clients then should understand that the returned packfile could be incomplete,
+and that it needs to download all the given URIs before the fetch or clone is
+complete.
+
+Server design
+-------------
+
+The server can be trivially made compatible with the proposed protocol by
+having it advertise `packfile-uris`, tolerating the client sending
+`packfile-uris`, and never sending any `packfile-uris` section. But we should
+include some sort of non-trivial implementation in the Minimum Viable Product,
+at least so that we can test the client.
+
+This is the implementation: a feature, marked experimental, that allows the
+server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
+<uri>` entries. Whenever the list of objects to be sent is assembled, a blob
+with the given sha1 can be replaced by the given URI. This allows, for example,
+servers to delegate serving of large blobs to CDNs.
+
+Client design
+-------------
+
+While fetching, the client needs to remember the list of URIs and cannot
+declare that the fetch is complete until all URIs have been downloaded as
+packfiles.
+
+The division of work (initial fetch + additional URIs) introduces convenient
+points for resumption of an interrupted clone - such resumption can be done
+after the Minimum Viable Product (see "Future work").
+
+The client can inhibit this feature (i.e. refrain from sending the
+`packfile-urls` parameter) by passing --no-packfile-urls to `git fetch`.
+
+Future work
+-----------
+
+The protocol design allows some evolution of the server and client without any
+need for protocol changes, so only a small-scoped design is included here to
+form the MVP. For example, the following can be done:
+
+ * On the server, a long-running process that takes in entire requests and
+   outputs a list of URIs and the corresponding inclusion and exclusion sets of
+   objects. This allows, e.g., signed URIs to be used and packfiles for common
+   requests to be cached.
+ * On the client, resumption of clone. If a clone is interrupted, information
+   could be recorded in the repository's config and a "clone-resume" command
+   can resume the clone in progress. (Resumption of subsequent fetches is more
+   difficult because that must deal with the user wanting to use the repository
+   even after the fetch was interrupted.)
+
+There are some possible features that will require a change in protocol:
+
+ * Additional HTTP headers (e.g. authentication)
+ * Byte range support
+ * Different file formats referenced by URIs (e.g. raw object)
+
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 36239ec7e9..edb85c059b 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -329,7 +329,8 @@ header. Most sections are sent only when the packfile is sent.
 
     output = acknowledgements flush-pkt |
 	     [acknowledgments delim-pkt] [shallow-info delim-pkt]
-	     [wanted-refs delim-pkt] packfile flush-pkt
+	     [wanted-refs delim-pkt] [packfile-uris delim-pkt]
+	     packfile flush-pkt
 
     acknowledgments = PKT-LINE("acknowledgments" LF)
 		      (nak | *ack)
@@ -347,6 +348,9 @@ header. Most sections are sent only when the packfile is sent.
 		  *PKT-LINE(wanted-ref LF)
     wanted-ref = obj-id SP refname
 
+    packfile-uris = PKT-LINE("packfile-uris" LF) *packfile-uri
+    packfile-uri = PKT-LINE("uri" SP *%x20-ff LF)
+
     packfile = PKT-LINE("packfile" LF)
 	       *PKT-LINE(%x01-03 *%x00-ff)
 
-- 
2.19.0.271.gfe8321ec05.dirty

