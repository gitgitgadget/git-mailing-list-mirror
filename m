Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E65DC1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbeGRQvd (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:51:33 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:36397 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731587AbeGRQvd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:51:33 -0400
Received: by mail-lj1-f174.google.com with SMTP id u7-v6so4595989lji.3
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ud4VM2GiIZrpHgl3qpTchcFr34wTnuD6vezUquZJpKk=;
        b=eWWHxjMwJ2B1eEgNShOF8x8GfhBW5i1rZLafVMk4qZ4h9QZyNCK9lBYD4IpR0ANhrv
         w1NmmqlY+/54YMH0oMr7ybptjwPTlbOQCDjubyuttIDfGs45gdReWZxlHr506yPP6kPV
         eaGyERhKuoAi2g94O+MCd+FG4/DtmW8z0IvOQa7V/Lr8dw4MqmIMPtgkSMJbA+aZQtIO
         myNRtZP67JZj3vEU1u2Xr2Z7h/KG0aowbjPJlJBiLFg9+R8TFG3zb4ZJmhR1liDcvPjG
         Dodm/g6A3vHwaQbKBsleQ67G0YN159UX7ZJ/B5+CN46+bVWLBS97Vg7aBAHTaVbgFfSq
         fi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ud4VM2GiIZrpHgl3qpTchcFr34wTnuD6vezUquZJpKk=;
        b=HsgQ0cBGZaGt3xNCrSENjoadcquEOG+9CAqlCXVzTx6jdxkGgjSAsxcDtv+3eICzIj
         ZhEk41WamlWOM8GvSTIqioPPN6ydnJqYEsu3tTlF1Z0wj+lBqqzwkmpYxD8Jg3DnoKls
         lpqZdX7cHfc76xT3YkNnbpqFlOl82VXv10RePxcN84SlI6CxD3iNOezlaYeJxCydnvF3
         psvx3qctEKerI7zfYWoNx59Q78BWuhKJS35OCX4L1BpjtMA/hulWI2xrqQzLeG6HIUyH
         7O1r9hUsrNEIlH9uPRzLIksKJhhowYugzc5fQ1XPdlPs8zCPzaVxx/IMg3AtYmi47RMC
         YpAg==
X-Gm-Message-State: AOUpUlGH2/dwKz9EeZDdcst24YKQMfFkeHFV3h3QLO3IFdGK3cTEGlqm
        Tiua4ovKTykVC1AzMGnls9PaNw==
X-Google-Smtp-Source: AAOMgpf7MSQgoGOc2Elh9/T1BarN9tfuEoVlzzN7vBFYV3Fqb9qMwS+2pT1gYlTGR/e+jLhVvxslxg==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26-v6mr4968471lja.149.1531930373547;
        Wed, 18 Jul 2018 09:12:53 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id j26-v6sm689203ljc.54.2018.07.18.09.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:12:52 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 10/23] connect.c: mark more strings for translation
Date:   Wed, 18 Jul 2018 18:10:48 +0200
Message-Id: <20180718161101.19765-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180718161101.19765-1-pclouds@gmail.com>
References: <20180718161101.19765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 connect.c             | 78 +++++++++++++++++++++++--------------------
 t/t5570-git-daemon.sh |  6 ++--
 2 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/connect.c b/connect.c
index 083cf804a7..70b97cfef6 100644
--- a/connect.c
+++ b/connect.c
@@ -78,7 +78,7 @@ int server_supports_v2(const char *c, int die_on_error)
 	}
 
 	if (die_on_error)
-		die("server doesn't support '%s'", c);
+		die(_("server doesn't support '%s'"), c);
 
 	return 0;
 }
@@ -100,7 +100,7 @@ int server_supports_feature(const char *c, const char *feature,
 	}
 
 	if (die_on_error)
-		die("server doesn't support feature '%s'", feature);
+		die(_("server doesn't support feature '%s'"), feature);
 
 	return 0;
 }
@@ -111,7 +111,7 @@ static void process_capabilities_v2(struct packet_reader *reader)
 		argv_array_push(&server_capabilities_v2, reader->line);
 
 	if (reader->status != PACKET_READ_FLUSH)
-		die("expected flush after capabilities");
+		die(_("expected flush after capabilities"));
 }
 
 enum protocol_version discover_version(struct packet_reader *reader)
@@ -230,7 +230,7 @@ static int process_dummy_ref(const char *line)
 static void check_no_capabilities(const char *line, int len)
 {
 	if (strlen(line) != len)
-		warning("ignoring capabilities after first line '%s'",
+		warning(_("ignoring capabilities after first line '%s'"),
 			line + strlen(line));
 }
 
@@ -249,7 +249,7 @@ static int process_ref(const char *line, int len, struct ref ***list,
 	if (extra_have && !strcmp(name, ".have")) {
 		oid_array_append(extra_have, &old_oid);
 	} else if (!strcmp(name, "capabilities^{}")) {
-		die("protocol error: unexpected capabilities^{}");
+		die(_("protocol error: unexpected capabilities^{}"));
 	} else if (check_ref(name, flags)) {
 		struct ref *ref = alloc_ref(name);
 		oidcpy(&ref->old_oid, &old_oid);
@@ -270,9 +270,9 @@ static int process_shallow(const char *line, int len,
 		return 0;
 
 	if (get_oid_hex(arg, &old_oid))
-		die("protocol error: expected shallow sha-1, got '%s'", arg);
+		die(_("protocol error: expected shallow sha-1, got '%s'"), arg);
 	if (!shallow_points)
-		die("repository on the other end cannot be shallow");
+		die(_("repository on the other end cannot be shallow"));
 	oid_array_append(shallow_points, &old_oid);
 	check_no_capabilities(line, len);
 	return 1;
@@ -307,13 +307,13 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 		case PACKET_READ_NORMAL:
 			len = reader->pktlen;
 			if (len > 4 && skip_prefix(reader->line, "ERR ", &arg))
-				die("remote error: %s", arg);
+				die(_("remote error: %s"), arg);
 			break;
 		case PACKET_READ_FLUSH:
 			state = EXPECTING_DONE;
 			break;
 		case PACKET_READ_DELIM:
-			die("invalid packet");
+			die(_("invalid packet"));
 		}
 
 		switch (state) {
@@ -333,7 +333,7 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 		case EXPECTING_SHALLOW:
 			if (process_shallow(reader->line, len, shallow_points))
 				break;
-			die("protocol error: unexpected '%s'", reader->line);
+			die(_("protocol error: unexpected '%s'"), reader->line);
 		case EXPECTING_DONE:
 			break;
 		}
@@ -441,11 +441,11 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 	/* Process response from server */
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
 		if (!process_ref_v2(reader->line, &list))
-			die("invalid ls-refs response: %s", reader->line);
+			die(_("invalid ls-refs response: %s"), reader->line);
 	}
 
 	if (reader->status != PACKET_READ_FLUSH)
-		die("expected flush after ref listing");
+		die(_("expected flush after ref listing"));
 
 	return list;
 }
@@ -544,7 +544,7 @@ static enum protocol get_protocol(const char *name)
 		return PROTO_SSH;
 	if (!strcmp(name, "file"))
 		return PROTO_FILE;
-	die("protocol '%s' is not supported", name);
+	die(_("protocol '%s' is not supported"), name);
 }
 
 static char *host_end(char **hoststart, int removebrackets)
@@ -595,7 +595,7 @@ static void enable_keepalive(int sockfd)
 	int ka = 1;
 
 	if (setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &ka, sizeof(ka)) < 0)
-		error_errno("unable to set SO_KEEPALIVE on socket");
+		error_errno(_("unable to set SO_KEEPALIVE on socket"));
 }
 
 #ifndef NO_IPV6
@@ -635,15 +635,16 @@ static int git_tcp_connect_sock(char *host, int flags)
 	hints.ai_protocol = IPPROTO_TCP;
 
 	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "Looking up %s ... ", host);
+		fprintf(stderr, _("Looking up %s ... "), host);
 
 	gai = getaddrinfo(host, port, &hints, &ai);
 	if (gai)
-		die("unable to look up %s (port %s) (%s)", host, port, gai_strerror(gai));
+		die(_("unable to look up %s (port %s) (%s)"), host, port, gai_strerror(gai));
 
 	if (flags & CONNECT_VERBOSE) {
-		fprintf_ln(stderr, "done.");
-		fprintf(stderr, "Connecting to %s (port %s) ... ", host, port);
+		/* TRANSLATORS: this is the end of "Looking up %s ... " */
+		fprintf_ln(stderr, _("done."));
+		fprintf(stderr, _("Connecting to %s (port %s) ... "), host, port);
 	}
 
 	for (ai0 = ai; ai; ai = ai->ai_next, cnt++) {
@@ -666,12 +667,13 @@ static int git_tcp_connect_sock(char *host, int flags)
 	freeaddrinfo(ai0);
 
 	if (sockfd < 0)
-		die("unable to connect to %s:\n%s", host, error_message.buf);
+		die(_("unable to connect to %s:\n%s"), host, error_message.buf);
 
 	enable_keepalive(sockfd);
 
 	if (flags & CONNECT_VERBOSE)
-		fprintf_ln(stderr, "done.");
+		/* TRANSLATORS: this is the end of "Connecting to %s (port %s) ... " */
+		fprintf_ln(stderr, _("done."));
 
 	strbuf_release(&error_message);
 
@@ -698,23 +700,24 @@ static int git_tcp_connect_sock(char *host, int flags)
 	get_host_and_port(&host, &port);
 
 	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "Looking up %s ... ", host);
+		fprintf(stderr, _("Looking up %s ... "), host);
 
 	he = gethostbyname(host);
 	if (!he)
-		die("unable to look up %s (%s)", host, hstrerror(h_errno));
+		die(_("unable to look up %s (%s)"), host, hstrerror(h_errno));
 	nport = strtoul(port, &ep, 10);
 	if ( ep == port || *ep ) {
 		/* Not numeric */
 		struct servent *se = getservbyname(port,"tcp");
 		if ( !se )
-			die("unknown port %s", port);
+			die(_("unknown port %s"), port);
 		nport = se->s_port;
 	}
 
 	if (flags & CONNECT_VERBOSE) {
-		fprintf_ln(stderr, "done.");
-		fprintf(stderr, "Connecting to %s (port %s) ... ", host, port);
+		/* TRANSLATORS: this is the end of "Looking up %s ... " */
+		fprintf_ln(stderr, _("done."));
+		fprintf(stderr, _("Connecting to %s (port %s) ... "), host, port);
 	}
 
 	for (cnt = 0, ap = he->h_addr_list; *ap; ap++, cnt++) {
@@ -743,12 +746,13 @@ static int git_tcp_connect_sock(char *host, int flags)
 	}
 
 	if (sockfd < 0)
-		die("unable to connect to %s:\n%s", host, error_message.buf);
+		die(_("unable to connect to %s:\n%s"), host, error_message.buf);
 
 	enable_keepalive(sockfd);
 
 	if (flags & CONNECT_VERBOSE)
-		fprintf_ln(stderr, "done.");
+		/* TRANSLATORS: this is the end of "Connecting to %s (port %s) ... " */
+		fprintf_ln(stderr, _("done."));
 
 	return sockfd;
 }
@@ -845,9 +849,9 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 	get_host_and_port(&host, &port);
 
 	if (looks_like_command_line_option(host))
-		die("strange hostname '%s' blocked", host);
+		die(_("strange hostname '%s' blocked"), host);
 	if (looks_like_command_line_option(port))
-		die("strange port '%s' blocked", port);
+		die(_("strange port '%s' blocked"), port);
 
 	proxy = xmalloc(sizeof(*proxy));
 	child_process_init(proxy);
@@ -857,7 +861,7 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 	proxy->in = -1;
 	proxy->out = -1;
 	if (start_command(proxy))
-		die("cannot start proxy %s", git_proxy_command);
+		die(_("cannot start proxy %s"), git_proxy_command);
 	fd[0] = proxy->out; /* read from proxy stdout */
 	fd[1] = proxy->in;  /* write to proxy stdin */
 	return proxy;
@@ -924,7 +928,7 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 		path = strchr(end, separator);
 
 	if (!path || !*path)
-		die("no path specified; see 'git help pull' for valid url syntax");
+		die(_("no path specified; see 'git help pull' for valid url syntax"));
 
 	/*
 	 * null-terminate hostname and point path to ~ for URL's like this:
@@ -1119,7 +1123,7 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 		case VARIANT_AUTO:
 			BUG("VARIANT_AUTO passed to push_ssh_options");
 		case VARIANT_SIMPLE:
-			die("ssh variant 'simple' does not support -4");
+			die(_("ssh variant 'simple' does not support -4"));
 		case VARIANT_SSH:
 		case VARIANT_PLINK:
 		case VARIANT_PUTTY:
@@ -1131,7 +1135,7 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 		case VARIANT_AUTO:
 			BUG("VARIANT_AUTO passed to push_ssh_options");
 		case VARIANT_SIMPLE:
-			die("ssh variant 'simple' does not support -6");
+			die(_("ssh variant 'simple' does not support -6"));
 		case VARIANT_SSH:
 		case VARIANT_PLINK:
 		case VARIANT_PUTTY:
@@ -1148,7 +1152,7 @@ static void push_ssh_options(struct argv_array *args, struct argv_array *env,
 		case VARIANT_AUTO:
 			BUG("VARIANT_AUTO passed to push_ssh_options");
 		case VARIANT_SIMPLE:
-			die("ssh variant 'simple' does not support setting port");
+			die(_("ssh variant 'simple' does not support setting port"));
 		case VARIANT_SSH:
 			argv_array_push(args, "-p");
 			break;
@@ -1171,7 +1175,7 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 	enum ssh_variant variant;
 
 	if (looks_like_command_line_option(ssh_host))
-		die("strange hostname '%s' blocked", ssh_host);
+		die(_("strange hostname '%s' blocked"), ssh_host);
 
 	ssh = get_ssh_command();
 	if (ssh) {
@@ -1259,7 +1263,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		child_process_init(conn);
 
 		if (looks_like_command_line_option(path))
-			die("strange pathname '%s' blocked", path);
+			die(_("strange pathname '%s' blocked"), path);
 
 		strbuf_addstr(&cmd, prog);
 		strbuf_addch(&cmd, ' ');
@@ -1304,7 +1308,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		argv_array_push(&conn->args, cmd.buf);
 
 		if (start_command(conn))
-			die("unable to fork");
+			die(_("unable to fork"));
 
 		fd[0] = conn->out; /* read from child's stdout */
 		fd[1] = conn->in;  /* write to child's stdin */
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 0d4c52016b..a571f22bfd 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -7,9 +7,9 @@ test_description='test fetching over git protocol'
 start_git_daemon
 
 check_verbose_connect () {
-	grep -F "Looking up 127.0.0.1 ..." stderr &&
-	grep -F "Connecting to 127.0.0.1 (port " stderr &&
-	grep -F "done." stderr
+	test_i18ngrep -F "Looking up 127.0.0.1 ..." stderr &&
+	test_i18ngrep -F "Connecting to 127.0.0.1 (port " stderr &&
+	test_i18ngrep -F "done." stderr
 }
 
 test_expect_success 'setup repository' '
-- 
2.18.0.rc2.476.g39500d3211

