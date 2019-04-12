Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB86C20248
	for <e@80x24.org>; Fri, 12 Apr 2019 19:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfDLTvd (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 15:51:33 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:38510 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfDLTvb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 15:51:31 -0400
Received: by mail-yw1-f74.google.com with SMTP id i203so7754445ywa.5
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YzjnCYhoqUX4sZpUu0U/9KO2xhZTR6i6LWSZV+BVRfc=;
        b=VSjmb/LGIlIb4IwozypbC5fQ98lL42Bk9moV9R36Jfx+H3Fq+yM4Ny/cG48Ks6KyIm
         eQEpYZJ8xD1s/5tD0N+fnh4dK9LDPMmqaoX/pXfvpGwIqp13MxeMlEpb9B5bAVSS0E6B
         LxQ98lJ8pCWNnxINkdV0CLl7uSqMqxCwH4OKupH179soGX+2C6eKoMtXnYx4rnwhf8ZW
         5C5lgdDS5KIp6MxbEBsjj7bWe0LxPH0rup6HaT73InDyidybvDSSQe27KklHjcAoAIUZ
         zoRrNHf5lfNpVrXKN6W1vGnAbUpcAWvxW7rGRJpsLpK55/MihqwOEFedrjsXwV1DwaNh
         Z3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YzjnCYhoqUX4sZpUu0U/9KO2xhZTR6i6LWSZV+BVRfc=;
        b=U7CAd5u95bZHqgtIxWj4j0UYaBJil2IQ8srUgtxVWEXqoKFmlFk5qCO3PzDK+FjpV5
         gegMzO6FtIKY5POcw54iocQCaF5o3++69XrW2o+QzZu8WWukUckRBUl8Wa7jxOFm/WQE
         igWXNsdz/p6wr6jfzcQnXae223VKQTjYXTrkZCsG6X60VmpVPlJXK0C2kvASO8Pk7pPb
         QHUgYqemo4yZHv6EL+y7LqMbK9s+SV68Zy0r6hDD+LpTFhDNSLbZbYnfIQJtr+36cn5G
         4sNUYuSmljVMK7ReUBHA/Xd2PlLOyHyMXuFjTdHh4BiyVsQl3/+VyQNVfFHrfkO6cDYS
         c0Og==
X-Gm-Message-State: APjAAAW8dEl7WGHzI8mm/n89TSVsSANK+f2xA5qpW5Jw7hrH6cwUaVg8
        EaPGFmxTeCWSjxApuLxm7mdcBvlLvvtkowAmgxYm9llDGulvRIwsjqSlSKI7Ffs+5Hah2Xrmu8V
        ALmModay+WXX23wm7+35n2pUb7ufI2pnuSOvaF3G1tKevYqyeThW1daqylU6sp4WwekrZTY6oIF
        3W
X-Google-Smtp-Source: APXvYqxkfWDW8U5HXEg5Q8/Awj4QuTRe6NKNIOi9ntKybONBkGVLEtn6yi4Tj8Nw+8XoiHenDdwhkx88CtQnN6HJLCMj
X-Received: by 2002:a25:6cc6:: with SMTP id h189mr10935629ybc.13.1555098690779;
 Fri, 12 Apr 2019 12:51:30 -0700 (PDT)
Date:   Fri, 12 Apr 2019 12:51:22 -0700
In-Reply-To: <cover.1555098572.git.jonathantanmy@google.com>
Message-Id: <48bdd462c4e6f609827f4970ee76316e3b54b400.1555098572.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190405204413.93900-1-jonathantanmy@google.com> <cover.1555098572.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v4 2/2] clone: send server options when using protocol v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 5e3548ef16 ("fetch: send server options when using protocol v2",
2018-04-24) taught "fetch" the ability to send server options when using
protocol v2, but not "clone". This ability is triggered by "-o" or
"--server-option".

Teach "clone" the same ability, except that because "clone" already
has "-o" for another parameter, teach "clone" only to receive
"--server-option".

Explain in the documentation, both for clone and for fetch, that server
handling of server options are server-specific. This is similar to
receive-pack's handling of push options - currently, they are just sent
to hooks to interpret as they see fit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/fetch-options.txt |  3 ++-
 Documentation/git-clone.txt     |  8 ++++++++
 builtin/clone.c                 |  6 ++++++
 t/t5702-protocol-v2.sh          | 22 ++++++++++++++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index fa0a3151b3..91c47752ec 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -216,7 +216,8 @@ endif::git-pull[]
 --server-option=<option>::
 	Transmit the given string to the server when communicating using
 	protocol version 2.  The given string must not contain a NUL or LF
-	character.
+	character.  The server's handling of server options, including
+	unknown ones, is server-specific.
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
 
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 2fd12524f9..a0f14b51f2 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -131,6 +131,14 @@ objects from the source repository into a pack in the cloned repository.
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
+--server-option=<option>::
+	Transmit the given string to the server when communicating using
+	protocol version 2.  The given string must not contain a NUL or LF
+	character.  The server's handling of server options, including
+	unknown ones, is server-specific.
+	When multiple `--server-option=<option>` are given, they are all
+	sent to the other side in the order listed on the command line.
+
 --no-checkout::
 -n::
 	No checkout of HEAD is performed after the clone is complete.
diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..31a47d190a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -66,6 +66,7 @@ static int option_dissociate;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
 static struct list_objects_filter_options filter_options;
+static struct string_list server_options = STRING_LIST_INIT_NODUP;
 
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
@@ -137,6 +138,8 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_STRING_LIST(0, "server-option", &server_options,
+			N_("server-specific"), N_("option to transmit")),
 	OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
@@ -1136,6 +1139,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
 
+	if (server_options.nr)
+		transport->server_options = &server_options;
+
 	if (filter_options.choice) {
 		struct strbuf expanded_filter_spec = STRBUF_INIT;
 		expand_list_objects_filter_spec(&filter_options,
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 1e8357a4c7..2a3575d38c 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -270,6 +270,28 @@ test_expect_success 'warn if using server-option with fetch with legacy protocol
 	grep "server options require protocol version 2 or later" err
 '
 
+test_expect_success 'server-options are sent when cloning' '
+	test_when_finished "rm -rf log myclone" &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		clone --server-option=hello --server-option=world \
+		"file://$(pwd)/file_parent" myclone &&
+
+	grep "server-option=hello" log &&
+	grep "server-option=world" log
+'
+
+test_expect_success 'warn if using server-option with clone with legacy protocol' '
+	test_when_finished "rm -rf myclone" &&
+
+	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
+		clone --server-option=hello --server-option=world \
+		"file://$(pwd)/file_parent" myclone 2>err &&
+
+	grep "see protocol.version in" err &&
+	grep "server options require protocol version 2 or later" err
+'
+
 test_expect_success 'upload-pack respects config using protocol v2' '
 	git init server &&
 	write_script server/.git/hook <<-\EOF &&
-- 
2.21.0.392.gf8f6787159e-goog

