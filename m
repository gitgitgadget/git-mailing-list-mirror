Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC2F7211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfAKWSw (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:18:52 -0500
Received: from mail-vs1-f73.google.com ([209.85.217.73]:35409 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfAKWSw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:18:52 -0500
Received: by mail-vs1-f73.google.com with SMTP id w206so6974898vsc.2
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 14:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2tCSrD+5toMh2iFm7DXOsPJNOV8SzEwoo0+gn/L2xdY=;
        b=Cjbdva/GIWFpPIOW2FjJ2eD4V4XnkcnVKwY/WeZgjmyUxlxWNISRHpIpvY3+J122WL
         fY8IE/XPLjMAJmG5nK+tN4yXq0D2eA7psvcGG2XhXRH9agY9w4MAF/++aXq9kGuzp0XO
         m9GidcSMvaR2q1JcJHLJnp+PawDh4PXjoJ28suKogHthXNQGCxSqoRKWrTAOMwwvIsqX
         Rf2nHFl3OjS7LsqU6JyeD5DkhpNmibz8zkdlss7Y8sW3HujXBJb9b3es/YUi0+PPw2aV
         rWZWGM8Y3jLIBAJyi1xvSmDfNuidANpVo1s9H4CtspaFWLDSwLS+PpIdth9bPyG/1euD
         7WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2tCSrD+5toMh2iFm7DXOsPJNOV8SzEwoo0+gn/L2xdY=;
        b=ku18Fh8r0JYgNslOy9mIo2LOg6lTG6n4ta8MuLxKWzXiIHFeHwML+CdVTv09x4VS0l
         r7SifMP/ORNpGPjKasNursKAxV7EgsxnVfIUiHA8vYZqsDNT3S60YfGShTCg/UGUn85m
         a9kjkGsvCzAUKOsr+3ggsZt6OVm14RXoRfcOSiL8+7xEzNvaQsAH2Qxi1gQoWXoBAljR
         2sPW+iat0JkAz7j0WheijZmifx+q/83V4rmO4vUM9eRHcV7pX2jw0pWcPuS4b8IUuDSF
         TypxW9KRZ0GPf+kj5G4I8q29Gd6ouNYJkxePpCEo8EtE9mNX19KmzIyUi+gsQjMtC1kg
         HlUg==
X-Gm-Message-State: AJcUukeeyiXDnu2FQcDKwRJcbK6fmrSwvAV24lzFxXrmBCeeC+qUgyzn
        VSABAOJhmLUkJi3euhR49SOS2SbY9+N1+yWWE12B/lclBPbpv7T7cj4fgyRhiONmk/7Td3hPey7
        L0fHGDDdBPvXWy5HHOYxT4EmTLAVQ7yqmyNLVkfAkdy/z4quJmZPypFZj8BVSI4Jb1ajC/THJFS
        IM
X-Google-Smtp-Source: ALg8bN7VZN1Bi2g3Yz7xHL+N0lIauVUe/SUuQuo03C42zRsEWL3Sbp7RHz6yFN9ohu/OlxQYlKmVWM1QGuTa1e9FeLRX
X-Received: by 2002:a67:3e58:: with SMTP id l85mr1730800vsa.14.1547245131001;
 Fri, 11 Jan 2019 14:18:51 -0800 (PST)
Date:   Fri, 11 Jan 2019 14:18:19 -0800
In-Reply-To: <cover.1547244620.git.jonathantanmy@google.com>
Message-Id: <e621cd3fb84a8d6865b5d8fe7f14e253a62af936.1547244620.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547244620.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 6/4] Documentation: add Packfile URIs design doc
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
index c76f2311c2..de5c63bc9b 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -323,7 +323,8 @@ header. Most sections are sent only when the packfile is sent.
 
     output = acknowledgements flush-pkt |
 	     [acknowledgments delim-pkt] [shallow-info delim-pkt]
-	     [wanted-refs delim-pkt] packfile flush-pkt
+	     [wanted-refs delim-pkt] [packfile-uris delim-pkt]
+	     packfile flush-pkt
 
     acknowledgments = PKT-LINE("acknowledgments" LF)
 		      (nak | *ack)
@@ -341,6 +342,9 @@ header. Most sections are sent only when the packfile is sent.
 		  *PKT-LINE(wanted-ref LF)
     wanted-ref = obj-id SP refname
 
+    packfile-uris = PKT-LINE("packfile-uris" LF) *packfile-uri
+    packfile-uri = PKT-LINE("uri" SP *%x20-ff LF)
+
     packfile = PKT-LINE("packfile" LF)
 	       *PKT-LINE(%x01-03 *%x00-ff)
 
-- 
2.19.0.271.gfe8321ec05.dirty

