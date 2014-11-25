From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 7/7] Rename sort_string_list() to string_list_sort()
Date: Tue, 25 Nov 2014 09:02:35 +0100
Message-ID: <1416902555-10748-8-git-send-email-mhagger@alum.mit.edu>
References: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 09:10:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtBCx-0007sF-Jr
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 09:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbaKYIKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 03:10:44 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58837 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751159AbaKYIKn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 03:10:43 -0500
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Nov 2014 03:10:42 EST
X-AuditID: 12074412-f79e46d0000036b4-d5-547437b02e4a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id C5.6E.14004.0B734745; Tue, 25 Nov 2014 03:02:56 -0500 (EST)
Received: from michael.fritz.box (p5DDB361F.dip0.t-ipconnect.de [93.219.54.31])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAP82i0q027888
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 25 Nov 2014 03:02:55 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsUixO6iqLvBvCTEYMs+fouuK91MFg29V5gt
	3t5cwmhxe8V8Zot/E2osNm9uZ3Fg8/j7/gOTx85Zd9k9Fmwq9bh4Sdnj8ya5ANYobpukxJKy
	4Mz0PH27BO6Mrhtb2QvmO1Z8urKAtYHxkEkXIyeHhICJxONDx5ggbDGJC/fWs3UxcnEICVxm
	lDi5+CyUc5xJ4vG1RWwgVWwCuhKLeprBOkQE1CQmth1iASliFjjMKPF65zJ2kISwgLvE6dtr
	WEBsFgFVid+/n4DFeQVcJH50vGPtYuQAWicnsXWdN0iYU8BVYubeQ4wgthBQydp9rewTGHkX
	MDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI108vNLNFLTSndxAgJLaEdjOtPyh1iFOBgVOLh
	bThWHCLEmlhWXJl7iFGSg0lJlFfEsCREiC8pP6UyI7E4I76oNCe1+BCjBAezkghv1Dygct6U
	xMqq1KJ8mJQ0B4uSOO/Pxep+QgLpiSWp2ampBalFMFkZDg4lCV55M6ChgkWp6akVaZk5JQhp
	Jg5OkOFcUiLFqXkpqUWJpSUZ8aDYiC8GRgdIigdo725ToHbe4oLEXKAoROspRkUpcV5JkLkC
	IImM0jy4sbCE8YpRHOhLYV5fkCoeYLKB634FNJgJaHDczEKQwSWJCCmpBsapJfe2iRi8E7hp
	EuSwV01ws2aY+473Nfd1apWy1IpsZ8f8jJOLXTlvEqPS1Pdv3nivjwn1nPSPRc37fOVRJ863
	7StSfk39EMRjxBS93UL5hJ2woYeOvs+ftLmpoYJXfnqWbJvlv62VOznkZZqhhCOf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260207>

The new name is more consistent with the names of other
string_list-related functions.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt |  4 ++--
 builtin/apply.c                             |  2 +-
 builtin/receive-pack.c                      |  2 +-
 builtin/remote.c                            | 12 ++++++------
 builtin/repack.c                            |  2 +-
 connect.c                                   |  2 +-
 notes.c                                     |  2 +-
 remote.c                                    |  6 +++---
 sha1_file.c                                 |  2 +-
 string-list.c                               |  4 ++--
 string-list.h                               |  2 +-
 11 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index d51a657..c08402b 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -29,7 +29,7 @@ member (you need this if you add things later) and you should set the
   `unsorted_string_list_has_string` and get it from the list using
   `string_list_lookup` for sorted lists.
 
-. Can sort an unsorted list using `sort_string_list`.
+. Can sort an unsorted list using `string_list_sort`.
 
 . Can remove duplicate items from a sorted list using
   `string_list_remove_duplicates`.
@@ -146,7 +146,7 @@ write `string_list_insert(...)->util = ...;`.
 	ownership of a malloc()ed string to a `string_list` that has
 	`strdup_string` set.
 
-`sort_string_list`::
+`string_list_sort`::
 
 	Sort the list's entries by string value in `strcmp()` order.
 
diff --git a/builtin/apply.c b/builtin/apply.c
index 6696ea4..22218f9 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4180,7 +4180,7 @@ static int write_out_results(struct patch *list)
 	if (cpath.nr) {
 		struct string_list_item *item;
 
-		sort_string_list(&cpath);
+		string_list_sort(&cpath);
 		for_each_string_list_item(item, &cpath)
 			fprintf(stderr, "U %s\n", item->string);
 		string_list_clear(&cpath, 0);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 32fc540..d7ce643 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -964,7 +964,7 @@ static void check_aliased_updates(struct command *commands)
 			string_list_append(&ref_list, cmd->ref_name);
 		item->util = (void *)cmd;
 	}
-	sort_string_list(&ref_list);
+	string_list_sort(&ref_list);
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (!cmd->error_string)
diff --git a/builtin/remote.c b/builtin/remote.c
index 7fec170..46ecfd9 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -352,9 +352,9 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	free_refs(stale_refs);
 	free_refs(fetch_map);
 
-	sort_string_list(&states->new);
-	sort_string_list(&states->tracked);
-	sort_string_list(&states->stale);
+	string_list_sort(&states->new);
+	string_list_sort(&states->tracked);
+	string_list_sort(&states->stale);
 
 	return 0;
 }
@@ -909,7 +909,7 @@ static int get_remote_ref_states(const char *name,
 			get_push_ref_states(remote_refs, states);
 	} else {
 		for_each_ref(append_ref_to_tracked_list, states);
-		sort_string_list(&states->tracked);
+		string_list_sort(&states->tracked);
 		get_push_ref_states_noquery(states);
 	}
 
@@ -1128,7 +1128,7 @@ static int show_all(void)
 	if (!result) {
 		int i;
 
-		sort_string_list(&list);
+		string_list_sort(&list);
 		for (i = 0; i < list.nr; i++) {
 			struct string_list_item *item = list.items + i;
 			if (verbose)
@@ -1333,7 +1333,7 @@ static int prune_remote(const char *remote, int dry_run)
 
 	for_each_string_list_item(item, &states.stale)
 		string_list_append(&refs_to_prune, item->util);
-	sort_string_list(&refs_to_prune);
+	string_list_sort(&refs_to_prune);
 
 	if (!dry_run) {
 		struct strbuf err = STRBUF_INIT;
diff --git a/builtin/repack.c b/builtin/repack.c
index 2845620..0705d68 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -379,7 +379,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	if (delete_redundant) {
 		int opts = 0;
-		sort_string_list(&names);
+		string_list_sort(&names);
 		for_each_string_list_item(item, &existing_packs) {
 			char *sha1;
 			size_t len = strlen(item->string);
diff --git a/connect.c b/connect.c
index d47d0ec..16f74b0 100644
--- a/connect.c
+++ b/connect.c
@@ -93,7 +93,7 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 		parse_one_symref_info(&symref, val, len);
 		feature_list = val + 1;
 	}
-	sort_string_list(&symref);
+	string_list_sort(&symref);
 
 	for (; ref; ref = ref->next) {
 		struct string_list_item *item;
diff --git a/notes.c b/notes.c
index 5fe691d..40f4418 100644
--- a/notes.c
+++ b/notes.c
@@ -902,7 +902,7 @@ int combine_notes_cat_sort_uniq(unsigned char *cur_sha1,
 	if (string_list_add_note_lines(&sort_uniq_list, new_sha1))
 		goto out;
 	string_list_remove_empty_items(&sort_uniq_list, 0);
-	sort_string_list(&sort_uniq_list);
+	string_list_sort(&sort_uniq_list);
 	string_list_remove_duplicates(&sort_uniq_list, 0);
 
 	/* create a new blob object from sort_uniq_list */
diff --git a/remote.c b/remote.c
index f624217..ae4ecfa 100644
--- a/remote.c
+++ b/remote.c
@@ -1356,7 +1356,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 	}
 	clear_commit_marks_many(sent_tips.nr, sent_tips.tip, TMP_MARK);
 
-	sort_string_list(&dst_tag);
+	string_list_sort(&dst_tag);
 
 	/* Collect tags they do not have. */
 	for (ref = src; ref; ref = ref->next) {
@@ -1421,7 +1421,7 @@ static void prepare_ref_index(struct string_list *ref_index, struct ref *ref)
 	for ( ; ref; ref = ref->next)
 		string_list_append_nodup(ref_index, ref->name)->util = ref;
 
-	sort_string_list(ref_index);
+	string_list_sort(ref_index);
 }
 
 /*
@@ -2135,7 +2135,7 @@ struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fet
 	info.ref_count = ref_count;
 	for (ref = fetch_map; ref; ref = ref->next)
 		string_list_append(&ref_names, ref->name);
-	sort_string_list(&ref_names);
+	string_list_sort(&ref_names);
 	for_each_ref(get_stale_heads_cb, &info);
 	string_list_clear(&ref_names, 0);
 	return stale_refs;
diff --git a/sha1_file.c b/sha1_file.c
index d7f1838..30995e6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1198,7 +1198,7 @@ static void report_pack_garbage(struct string_list *list)
 	if (!report_garbage)
 		return;
 
-	sort_string_list(list);
+	string_list_sort(list);
 
 	for (i = 0; i < list->nr; i++) {
 		const char *path = list->items[i].string;
diff --git a/string-list.c b/string-list.c
index c5aa076..2f69c32 100644
--- a/string-list.c
+++ b/string-list.c
@@ -220,7 +220,7 @@ struct string_list_item *string_list_append(struct string_list *list,
 /* Yuck */
 static compare_strings_fn compare_for_qsort;
 
-/* Only call this from inside sort_string_list! */
+/* Only call this from inside string_list_sort! */
 static int cmp_items(const void *a, const void *b)
 {
 	const struct string_list_item *one = a;
@@ -228,7 +228,7 @@ static int cmp_items(const void *a, const void *b)
 	return compare_for_qsort(one->string, two->string);
 }
 
-void sort_string_list(struct string_list *list)
+void string_list_sort(struct string_list *list)
 {
 	compare_for_qsort = list->cmp ? list->cmp : strcmp;
 	qsort(list->items, list->nr, sizeof(*list->items), cmp_items);
diff --git a/string-list.h b/string-list.h
index 494eb5d..2cc5e48 100644
--- a/string-list.h
+++ b/string-list.h
@@ -85,7 +85,7 @@ struct string_list_item *string_list_append(struct string_list *list, const char
  */
 struct string_list_item *string_list_append_nodup(struct string_list *list, char *string);
 
-void sort_string_list(struct string_list *list);
+void string_list_sort(struct string_list *list);
 int unsorted_string_list_has_string(struct string_list *list, const char *string);
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string);
-- 
2.1.3
