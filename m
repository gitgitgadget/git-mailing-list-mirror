From: Brian Gianforcaro <b.gianfo@gmail.com>
Subject: [PATCH] Style fixes, add a space after if/for/while.
Date: Tue, 01 Sep 2009 01:35:10 -0400
Message-ID: <4A9CB28E.4040701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 01 07:35:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiM1d-0006Jm-DG
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 07:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbZIAFfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 01:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbZIAFfN
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 01:35:13 -0400
Received: from mail-qy0-f181.google.com ([209.85.221.181]:40252 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbZIAFfL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 01:35:11 -0400
Received: by qyk11 with SMTP id 11so3334082qyk.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 22:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=gOC3BNK5LP/b4JBEEWW9fFjhmljUD9lrr6Gf+pC6GC0=;
        b=nKDk/6A3275Sdo6dzDTI+yYoHJix7PxY9AdZv70ZtPdKy1hyYSQjK+3ZQ7BVWQWe4b
         3tMRXSeQ5gc/1FC1/lBbMDPdBfFdz+0A1ZsyBcfXmrY0G/NM9e6eIB4xnEy9v/veV9gG
         Thd2ISL8iY7p6oaydTlkQzIWSP0b4gVWtCdFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=LGSZlb790bHsA/IfgTkyqw4MYT3CV4C5NfG/iVX1EH+HmmOFqxafwJ9MCm3v8Kk6bp
         wN5Oxk6V/MBnii7JPg+EbRckj6Ix0YT+DF7Zx7ntc5ueV/+c6XPaNSWZj4mfUGm0w2hR
         TQvqK1YzCM+kmKxUBdBqBk+xSQTZRXH17WCyc=
Received: by 10.224.109.208 with SMTP id k16mr4121985qap.224.1251783313057;
        Mon, 31 Aug 2009 22:35:13 -0700 (PDT)
Received: from ?192.168.1.2? ([66.44.229.11])
        by mx.google.com with ESMTPS id 20sm2430163qyk.1.2009.08.31.22.35.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 31 Aug 2009 22:35:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127521>

The majority of code in core git appears to use a single
space after if/for/while. This is an attempt to bring more
code to this standard. These are entirely cosmetic changes.

 Signed-off-by: Brian Gianforcaro <b.gianfo@gmail.com>

---
 builtin-blame.c        |    2 +-
 builtin-clone.c        |    2 +-
 builtin-for-each-ref.c |    2 +-
 builtin-pack-objects.c |    2 +-
 builtin-remote.c       |    4 ++--
 builtin-shortlog.c     |    2 +-
 connect.c              |    2 +-
 diff.c                 |    2 +-
 pack-redundant.c       |   28 ++++++++++++++--------------
 remote.c               |    2 +-
 upload-pack.c          |    2 +-
 var.c                  |    4 ++--
 wt-status.c            |    2 +-
 13 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index fd6ca51..7512773 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1348,7 +1348,7 @@ static void get_ac_line(const char *inbuf, const char *what,
 	/*
 	 * Now, convert both name and e-mail using mailmap
 	 */
-	if(map_user(&mailmap, mail+1, mail_len-1, person, tmp-person-1)) {
+	if (map_user(&mailmap, mail+1, mail_len-1, person, tmp-person-1)) {
 		/* Add a trailing '>' to email, since map_user returns plain emails
 		   Note: It already has '<', since we replace from mail+1 */
 		mailpos = memchr(mail, '\0', mail_len);
diff --git a/builtin-clone.c b/builtin-clone.c
index 0d2b4a8..991a7ae 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -515,7 +515,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					     option_upload_pack);
 
 		refs = transport_get_remote_refs(transport);
-		if(refs)
+		if (refs)
 			transport_fetch_refs(transport, refs);
 	}
 
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index d7cc8ca..a5a83f1 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -576,7 +576,7 @@ static void populate_value(struct refinfo *ref)
 
 		if (!prefixcmp(name, "refname"))
 			refname = ref->refname;
-		else if(!prefixcmp(name, "upstream")) {
+		else if (!prefixcmp(name, "upstream")) {
 			struct branch *branch;
 			/* only local branches may have an upstream */
 			if (prefixcmp(ref->refname, "refs/heads/"))
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index c433748..c918d4b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1808,7 +1808,7 @@ static void prepare_pack(int window, int depth)
 
 static int git_pack_config(const char *k, const char *v, void *cb)
 {
-	if(!strcmp(k, "pack.window")) {
+	if (!strcmp(k, "pack.window")) {
 		window = git_config_int(k, v);
 		return 0;
 	}
diff --git a/builtin-remote.c b/builtin-remote.c
index 008abfe..0777dd7 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -385,7 +385,7 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
 				    fetch_map, 1);
-	for(ref = matches; ref; ref = ref->next)
+	for (ref = matches; ref; ref = ref->next)
 		string_list_append(abbrev_branch(ref->name), &states->heads);
 
 	free_refs(fetch_map);
@@ -484,7 +484,7 @@ static int read_remote_branches(const char *refname,
 	const char *symref;
 
 	strbuf_addf(&buf, "refs/remotes/%s", rename->old);
-	if(!prefixcmp(refname, buf.buf)) {
+	if (!prefixcmp(refname, buf.buf)) {
 		item = string_list_append(xstrdup(refname), rename->remote_branches);
 		symref = resolve_ref(refname, orig_sha1, 1, &flag);
 		if (flag & REF_ISSYMREF)
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 6a3812e..4d4a3c8 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -56,7 +56,7 @@ static void insert_one_record(struct shortlog *log,
 	/* copy author name to namebuf, to support matching on both name and email */
 	memcpy(namebuf, author, boemail - author);
 	len = boemail - author;
-	while(len > 0 && isspace(namebuf[len-1]))
+	while (len > 0 && isspace(namebuf[len-1]))
 		len--;
 	namebuf[len] = 0;
 
diff --git a/connect.c b/connect.c
index 76e5427..7945e38 100644
--- a/connect.c
+++ b/connect.c
@@ -513,7 +513,7 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 	signal(SIGCHLD, SIG_DFL);
 
 	host = strstr(url, "://");
-	if(host) {
+	if (host) {
 		*host = '\0';
 		protocol = get_protocol(url);
 		host += 3;
diff --git a/diff.c b/diff.c
index cd35e0c..e1be189 100644
--- a/diff.c
+++ b/diff.c
@@ -2691,7 +2691,7 @@ static int parse_num(const char **cp_p)
 	num = 0;
 	scale = 1;
 	dot = 0;
-	for(;;) {
+	for (;;) {
 		ch = *cp;
 		if ( !dot && ch == '.' ) {
 			scale = 1;
diff --git a/pack-redundant.c b/pack-redundant.c
index 48a12bc..a3fad74 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -55,7 +55,7 @@ static inline struct llist_item *llist_item_get(void)
 	} else {
 		int i = 1;
 		new = xmalloc(sizeof(struct llist_item) * BLKSIZE);
-		for(;i < BLKSIZE; i++) {
+		for (;i < BLKSIZE; i++) {
 			llist_item_put(&new[i]);
 		}
 	}
@@ -64,7 +64,7 @@ static inline struct llist_item *llist_item_get(void)
 
 static void llist_free(struct llist *list)
 {
-	while((list->back = list->front)) {
+	while ((list->back = list->front)) {
 		list->front = list->front->next;
 		llist_item_put(list->back);
 	}
@@ -146,7 +146,7 @@ static inline struct llist_item *llist_insert_sorted_unique(struct llist *list,
 		if (cmp > 0) { /* we insert before this entry */
 			return llist_insert(list, prev, sha1);
 		}
-		if(!cmp) { /* already exists */
+		if (!cmp) { /* already exists */
 			return l;
 		}
 		prev = l;
@@ -168,7 +168,7 @@ redo_from_start:
 		int cmp = hashcmp(l->sha1, sha1);
 		if (cmp > 0) /* not in list, since sorted */
 			return prev;
-		if(!cmp) { /* found */
+		if (!cmp) { /* found */
 			if (prev == NULL) {
 				if (hint != NULL && hint != list->front) {
 					/* we don't know the previous element */
@@ -218,7 +218,7 @@ static inline struct pack_list * pack_list_insert(struct pack_list **pl,
 static inline size_t pack_list_size(struct pack_list *pl)
 {
 	size_t ret = 0;
-	while(pl) {
+	while (pl) {
 		ret++;
 		pl = pl->next;
 	}
@@ -396,7 +396,7 @@ static size_t get_pack_redundancy(struct pack_list *pl)
 		return 0;
 
 	while ((subset = pl->next)) {
-		while(subset) {
+		while (subset) {
 			ret += sizeof_union(pl->pack, subset->pack);
 			subset = subset->next;
 		}
@@ -427,7 +427,7 @@ static void minimize(struct pack_list **min)
 
 	pl = local_packs;
 	while (pl) {
-		if(pl->unique_objects->size)
+		if (pl->unique_objects->size)
 			pack_list_insert(&unique, pl);
 		else
 			pack_list_insert(&non_unique, pl);
@@ -479,7 +479,7 @@ static void minimize(struct pack_list **min)
 	*min = min_perm;
 	/* add the unique packs to the list */
 	pl = unique;
-	while(pl) {
+	while (pl) {
 		pack_list_insert(min, pl);
 		pl = pl->next;
 	}
@@ -516,7 +516,7 @@ static void cmp_local_packs(void)
 	struct pack_list *subset, *pl = local_packs;
 
 	while ((subset = pl)) {
-		while((subset = subset->next))
+		while ((subset = subset->next))
 			cmp_two_packs(pl, subset);
 		pl = pl->next;
 	}
@@ -608,23 +608,23 @@ int main(int argc, char **argv)
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if(!strcmp(arg, "--")) {
+		if (!strcmp(arg, "--")) {
 			i++;
 			break;
 		}
-		if(!strcmp(arg, "--all")) {
+		if (!strcmp(arg, "--all")) {
 			load_all_packs = 1;
 			continue;
 		}
-		if(!strcmp(arg, "--verbose")) {
+		if (!strcmp(arg, "--verbose")) {
 			verbose = 1;
 			continue;
 		}
-		if(!strcmp(arg, "--alt-odb")) {
+		if (!strcmp(arg, "--alt-odb")) {
 			alt_odb = 1;
 			continue;
 		}
-		if(*arg == '-')
+		if (*arg == '-')
 			usage(pack_redundant_usage);
 		else
 			break;
diff --git a/remote.c b/remote.c
index c3ada2d..4b5b905 100644
--- a/remote.c
+++ b/remote.c
@@ -1038,7 +1038,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 0:
 		if (!memcmp(dst_value, "refs/", 5))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
-		else if((dst_guess = guess_ref(dst_value, matched_src)))
+		else if ((dst_guess = guess_ref(dst_value, matched_src)))
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 		else
 			error("unable to push to unqualified destination: %s\n"
diff --git a/upload-pack.c b/upload-pack.c
index 4d8be83..dacbc76 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -427,7 +427,7 @@ static int get_common_commits(void)
 
 	save_commit_buffer = 0;
 
-	for(;;) {
+	for (;;) {
 		int len = packet_read_line(0, line, sizeof(line));
 		reset_timeout();
 
diff --git a/var.c b/var.c
index 7362ed8..a807dea 100644
--- a/var.c
+++ b/var.c
@@ -21,7 +21,7 @@ static struct git_var git_vars[] = {
 static void list_vars(void)
 {
 	struct git_var *ptr;
-	for(ptr = git_vars; ptr->read; ptr++) {
+	for (ptr = git_vars; ptr->read; ptr++) {
 		printf("%s=%s\n", ptr->name, ptr->read(IDENT_WARN_ON_NO_NAME));
 	}
 }
@@ -31,7 +31,7 @@ static const char *read_var(const char *var)
 	struct git_var *ptr;
 	const char *val;
 	val = NULL;
-	for(ptr = git_vars; ptr->read; ptr++) {
+	for (ptr = git_vars; ptr->read; ptr++) {
 		if (strcmp(var, ptr->name) == 0) {
 			val = ptr->read(IDENT_ERROR_ON_NO_NAME);
 			break;
diff --git a/wt-status.c b/wt-status.c
index 63598ce..3395456 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -326,7 +326,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	setup_standard_excludes(&dir);
 
 	fill_directory(&dir, NULL);
-	for(i = 0; i < dir.nr; i++) {
+	for (i = 0; i < dir.nr; i++) {
 		struct dir_entry *ent = dir.entries[i];
 		if (!cache_name_is_other(ent->name, ent->len))
 			continue;
-- 
1.6.3.3
