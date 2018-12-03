Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4C5211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 23:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLCXhu (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 18:37:50 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:37003 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbeLCXht (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 18:37:49 -0500
Received: by mail-qk1-f201.google.com with SMTP id s70so14945884qks.4
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 15:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BWwIOsLIF6mT399MbObuVLAM3Rq4NxNZHzPahQc6trM=;
        b=dcvhxUljjl1hskd3LhoUGEV6G1CvTE5JTurpLsQQrSU7RLFv6d0xGl5T/Icy8jDQ4a
         gHdrMbvj+PImbg92OFUdEAxzFgFRTP6qDYhX9fZzXxQAdIhtpjZ0A7MGvXoCwHLKB7P2
         6dvsw4/1Yino3phbvdcvTnGIfNzb8BSY53/c2VD/RvJNxR+jH6xN1k9AQSi8GKpqc9kR
         jk7Fxq4isXyAkNGBcwoJ44sQ0g4Budms4+sx8WgD719R4CZDF29inJsJOvBM1mKCBgd3
         EgDgusxigjg2gHUC0GmdN4qzqlseiWqlgX+Aokz6RaCk0XFZl3pN5UQZyWAYrind+Q66
         RewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BWwIOsLIF6mT399MbObuVLAM3Rq4NxNZHzPahQc6trM=;
        b=NbYKJSJK8QCHsj7pndeG5wSGHgNNFzzAhIH7nTMe7y5jEAVd/vaPyWWluzZ/ZwXVQS
         Np4r/QyWhof8wgs5x4QFWSlEcJPVTzYNffzJIk+MMVwE5YZhaRrV55IHu1mBLUdpg073
         mNgjzT8zdzsaaea1MV3N4t+x/2toSbQMU1Fy7rOC7eU3J/9MOGhPk2PsSal1j09LK6r7
         n3II2JPwvCbyfq08UfYCsidC7xFmj8gU9dsmDdlh6IHyrUMOaa1pth2EZ0lq6vcyWZUe
         HA3rB8x/Qhbz9LAYENCOGEYyM1+LMVZRsl/vvXZTFTdiI6BcXFZgNqs4+iLUT/FRWrpS
         grsg==
X-Gm-Message-State: AA+aEWbQwoVezOYUd/X48EVPWyiM+LS8fd/ew2VsmBPLVQfQvukmMMgC
        8ePUkvK4ADzmPCIv/ZqPib+bkgf+gpiRw+2/wZ5QowtEoRbpe3yiE7ULV5XJ/3AQrsiN09XoGH8
        zs2HYaygKroNcNbbz7d9sc+o+QUwfPLaC0b01pLkWgnKX513TS+UAorpdue/Ax67KsjOh9iiwlw
        Ry
X-Google-Smtp-Source: AFSGD/VLeyacCCDhExkhXm9UyhApzslj7r9pUo/ILe0BgbwnGOH2Ab0Ag0VHdbANUoJK0H/iWxpPfc5+iGvBPfsAq3Fy
X-Received: by 2002:a37:d448:: with SMTP id l69mr13545110qki.21.1543880268319;
 Mon, 03 Dec 2018 15:37:48 -0800 (PST)
Date:   Mon,  3 Dec 2018 15:37:35 -0800
In-Reply-To: <cover.1543879256.git.jonathantanmy@google.com>
Message-Id: <0461b362569362c6d0e73951469c547a03a1b59d.1543879256.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1543879256.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/technical/packfile-uri.txt | 83 ++++++++++++++++++++++++
 Documentation/technical/protocol-v2.txt  |  6 +-
 2 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/technical/packfile-uri.txt

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
new file mode 100644
index 0000000000..6535801486
--- /dev/null
+++ b/Documentation/technical/packfile-uri.txt
@@ -0,0 +1,83 @@
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
+If the client replies with the following arguments:
+
+ * packfile-uris
+ * thin-pack
+ * ofs-delta
+
+when the server sends the packfile, it MAY send a `packfile-uris` section
+directly before the `packfile` section (right after `wanted-refs` if it is
+sent) containing HTTP(S) URIs. See protocol-v2.txt for the documentation of
+this section.
+
+Clients then should understand that the returned packfile could be incomplete,
+and that it needs to download all the given URIs before the fetch or clone is
+complete. Each URI should point to a Git packfile (which may be a thin pack and
+which may contain offset deltas).
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
index 345c00e08c..2cb1c41742 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -313,7 +313,8 @@ header. Most sections are sent only when the packfile is sent.
 
     output = acknowledgements flush-pkt |
 	     [acknowledgments delim-pkt] [shallow-info delim-pkt]
-	     [wanted-refs delim-pkt] packfile flush-pkt
+	     [wanted-refs delim-pkt] [packfile-uris delim-pkt]
+	     packfile flush-pkt
 
     acknowledgments = PKT-LINE("acknowledgments" LF)
 		      (nak | *ack)
@@ -331,6 +332,9 @@ header. Most sections are sent only when the packfile is sent.
 		  *PKT-LINE(wanted-ref LF)
     wanted-ref = obj-id SP refname
 
+    packfile-uris = PKT-LINE("packfile-uris" LF) *packfile-uri
+    packfile-uri = PKT-LINE("uri" SP *%x20-ff LF)
+
     packfile = PKT-LINE("packfile" LF)
 	       *PKT-LINE(%x01-03 *%x00-ff)
 
-- 
2.19.0.271.gfe8321ec05.dirty

