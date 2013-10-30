From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/23] builtin/remote.c: reorder function definitions
Date: Wed, 30 Oct 2013 06:33:02 +0100
Message-ID: <1383111192-23780-14-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:41:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOXP-0007TT-QF
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162Ab3J3Flp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:41:45 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:61764 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753040Ab3J3Flm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:41:42 -0400
X-AuditID: 12074412-b7fc96d0000023d5-5c-52709a5e960e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 7D.D2.09173.E5A90725; Wed, 30 Oct 2013 01:34:22 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIO014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:34:20 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqBs3qyDIoOmqlMX0rtUsFl1Xupks
	GnqvMFvMu7uLyWLVrWXMFitn3GC0uL1iPrPF085Ki3kvXrBZ/GjpYXbg8vj7/gOTx6V1L5k8
	Dv2Zwu7x7EQ7m8ell9/ZPJ717mH0uHhJ2WNGy2sWj8+b5DwOXH7MFsAVxW2TlFhSFpyZnqdv
	l8CdsfLuCZaCt5oVu29dZ2pg7FLsYuTkkBAwkZj/eSIjhC0mceHeerYuRi4OIYHLjBKti9dA
	OVeYJK5dnckKUsUmoCuxqKeZCcQWEVCTmNh2iAWkiFlgIrPE8emLWEASwgIeEp0bzrKD2CwC
	qhJL5/eBNfMKuEo8OHmfHWKdgsSN5qlgcU6g+KddN8HiQgIuEk3tn9knMPIuYGRYxSiXmFOa
	q5ubmJlTnJqsW5ycmJeXWqRrppebWaKXmlK6iRESuEI7GNeflDvEKMDBqMTDa/AgP0iINbGs
	uDL3EKMkB5OSKG/alIIgIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8048DlfOmJFZWpRblw6Sk
	OViUxHl/Llb3ExJITyxJzU5NLUgtgsnKcHAoSfAqzwQaKliUmp5akZaZU4KQZuLgBBFcIBt4
	gDbwgBTyFhck5hZnpkMUnWJUlBLnVQBJCIAkMkrz4AbAUswrRnGgf4Qh2nmA6Qmu+xXQYCag
	wXtY8kAGlyQipKQaGBO/3A9ae+PY1EvtHe//yyWwT2h/8p4rNMgtP/PJpg62rY+LnHtfTxf0
	nCTwP9eBs/dae6z0Tv+5LPdL116071vqx7k9Z/GJa6dObPwe/uNBnoPH4S7+DoMs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236973>

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
1.8.4.1
