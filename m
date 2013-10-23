From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/15] builtin/remote.c: reorder function definitions
Date: Wed, 23 Oct 2013 17:50:46 +0200
Message-ID: <1382543448-2586-14-git-send-email-mhagger@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0qc-0007Hr-9v
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab3JWP7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:59:47 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:55944 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751875Ab3JWP7p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:59:45 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Oct 2013 11:59:45 EDT
X-AuditID: 12074411-b7f426d000005455-19-5267f0b3cd4e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id E2.4E.21589.3B0F7625; Wed, 23 Oct 2013 11:52:19 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLt6009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:52:17 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqLv5Q3qQwfwJGhbTu1azWHRd6Way
	aOi9wmwx7+4uJotVt5YxW6yccYPR4vaK+cwWTzsrLea9eMFm8aOlh9mBy+Pv+w9MHpfWvWTy
	OPRnCrvHsxPtbB6XXn5n83jWu4fR4+IlZY8ZLa9ZPD5vkvM4cPkxWwBXFLdNUmJJWXBmep6+
	XQJ3xrPJ75gLXmtWzDqo1MDYodjFyMkhIWAicWHbUjYIW0ziwr31QDYXh5DAZUaJ3V+eMkM4
	V5gk/t+dwQ5SxSagK7Gop5kJxBYRUJOY2HaIBaSIWWAis8Tx6YtYQBLCAq4SEyZ+YQaxWQRU
	Je7PvcUKYvMKuEjcPXkRKM4BtE5O4uG3WJAwJ1D4wvHpYCVCAs4SExZOZZ/AyLuAkWEVo1xi
	Tmmubm5iZk5xarJucXJiXl5qka6pXm5miV5qSukmRkjQCu5gnHFS7hCjAAejEg/vw5a0ICHW
	xLLiytxDjJIcTEqivHPepQcJ8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHdcRcox5uSWFmVWpQP
	k5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4G16D9QoWJSanlqRlplTgpBm4uAEEVwg
	G3iANsSAFPIWFyTmFmemQxSdYlSUEudtAEkIgCQySvPgBsDSyytGcaB/hHkTQap4gKkJrvsV
	0GAmoMFTlqSBDC5JREhJNTCu4t2mIqcUsUgh6I+QWufjn3cPz23ulhFf2zjBhXVLMlN3/L0H
	acoz52k0L16iHiv+X3+NVidblsQut71cB04yB1QyBh7a5chV37Hu6RmvBgMdebHz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236531>

Reorder function definitions to remove the need for forward
declarations.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 159 +++++++++++++++++++++++++++----------------------------
 1 file changed, 78 insertions(+), 81 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 4e14891..ecedd96 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -77,9 +77,6 @@ static const char * const builtin_remote_seturl_usage[] = {
 
 static int verbose;
 
-static int show_all(void);
-static int prune_remote(const char *remote, int dry_run);
-
 static inline int postfixcmp(const char *string, const char *postfix)
 {
 	int len1 = strlen(string), len2 = strlen(postfix);
@@ -1084,6 +1081,64 @@ static int show_push_info_item(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
+static int get_one_entry(struct remote *remote, void *priv)
+{
+	struct string_list *list = priv;
+	struct strbuf url_buf = STRBUF_INIT;
+	const char **url;
+	int i, url_nr;
+
+	if (remote->url_nr > 0) {
+		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
+		string_list_append(list, remote->name)->util =
+				strbuf_detach(&url_buf, NULL);
+	} else
+		string_list_append(list, remote->name)->util = NULL;
+	if (remote->pushurl_nr) {
+		url = remote->pushurl;
+		url_nr = remote->pushurl_nr;
+	} else {
+		url = remote->url;
+		url_nr = remote->url_nr;
+	}
+	for (i = 0; i < url_nr; i++)
+	{
+		strbuf_addf(&url_buf, "%s (push)", url[i]);
+		string_list_append(list, remote->name)->util =
+				strbuf_detach(&url_buf, NULL);
+	}
+
+	return 0;
+}
+
+static int show_all(void)
+{
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	int result;
+
+	list.strdup_strings = 1;
+	result = for_each_remote(get_one_entry, &list);
+
+	if (!result) {
+		int i;
+
+		sort_string_list(&list);
+		for (i = 0; i < list.nr; i++) {
+			struct string_list_item *item = list.items + i;
+			if (verbose)
+				printf("%s\t%s\n", item->string,
+					item->util ? (const char *)item->util : "");
+			else {
+				if (i && !strcmp((item - 1)->string, item->string))
+					continue;
+				printf("%s\n", item->string);
+			}
+		}
+	}
+	string_list_clear(&list, 1);
+	return result;
+}
+
 static int show(int argc, const char **argv)
 {
 	int no_query = 0, result = 0, query_flag = 0;
@@ -1246,26 +1301,6 @@ static int set_head(int argc, const char **argv)
 	return result;
 }
 
-static int prune(int argc, const char **argv)
-{
-	int dry_run = 0, result = 0;
-	struct option options[] = {
-		OPT__DRY_RUN(&dry_run, N_("dry run")),
-		OPT_END()
-	};
-
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_prune_usage,
-			     0);
-
-	if (argc < 1)
-		usage_with_options(builtin_remote_prune_usage, options);
-
-	for (; argc; argc--, argv++)
-		result |= prune_remote(*argv, dry_run);
-
-	return result;
-}
-
 static int prune_remote(const char *remote, int dry_run)
 {
 	int result = 0, i;
@@ -1304,6 +1339,26 @@ static int prune_remote(const char *remote, int dry_run)
 	return result;
 }
 
+static int prune(int argc, const char **argv)
+{
+	int dry_run = 0, result = 0;
+	struct option options[] = {
+		OPT__DRY_RUN(&dry_run, N_("dry run")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, NULL, options, builtin_remote_prune_usage,
+			     0);
+
+	if (argc < 1)
+		usage_with_options(builtin_remote_prune_usage, options);
+
+	for (; argc; argc--, argv++)
+		result |= prune_remote(*argv, dry_run);
+
+	return result;
+}
+
 static int get_remote_default(const char *key, const char *value, void *priv)
 {
 	if (strcmp(key, "remotes.default") == 0) {
@@ -1505,64 +1560,6 @@ static int set_url(int argc, const char **argv)
 	return 0;
 }
 
-static int get_one_entry(struct remote *remote, void *priv)
-{
-	struct string_list *list = priv;
-	struct strbuf url_buf = STRBUF_INIT;
-	const char **url;
-	int i, url_nr;
-
-	if (remote->url_nr > 0) {
-		strbuf_addf(&url_buf, "%s (fetch)", remote->url[0]);
-		string_list_append(list, remote->name)->util =
-				strbuf_detach(&url_buf, NULL);
-	} else
-		string_list_append(list, remote->name)->util = NULL;
-	if (remote->pushurl_nr) {
-		url = remote->pushurl;
-		url_nr = remote->pushurl_nr;
-	} else {
-		url = remote->url;
-		url_nr = remote->url_nr;
-	}
-	for (i = 0; i < url_nr; i++)
-	{
-		strbuf_addf(&url_buf, "%s (push)", url[i]);
-		string_list_append(list, remote->name)->util =
-				strbuf_detach(&url_buf, NULL);
-	}
-
-	return 0;
-}
-
-static int show_all(void)
-{
-	struct string_list list = STRING_LIST_INIT_NODUP;
-	int result;
-
-	list.strdup_strings = 1;
-	result = for_each_remote(get_one_entry, &list);
-
-	if (!result) {
-		int i;
-
-		sort_string_list(&list);
-		for (i = 0; i < list.nr; i++) {
-			struct string_list_item *item = list.items + i;
-			if (verbose)
-				printf("%s\t%s\n", item->string,
-					item->util ? (const char *)item->util : "");
-			else {
-				if (i && !strcmp((item - 1)->string, item->string))
-					continue;
-				printf("%s\n", item->string);
-			}
-		}
-	}
-	string_list_clear(&list, 1);
-	return result;
-}
-
 int cmd_remote(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
-- 
1.8.4
