Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD351F404
	for <e@80x24.org>; Fri, 16 Feb 2018 12:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966398AbeBPMZ4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 07:25:56 -0500
Received: from mout.gmx.net ([212.227.15.19]:33805 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966351AbeBPMZz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 07:25:55 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MS5Dm-1fEfX231ti-00TC6T; Fri, 16 Feb 2018 13:25:50 +0100
Date:   Fri, 16 Feb 2018 13:25:50 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Ryan Dammrose <ryandammrose@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/1] Colorize push errors
In-Reply-To: <cover.1518783709.git.johannes.schindelin@gmx.de>
Message-ID: <cfdb79a05018ad113b43e620d86b4f667486ba5d.1518783709.git.johannes.schindelin@gmx.de>
References: <cover.1518783709.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jr9roo3negkUyPzrdbLqVzBjfDR0UOZVs8X5xm2OWKqLoXGhRU1
 I394ZLEQDm9IgEoCiDj0nwNQ5auvlH7FjT02QwuHIko+Few6IsQ8KmfhwkrJi1smR035avx
 wRzROhzfA75yguN/K7nmr47N2yBhODa1XPMad3TU4F+reTVzddsJ2x7qli1oF7Ijxqju0uc
 mZrY8xRBxX1NJjbLa4VGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FRPU+fdHXIc=:xjStL0QIMEApurs2B0lFLS
 A81hnNbABHIDY7FttWTG/6zKh0HGynCgzE3lnnu7cZIkp+uAlc9REvRund3RszFfd9U5Cnltu
 G1WV8JQcD0RDlw56dcIEXwDq7zfBAl8GqVWwhpN1+gWZ4k9tNJYp06YF7V6ML7ubd542jcEBd
 ir7yqimNwCSl+t1avjUX2kLdgsmkpmwqHGGvgjB5ktepfMKNsywrpgw1EMArmb4YwC1cMMYBI
 LYnZZHC7CzSksNyDOVncyKg/G9jVKDJBEfIp57jP5r5EiKttW9AcpE2wpzi5Y//HQJczcY4G8
 C7d/EB5bx3Nnu6N2ERXdY1fmf52mlUvKCtCSE1efhrnmBB5A9iETCNZCTWgdmp582vOjYf7Hx
 JkFKLOziNmBRj8dB3HvXBU4qJcsZW677yaBG1EjNbe5fXvszfLZywJGDZhRHeKHc0FVt0lNtR
 U2D1WX1ORfqs7YLe43xZaa6IzeU5/p3skE0s0bvwjCBdS1hypqJfjD1+LRVgzcorbBnAzB+Ub
 bwnrzdv1mtZ4VU2LZjjqlACWlHJOPV8ROPA1QsuuXqHM1XOR6oOgN7AaX5A2AKxAvSHOKG92D
 2XRmp2dcoeKNOZdI7p9MBWJ/ByMxJKj1rJvdWpfxM376eqc+W/GgT5j8OPZwgiVuMXiQ4oOtS
 a/HX+XHMJ3qSFN2k+QNKNXsn4pCH47uHL9gs+PHaVNuoecnoCHK6/9NJJL3T5a29m/XG5okDJ
 28XKHoJ1ELzBYmlPXIlr4vf9Dc2Q89tcPi5t6Lyt+ORyugH1xB1M87B34bk6WkR7aPMAEEOE8
 +VB77D0vjpelfL4h6+eQKqc5HNjlDvKcpeUYFfIOgWQT+3HcWE=
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

My solution was to try to change the stderr and hint colors (red and
yellow, respectively) so whenever there is a failure when pushing to a
remote repository that fails, it is more noticeable.

The challenge was that it seemed that stderr has never been colored and
I attempted to utilize what was already established; but this meant
using functions like want_color() even if it targets stdout while I
wanted to target stderr.

Additionally, to check for all rejection types, I did a strstr check in
transport.c, but this code could be problematic if there is need for
translation.

Signed-off-by: Ryan Dammrose ryandammrose@gmail.com
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 advice.c       | 42 +++++++++++++++++++++++++++++++++++++++--
 builtin/push.c | 38 +++++++++++++++++++++++++++++++++++++
 transport.c    | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/advice.c b/advice.c
index 406efc183ba..42460877ef6 100644
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
+	if (!strcasecmp(slot, "advice"))
+		return ADVICE_COLOR_HINT;
+	return -1;
+}
+
+static const char *advise_get_color(enum color_advice ix)
+{
+	if (want_color(advice_use_color))
+		return advice_colors[ix];
+	return "";
+}
+
 static struct {
 	const char *name;
 	int *preference;
@@ -59,7 +87,8 @@ void advise(const char *advice, ...)
 
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
-		fprintf(stderr,	_("hint: %.*s\n"), (int)(np - cp), cp);
+		fprintf(stderr,	_("%shint: %.*s%s\n"), advise_get_color(ADVICE_COLOR_HINT),
+			(int)(np - cp), cp, advise_get_color(ADVICE_COLOR_RESET));
 		if (*np)
 			np++;
 	}
@@ -68,9 +97,18 @@ void advise(const char *advice, ...)
 
 int git_default_advice_config(const char *var, const char *value)
 {
-	const char *k;
+	const char *k, *slot_name;
 	int i;
 
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
index 1c28427d82e..997ccab52ac 100644
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
+	if (want_color(push_use_color))
+		return push_colors[ix];
+	return "";
+}
+
 static int thin = 1;
 static int deleterefs;
 static const char *receivepack;
@@ -338,7 +366,9 @@ static int push_with_options(struct transport *transport, int flags)
 	err = transport_push(transport, refspec_nr, refspec, flags,
 			     &reject_reasons);
 	if (err != 0)
+		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_ERROR));
 		error(_("failed to push some refs to '%s'"), transport->url);
+		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_RESET));
 
 	err |= transport_disconnect(transport);
 	if (!err)
@@ -467,6 +497,7 @@ static void set_push_cert_flags(int *flags, int v)
 
 static int git_push_config(const char *k, const char *v, void *cb)
 {
+	const char *slot_name;
 	int *flags = cb;
 	int status;
 
@@ -514,6 +545,13 @@ static int git_push_config(const char *k, const char *v, void *cb)
 			else
 				string_list_append(&push_options_config, v);
 		return 0;
+	} else if (skip_prefix(k, "color.advice.", &slot_name)) {
+		int slot = parse_push_color_slot(slot_name);
+		if (slot < 0)
+			return 0;
+		if (!v)
+			return config_error_nonbool(k);
+		return color_parse(v, push_colors[slot]);
 	}
 
 	return git_default_config(k, v, NULL);
diff --git a/transport.c b/transport.c
index 00d48b5b565..dd98dd84b05 100644
--- a/transport.c
+++ b/transport.c
@@ -18,6 +18,50 @@
 #include "sha1-array.h"
 #include "sigchain.h"
 #include "transport-internal.h"
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
+		"transport.color.reset",
+		"transport.color.rejected"
+	};
+	char *value;
+	int i;
+	static int initialized;
+
+	if (initialized)
+		return 0;
+	initialized = 1;
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
+	if (want_color(transport_use_color))
+		return transport_colors[ix];
+	return "";
+}
 
 static void set_upstreams(struct transport *transport, struct ref *refs,
 	int pretend)
@@ -338,7 +382,11 @@ static void print_ref_status(char flag, const char *summary,
 		else
 			fprintf(stdout, "%s\n", summary);
 	} else {
-		fprintf(stderr, " %c %-*s ", flag, summary_width, summary);
+		if (strstr(summary, "rejected") != NULL || strstr(summary, "failure") != NULL)
+			fprintf(stderr, " %s%c %-*s%s ", transport_get_color(TRANSPORT_COLOR_REJECTED),
+				flag, summary_width, summary, transport_get_color(TRANSPORT_COLOR_RESET));
+		else
+			fprintf(stderr, " %c %-*s ", flag, summary_width, summary);
 		if (from)
 			fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
 		else
@@ -487,6 +535,9 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 	char *head;
 	int summary_width = transport_summary_width(refs);
 
+	if (transport_color_config() < 0)
+		warning(_("could not parse transport.color.* config"));
+
 	head = resolve_refdup("HEAD", RESOLVE_REF_READING, NULL, NULL);
 
 	if (verbose) {
@@ -553,6 +604,9 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	struct send_pack_args args;
 	int ret;
 
+	if (transport_color_config() < 0)
+		return -1;
+
 	if (!data->got_remote_heads) {
 		struct ref *tmp_refs;
 		connect_setup(transport, 1);
@@ -997,6 +1051,9 @@ int transport_push(struct transport *transport,
 	*reject_reasons = 0;
 	transport_verify_remote_names(refspec_nr, refspec);
 
+	if (transport_color_config() < 0)
+		return -1;
+
 	if (transport->vtable->push_refs) {
 		struct ref *remote_refs;
 		struct ref *local_refs = get_local_heads();
-- 
2.16.1.windows.4
