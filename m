Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10BE31F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeDUKKH (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:10:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:42957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbeDUKKF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:10:05 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4jbN-1eDSyt0LV7-00z1lb; Sat, 21
 Apr 2018 12:10:02 +0200
Date:   Sat, 21 Apr 2018 12:10:00 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Ryan Dammrose <ryandammrose@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/4] push: colorize errors
In-Reply-To: <cover.1524305353.git.johannes.schindelin@gmx.de>
Message-ID: <00115ad6b3c10608353d7242669c8de7c4d13cd7.1524305353.git.johannes.schindelin@gmx.de>
References: <cover.1522968472.git.johannes.schindelin@gmx.de> <cover.1524305353.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KTvpKeUHoZ+4OIqUXnmOQ0+VXgat/QIVWE/CxuH3svJ0m15VYpI
 hbRdtKNhCKj2IwaogpHJbLk9xfmc5Le8tvR3nb2CXaY1PtCv6rBE9Ow33V8/3pmNltbtqf2
 g+1mmv9eLUD+Ls7BqJ3jr4Z4HTfx/mMH5wXY7L3Pn6K8w/1LhYv+e5gGgLGVd9THi2hyLBq
 66TwmcDN8ppR/dAS2cdEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u2jFdQbmPl0=:aDhRh9d88yuz3ggkjxyllC
 DPBdRAb/Y4p6ACdU0gCmxIAJEHPzpq7/QaK5vRwO6TCKPpM0Y7VoZN6TpgAxhA5sKaVKOM2Q2
 XD6gJi/cAz+Kv3OvzkXWlq5rFM11SLeiqCKX1KoAp6duP9/nY6tuYfvSL6YB94ZlYkhydOyaZ
 d7x7BGqXFqKACnKhay7SGsR9CdXY4zNaMo4/j42hTAdOsnOBs8oYZqs7XPPZh5vW1MqknfevB
 2q+5FRJP26MO0CZbNLJv8SrN6R7ZAJHGDdJ1dHx/Rr0dchQeuZdPSFgrZKjSCcRKdTNDm6t6w
 LE7EUJerfHo70eHVzYqNKBZqpsE/6IcmvGPN6GEDEo67/wui6CNKbdXeC3wVbKLdKIHs1XJvo
 wWWVn49KABPa7VeHCk2e3jkGiFDp3MhPIVSAxvqCYIwKzG52bK1psTTGJVF7tiAsK2axX++me
 nBfroVqFtsKF8KucbF0b+ctYld0qoAXzpnAKOOClIXBU8J9TKVIC2K+mpbsgmTZm5y8bb5I0N
 Lg3tNCShzU2zyszsT7qRwKZLxr7cOO1kbpOaJq0YFWGnUAUfHKjMvZfyDnpN0b/ehhoOJsY4O
 S/r5pnl7nRk6a988C0jDYpDctGvfBCR3OUV6a7pBHB/Abg73WYZ1uKiVyAkpSzsYp129Ldy13
 yAtZAYe5BfSKmmREKJualifdxSp0gXq02dNsSfhnHMNNeKfDIMbn/FR7xfMPrC0gxJF1uXhrJ
 EP/U7bSBX+tcDdL+7jFY45JiD+Ggytj+09tzU1Zl7Jlw2VaR6waDJmN6r9C9fwCV+q3doN0yi
 UOZLJFVpbe/uQ6xzPwmtpzCp2ZIWpkuZXiHP99J2eE/pvOBo8I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ryan Dammrose <ryandammrose@gmail.com>

This is an attempt to resolve an issue I experience with people that are
new to Git -- especially colleagues in a team setting -- where they miss
that their push to a remote location failed because the failure and
success both return a block of white text.

An example is if I push something to a remote repository and then a
colleague attempts to push to the same remote repository and the push
fails because it requires them to pull first, but they don't notice
because a success and failure both return a block of white text. They
then continue about their business, thinking it has been successfully
pushed.

This patch colorizes the errors and hints (in red and yellow,
respectively) so whenever there is a failure when pushing to a remote
repository that fails, it is more noticeable.

[jes: fixed a couple bugs, added the color.{advice,push,transport}
settings, refactored to use want_color_stderr().]

Signed-off-by: Ryan Dammrose ryandammrose@gmail.com
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 advice.c       | 49 ++++++++++++++++++++++++++++++++++--
 builtin/push.c | 44 ++++++++++++++++++++++++++++++++-
 config.c       |  2 +-
 transport.c    | 67 +++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 157 insertions(+), 5 deletions(-)

diff --git a/advice.c b/advice.c
index 406efc183ba..89fda1de55b 100644
--- a/advice.c
+++ b/advice.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "color.h"
 
 int advice_push_update_rejected = 1;
 int advice_push_non_ff_current = 1;
@@ -20,6 +21,33 @@ int advice_add_embedded_repo = 1;
 int advice_ignored_hook = 1;
 int advice_waiting_for_editor = 1;
 
+static int advice_use_color = -1;
+static char advice_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_RESET,
+	GIT_COLOR_YELLOW,	/* HINT */
+};
+
+enum color_advice {
+	ADVICE_COLOR_RESET = 0,
+	ADVICE_COLOR_HINT = 1,
+};
+
+static int parse_advise_color_slot(const char *slot)
+{
+	if (!strcasecmp(slot, "reset"))
+		return ADVICE_COLOR_RESET;
+	if (!strcasecmp(slot, "hint"))
+		return ADVICE_COLOR_HINT;
+	return -1;
+}
+
+static const char *advise_get_color(enum color_advice ix)
+{
+	if (want_color_stderr(advice_use_color))
+		return advice_colors[ix];
+	return "";
+}
+
 static struct {
 	const char *name;
 	int *preference;
@@ -59,7 +87,10 @@ void advise(const char *advice, ...)
 
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
-		fprintf(stderr,	_("hint: %.*s\n"), (int)(np - cp), cp);
+		fprintf(stderr,	_("%shint: %.*s%s\n"),
+			advise_get_color(ADVICE_COLOR_HINT),
+			(int)(np - cp), cp,
+			advise_get_color(ADVICE_COLOR_RESET));
 		if (*np)
 			np++;
 	}
@@ -68,9 +99,23 @@ void advise(const char *advice, ...)
 
 int git_default_advice_config(const char *var, const char *value)
 {
-	const char *k;
+	const char *k, *slot_name;
 	int i;
 
+	if (!strcmp(var, "color.advice")) {
+		advice_use_color = git_config_colorbool(var, value);
+		return 0;
+	}
+
+	if (skip_prefix(var, "color.advice.", &slot_name)) {
+		int slot = parse_advise_color_slot(slot_name);
+		if (slot < 0)
+			return 0;
+		if (!value)
+			return config_error_nonbool(var);
+		return color_parse(value, advice_colors[slot]);
+	}
+
 	if (!skip_prefix(var, "advice.", &k))
 		return 0;
 
diff --git a/builtin/push.c b/builtin/push.c
index 013c20d6164..ac3705370e1 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -12,12 +12,40 @@
 #include "submodule.h"
 #include "submodule-config.h"
 #include "send-pack.h"
+#include "color.h"
 
 static const char * const push_usage[] = {
 	N_("git push [<options>] [<repository> [<refspec>...]]"),
 	NULL,
 };
 
+static int push_use_color = -1;
+static char push_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_RESET,
+	GIT_COLOR_RED,	/* ERROR */
+};
+
+enum color_push {
+	PUSH_COLOR_RESET = 0,
+	PUSH_COLOR_ERROR = 1
+};
+
+static int parse_push_color_slot(const char *slot)
+{
+	if (!strcasecmp(slot, "reset"))
+		return PUSH_COLOR_RESET;
+	if (!strcasecmp(slot, "error"))
+		return PUSH_COLOR_ERROR;
+	return -1;
+}
+
+static const char *push_get_color(enum color_push ix)
+{
+	if (want_color_stderr(push_use_color))
+		return push_colors[ix];
+	return "";
+}
+
 static int thin = 1;
 static int deleterefs;
 static const char *receivepack;
@@ -337,8 +365,11 @@ static int push_with_options(struct transport *transport, int flags)
 		fprintf(stderr, _("Pushing to %s\n"), transport->url);
 	err = transport_push(transport, refspec_nr, refspec, flags,
 			     &reject_reasons);
-	if (err != 0)
+	if (err != 0) {
+		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_ERROR));
 		error(_("failed to push some refs to '%s'"), transport->url);
+		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_RESET));
+	}
 
 	err |= transport_disconnect(transport);
 	if (!err)
@@ -467,6 +498,7 @@ static void set_push_cert_flags(int *flags, int v)
 
 static int git_push_config(const char *k, const char *v, void *cb)
 {
+	const char *slot_name;
 	int *flags = cb;
 	int status;
 
@@ -514,6 +546,16 @@ static int git_push_config(const char *k, const char *v, void *cb)
 			else
 				string_list_append(&push_options_config, v);
 		return 0;
+	} else if (!strcmp(k, "color.push")) {
+		push_use_color = git_config_colorbool(k, v);
+		return 0;
+	} else if (skip_prefix(k, "color.push.", &slot_name)) {
+		int slot = parse_push_color_slot(slot_name);
+		if (slot < 0)
+			return 0;
+		if (!v)
+			return config_error_nonbool(k);
+		return color_parse(v, push_colors[slot]);
 	}
 
 	return git_default_config(k, v, NULL);
diff --git a/config.c b/config.c
index c698988f5e1..f21317a25a7 100644
--- a/config.c
+++ b/config.c
@@ -1365,7 +1365,7 @@ int git_default_config(const char *var, const char *value, void *dummy)
 	if (starts_with(var, "mailmap."))
 		return git_default_mailmap_config(var, value);
 
-	if (starts_with(var, "advice."))
+	if (starts_with(var, "advice.") || starts_with(var, "color.advice"))
 		return git_default_advice_config(var, value);
 
 	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
diff --git a/transport.c b/transport.c
index 94eccf29aa3..f72081a5a58 100644
--- a/transport.c
+++ b/transport.c
@@ -19,6 +19,56 @@
 #include "sigchain.h"
 #include "transport-internal.h"
 #include "object-store.h"
+#include "color.h"
+
+static int transport_use_color = -1;
+static char transport_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_RESET,
+	GIT_COLOR_RED		/* REJECTED */
+};
+
+enum color_transport {
+	TRANSPORT_COLOR_RESET = 0,
+	TRANSPORT_COLOR_REJECTED = 1
+};
+
+static int transport_color_config(void)
+{
+	const char *keys[] = {
+		"color.transport.reset",
+		"color.transport.rejected"
+	}, *key = "color.transport";
+	char *value;
+	int i;
+	static int initialized;
+
+	if (initialized)
+		return 0;
+	initialized = 1;
+
+	if (!git_config_get_string(key, &value))
+		transport_use_color = git_config_colorbool(key, value);
+
+	if (!want_color_stderr(transport_use_color))
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(keys); i++)
+		if (!git_config_get_string(keys[i], &value)) {
+			if (!value)
+				return config_error_nonbool(keys[i]);
+			if (color_parse(value, transport_colors[i]) < 0)
+				return -1;
+		}
+
+	return 0;
+}
+
+static const char *transport_get_color(enum color_transport ix)
+{
+	if (want_color_stderr(transport_use_color))
+		return transport_colors[ix];
+	return "";
+}
 
 static void set_upstreams(struct transport *transport, struct ref *refs,
 	int pretend)
@@ -339,7 +389,13 @@ static void print_ref_status(char flag, const char *summary,
 		else
 			fprintf(stdout, "%s\n", summary);
 	} else {
-		fprintf(stderr, " %c %-*s ", flag, summary_width, summary);
+		const char *red = "", *reset = "";
+		if (push_had_errors(to)) {
+			red = transport_get_color(TRANSPORT_COLOR_REJECTED);
+			reset = transport_get_color(TRANSPORT_COLOR_RESET);
+		}
+		fprintf(stderr, " %s%c %-*s%s ", red, flag, summary_width,
+			summary, reset);
 		if (from)
 			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
 		else
@@ -488,6 +544,9 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 	char *head;
 	int summary_width = transport_summary_width(refs);
 
+	if (transport_color_config() < 0)
+		warning(_("could not parse transport.color.* config"));
+
 	head = resolve_refdup("HEAD", RESOLVE_REF_READING, NULL, NULL);
 
 	if (verbose) {
@@ -554,6 +613,9 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	struct send_pack_args args;
 	int ret;
 
+	if (transport_color_config() < 0)
+		return -1;
+
 	if (!data->got_remote_heads) {
 		struct ref *tmp_refs;
 		connect_setup(transport, 1);
@@ -998,6 +1060,9 @@ int transport_push(struct transport *transport,
 	*reject_reasons = 0;
 	transport_verify_remote_names(refspec_nr, refspec);
 
+	if (transport_color_config() < 0)
+		return -1;
+
 	if (transport->vtable->push_refs) {
 		struct ref *remote_refs;
 		struct ref *local_refs = get_local_heads();
-- 
2.17.0.windows.1.15.gaa56ade3205


