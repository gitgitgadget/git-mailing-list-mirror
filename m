Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381321F404
	for <e@80x24.org>; Fri,  6 Apr 2018 19:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeDFTJi (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 15:09:38 -0400
Received: from mail-sn1nam02on0112.outbound.protection.outlook.com ([104.47.36.112]:57709
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751896AbeDFTJf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 15:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ke+dBMxx35ejCXyHzk2qaUs8nD3SIS32llHmfmZ7QKY=;
 b=GDCjFyYk6fa6Y2eCJOFK7NWicdcCRKxKAmq5pVPZQBxWZYoRFiGfMwWxsxdeI0BrChzl7frXOk4NHOEkM4UnjQQriHX5EEJ4Tu9w91di36mMWV7qkKOMHz4BLUGmqV+CmXKn2xg8m7wKl7gZJtRteB7KV2NmSqW+daa8hagMKzg=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1108.namprd21.prod.outlook.com (52.132.24.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Fri, 6 Apr 2018 19:09:33 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.000; Fri, 6 Apr 2018
 19:09:33 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 1/4] treewide: rename tree to maybe_tree
Thread-Topic: [PATCH v2 1/4] treewide: rename tree to maybe_tree
Thread-Index: AQHTzdrLr9IWRxHH00+mkZQjQlbg7A==
Date:   Fri, 6 Apr 2018 19:09:32 +0000
Message-ID: <20180406190919.167092-2-dstolee@microsoft.com>
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180406190919.167092-1-dstolee@microsoft.com>
In-Reply-To: <20180406190919.167092-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:400:4::26) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1108;7:RZoU54jsOVtVpo+bwZdCNQ3i2tPAPc0sVqngoZttdgwAzD6Sr1jwKhCkFm3o1wDNq4swp4bg9PJxIDbpNaF3aslj8L1i9o0IfXzXGOYzdZQYs+siRMYnEr9MYqerjVw8a8RuY1GcTm1ie/7fcTklB8lZ/7Ds0RvX7ambpY/Ivc7mgRVYRMz3B2AuCTdCiw9ZmLdj3Wz4sWP++JD5KcbAMsvB9IIDsvEs6JqE2uElHuZ//KQqdRmXIT/nl5ACJXlj;20:QGi5THpr3JJZp2JdLwSZA++CgIXE9D/cs8/DoYARidsmoWcURgzwGhDogwD5rKfUDW/dllZfFSEdnBpgA4E2+7rrsonxk3RAXOvkHQwhVjQRTIx4FXfsRZyCkk+KjA1WV2DbvfN/s7BtaqxElJJuHBu4VNf5WZh1AA4jLlqw9x0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 456042cd-825b-4ec4-bac4-08d59bf1ed26
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1108;
x-ms-traffictypediagnostic: BL0PR2101MB1108:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1108D54D41BEC0DE42CAAD86A1BA0@BL0PR2101MB1108.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1108;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1108;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(396003)(366004)(39860400002)(189003)(199004)(22452003)(105586002)(316002)(2906002)(2501003)(5250100002)(76176011)(59450400001)(25786009)(54906003)(3280700002)(106356001)(3660700001)(14454004)(102836004)(486006)(46003)(478600001)(52116002)(99286004)(4326008)(5660300001)(6506007)(386003)(2616005)(446003)(11346002)(10290500003)(575784001)(476003)(86362001)(186003)(6486002)(2900100001)(97736004)(107886003)(39060400002)(5640700003)(6436002)(36756003)(8656006)(10090500001)(305945005)(7736002)(8676002)(6116002)(6916009)(53936002)(53946003)(8936002)(1076002)(81166006)(1730700003)(86612001)(81156014)(6512007)(2351001)(68736007)(22906009)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1108;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CcL4M9VWBHtjswOoYeMlpXAZNgt6OyWTL3hO1nPQiFlyUk9WJvz3MfxlWwmkELGc5DpZWsuhE0Ks3iJRNFsJzADedAqvW4qfEDdKA186AcHK1dUhCpRIWZk97qRSnkpEwyM+ZznE64Wj716aazq7hy6kudUe8vuneh/Tye4wInXpIMPEwj0ar8YOkISoRlmATD/c2rzvpVEwtouXFdX093AIRKx/Mu4rgWrcrLcuB9iNhT0e8oIO2SPeDzBtxtg4OrCGWq37il0e3UbvhULuyqRgjfS2gd5jJurqU0mjHns/BSpLFiirzBTsamNR5/ZH3gNbYDnYkXda5cA5TU7CpAjbGORsOrzuQsc10pI/L/oczV4n1guZAKSMnn8rMPaMXQM3uUTv0BELF3lMXWXasMkfeTGKlIlxprQbS58aicU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456042cd-825b-4ec4-bac4-08d59bf1ed26
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 19:09:32.8577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1108
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the commit-graph file to walk commit history removes the large
cost of parsing commits during the walk. This exposes a performance
issue: lookup_tree() takes a large portion of the computation time,
even when Git never uses those trees.

In anticipation of lazy-loading these trees, rename the 'tree' member
of struct commit to 'maybe_tree'. This serves two purposes: it hints
at the future role of possibly being NULL even if the commit has a
valid tree, and it allows for unambiguous transformation from simple
member access (i.e. commit->maybe_tree) to method access.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 blame.c               | 18 +++++++++---------
 builtin/checkout.c    | 12 ++++++------
 builtin/diff.c        |  2 +-
 builtin/fast-export.c |  6 +++---
 builtin/log.c         |  4 ++--
 builtin/reflog.c      |  2 +-
 commit-graph.c        |  4 ++--
 commit.c              |  2 +-
 commit.h              |  2 +-
 fsck.c                |  6 +++---
 http-push.c           |  2 +-
 line-log.c            |  4 ++--
 list-objects.c        | 10 +++++-----
 log-tree.c            |  6 +++---
 merge-recursive.c     |  5 +++--
 notes-merge.c         |  8 ++++----
 packfile.c            |  2 +-
 pretty.c              |  4 ++--
 ref-filter.c          |  2 +-
 revision.c            |  8 ++++----
 sequencer.c           | 12 ++++++------
 sha1_name.c           |  2 +-
 tree.c                |  4 ++--
 walker.c              |  2 +-
 24 files changed, 65 insertions(+), 64 deletions(-)

diff --git a/blame.c b/blame.c
index 200e0ad9a2..b78e649cac 100644
--- a/blame.c
+++ b/blame.c
@@ -553,10 +553,10 @@ static struct blame_origin *find_origin(struct commit=
 *parent,
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_oid(&origin->commit->object.oid))
-		do_diff_cache(&parent->tree->object.oid, &diff_opts);
+		do_diff_cache(&parent->maybe_tree->object.oid, &diff_opts);
 	else
-		diff_tree_oid(&parent->tree->object.oid,
-			      &origin->commit->tree->object.oid,
+		diff_tree_oid(&parent->maybe_tree->object.oid,
+			      &origin->commit->maybe_tree->object.oid,
 			      "", &diff_opts);
 	diffcore_std(&diff_opts);
=20
@@ -622,10 +622,10 @@ static struct blame_origin *find_rename(struct commit=
 *parent,
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_oid(&origin->commit->object.oid))
-		do_diff_cache(&parent->tree->object.oid, &diff_opts);
+		do_diff_cache(&parent->maybe_tree->object.oid, &diff_opts);
 	else
-		diff_tree_oid(&parent->tree->object.oid,
-			      &origin->commit->tree->object.oid,
+		diff_tree_oid(&parent->maybe_tree->object.oid,
+			      &origin->commit->maybe_tree->object.oid,
 			      "", &diff_opts);
 	diffcore_std(&diff_opts);
=20
@@ -1257,10 +1257,10 @@ static void find_copy_in_parent(struct blame_scoreb=
oard *sb,
 		diff_opts.flags.find_copies_harder =3D 1;
=20
 	if (is_null_oid(&target->commit->object.oid))
-		do_diff_cache(&parent->tree->object.oid, &diff_opts);
+		do_diff_cache(&parent->maybe_tree->object.oid, &diff_opts);
 	else
-		diff_tree_oid(&parent->tree->object.oid,
-			      &target->commit->tree->object.oid,
+		diff_tree_oid(&parent->maybe_tree->object.oid,
+			      &target->commit->maybe_tree->object.oid,
 			      "", &diff_opts);
=20
 	if (!diff_opts.flags.find_copies_harder)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d76e13c852..b15fed5d85 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -484,7 +484,7 @@ static int merge_working_tree(const struct checkout_opt=
s *opts,
=20
 	resolve_undo_clear();
 	if (opts->force) {
-		ret =3D reset_tree(new_branch_info->commit->tree, opts, 1, writeout_erro=
r);
+		ret =3D reset_tree(new_branch_info->commit->maybe_tree, opts, 1, writeou=
t_error);
 		if (ret)
 			return ret;
 	} else {
@@ -570,18 +570,18 @@ static int merge_working_tree(const struct checkout_o=
pts *opts,
 			o.verbosity =3D 0;
 			work =3D write_tree_from_memory(&o);
=20
-			ret =3D reset_tree(new_branch_info->commit->tree, opts, 1,
+			ret =3D reset_tree(new_branch_info->commit->maybe_tree, opts, 1,
 					 writeout_error);
 			if (ret)
 				return ret;
 			o.ancestor =3D old_branch_info->name;
 			o.branch1 =3D new_branch_info->name;
 			o.branch2 =3D "local";
-			ret =3D merge_trees(&o, new_branch_info->commit->tree, work,
-				old_branch_info->commit->tree, &result);
+			ret =3D merge_trees(&o, new_branch_info->commit->maybe_tree, work,
+				old_branch_info->commit->maybe_tree, &result);
 			if (ret < 0)
 				exit(128);
-			ret =3D reset_tree(new_branch_info->commit->tree, opts, 0,
+			ret =3D reset_tree(new_branch_info->commit->maybe_tree, opts, 0,
 					 writeout_error);
 			strbuf_release(&o.obuf);
 			if (ret)
@@ -1002,7 +1002,7 @@ static int parse_branchname_arg(int argc, const char =
**argv,
 		*source_tree =3D parse_tree_indirect(rev);
 	} else {
 		parse_commit_or_die(new_branch_info->commit);
-		*source_tree =3D new_branch_info->commit->tree;
+		*source_tree =3D new_branch_info->commit->maybe_tree;
 	}
=20
 	if (!*source_tree)                   /* case (1): want a tree */
diff --git a/builtin/diff.c b/builtin/diff.c
index 16bfb22f73..34f18a5f3f 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -398,7 +398,7 @@ int cmd_diff(int argc, const char **argv, const char *p=
refix)
 		if (!obj)
 			die(_("invalid object '%s' given."), name);
 		if (obj->type =3D=3D OBJ_COMMIT)
-			obj =3D &((struct commit *)obj)->tree->object;
+			obj =3D &((struct commit *)obj)->maybe_tree->object;
=20
 		if (obj->type =3D=3D OBJ_TREE) {
 			obj->flags |=3D flags;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 27b2cc138e..91e526b30d 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -578,11 +578,11 @@ static void handle_commit(struct commit *commit, stru=
ct rev_info *rev,
 	    get_object_mark(&commit->parents->item->object) !=3D 0 &&
 	    !full_tree) {
 		parse_commit_or_die(commit->parents->item);
-		diff_tree_oid(&commit->parents->item->tree->object.oid,
-			      &commit->tree->object.oid, "", &rev->diffopt);
+		diff_tree_oid(&commit->parents->item->maybe_tree->object.oid,
+			      &commit->maybe_tree->object.oid, "", &rev->diffopt);
 	}
 	else
-		diff_root_tree_oid(&commit->tree->object.oid,
+		diff_root_tree_oid(&commit->maybe_tree->object.oid,
 				   "", &rev->diffopt);
=20
 	/* Export the referenced blobs, and remember the marks. */
diff --git a/builtin/log.c b/builtin/log.c
index 94ee177d56..f603b53318 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1067,8 +1067,8 @@ static void make_cover_letter(struct rev_info *rev, i=
nt use_stdout,
=20
 	diff_setup_done(&opts);
=20
-	diff_tree_oid(&origin->tree->object.oid,
-		      &head->tree->object.oid,
+	diff_tree_oid(&origin->maybe_tree->object.oid,
+		      &head->maybe_tree->object.oid,
 		      "", &opts);
 	diffcore_std(&opts);
 	diff_flush(&opts);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 4719a5354c..b17eabc009 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -154,7 +154,7 @@ static int commit_is_complete(struct commit *commit)
 		for (i =3D 0; i < found.nr; i++) {
 			struct commit *c =3D
 				(struct commit *)found.objects[i].item;
-			if (!tree_is_complete(&c->tree->object.oid)) {
+			if (!tree_is_complete(&c->maybe_tree->object.oid)) {
 				is_incomplete =3D 1;
 				c->object.flags |=3D INCOMPLETE;
 			}
diff --git a/commit-graph.c b/commit-graph.c
index 1fc63d541b..005b4a753e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -258,7 +258,7 @@ static int fill_commit_in_graph(struct commit *item, st=
ruct commit_graph *g, uin
 	item->graph_pos =3D pos;
=20
 	hashcpy(oid.hash, commit_data);
-	item->tree =3D lookup_tree(&oid);
+	item->maybe_tree =3D lookup_tree(&oid);
=20
 	date_high =3D get_be32(commit_data + g->hash_len + 8) & 0x3;
 	date_low =3D get_be32(commit_data + g->hash_len + 12);
@@ -369,7 +369,7 @@ static void write_graph_chunk_data(struct hashfile *f, =
int hash_len,
 		uint32_t packedDate[2];
=20
 		parse_commit(*list);
-		hashwrite(f, (*list)->tree->object.oid.hash, hash_len);
+		hashwrite(f, (*list)->maybe_tree->object.oid.hash, hash_len);
=20
 		parent =3D (*list)->parents;
=20
diff --git a/commit.c b/commit.c
index 3e39c86abf..fbc092808c 100644
--- a/commit.c
+++ b/commit.c
@@ -335,7 +335,7 @@ int parse_commit_buffer(struct commit *item, const void=
 *buffer, unsigned long s
 	if (get_sha1_hex(bufptr + 5, parent.hash) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	item->tree =3D lookup_tree(&parent);
+	item->maybe_tree =3D lookup_tree(&parent);
 	bufptr +=3D tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr =3D &item->parents;
=20
diff --git a/commit.h b/commit.h
index e57ae4b583..c4d6e6e064 100644
--- a/commit.h
+++ b/commit.h
@@ -22,7 +22,7 @@ struct commit {
 	unsigned int index;
 	timestamp_t date;
 	struct commit_list *parents;
-	struct tree *tree;
+	struct tree *maybe_tree;
 	uint32_t graph_pos;
 };
=20
diff --git a/fsck.c b/fsck.c
index 5c8c12dde3..3228ca5bee 100644
--- a/fsck.c
+++ b/fsck.c
@@ -396,9 +396,9 @@ static int fsck_walk_commit(struct commit *commit, void=
 *data, struct fsck_optio
=20
 	name =3D get_object_name(options, &commit->object);
 	if (name)
-		put_object_name(options, &commit->tree->object, "%s:", name);
+		put_object_name(options, &commit->maybe_tree->object, "%s:", name);
=20
-	result =3D options->walk((struct object *)commit->tree, OBJ_TREE, data, o=
ptions);
+	result =3D options->walk((struct object *)commit->maybe_tree, OBJ_TREE, d=
ata, options);
 	if (result < 0)
 		return result;
 	res =3D result;
@@ -772,7 +772,7 @@ static int fsck_commit_buffer(struct commit *commit, co=
nst char *buffer,
 	err =3D fsck_ident(&buffer, &commit->object, options);
 	if (err)
 		return err;
-	if (!commit->tree) {
+	if (!commit->maybe_tree) {
 		err =3D report(options, &commit->object, FSCK_MSG_BAD_TREE, "could not l=
oad commit's tree %s", sha1_to_hex(tree_sha1));
 		if (err)
 			return err;
diff --git a/http-push.c b/http-push.c
index 7dcd9daf62..d83479f32f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1330,7 +1330,7 @@ static int get_delta(struct rev_info *revs, struct re=
mote_lock *lock)
 	int count =3D 0;
=20
 	while ((commit =3D get_revision(revs)) !=3D NULL) {
-		p =3D process_tree(commit->tree, p);
+		p =3D process_tree(commit->maybe_tree, p);
 		commit->object.flags |=3D LOCAL;
 		if (!(commit->object.flags & UNINTERESTING))
 			count +=3D add_send_request(&commit->object, lock);
diff --git a/line-log.c b/line-log.c
index cdc2257db5..e714969ca2 100644
--- a/line-log.c
+++ b/line-log.c
@@ -817,8 +817,8 @@ static void queue_diffs(struct line_log_data *range,
 	assert(commit);
=20
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
-	diff_tree_oid(parent ? &parent->tree->object.oid : NULL,
-		      &commit->tree->object.oid, "", opt);
+	diff_tree_oid(parent ? &parent->maybe_tree->object.oid : NULL,
+		      &commit->maybe_tree->object.oid, "", opt);
 	if (opt->detect_rename) {
 		filter_diffs_for_paths(range, 1);
 		if (diff_might_be_rename())
diff --git a/list-objects.c b/list-objects.c
index 168bef688a..bfd09f545c 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -195,7 +195,7 @@ static void mark_edge_parents_uninteresting(struct comm=
it *commit,
 		struct commit *parent =3D parents->item;
 		if (!(parent->object.flags & UNINTERESTING))
 			continue;
-		mark_tree_uninteresting(parent->tree);
+		mark_tree_uninteresting(parent->maybe_tree);
 		if (revs->edge_hint && !(parent->object.flags & SHOWN)) {
 			parent->object.flags |=3D SHOWN;
 			show_edge(parent);
@@ -212,7 +212,7 @@ void mark_edges_uninteresting(struct rev_info *revs, sh=
ow_edge_fn show_edge)
 		struct commit *commit =3D list->item;
=20
 		if (commit->object.flags & UNINTERESTING) {
-			mark_tree_uninteresting(commit->tree);
+			mark_tree_uninteresting(commit->maybe_tree);
 			if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
 				commit->object.flags |=3D SHOWN;
 				show_edge(commit);
@@ -227,7 +227,7 @@ void mark_edges_uninteresting(struct rev_info *revs, sh=
ow_edge_fn show_edge)
 			struct commit *commit =3D (struct commit *)obj;
 			if (obj->type !=3D OBJ_COMMIT || !(obj->flags & UNINTERESTING))
 				continue;
-			mark_tree_uninteresting(commit->tree);
+			mark_tree_uninteresting(commit->maybe_tree);
 			if (!(obj->flags & SHOWN)) {
 				obj->flags |=3D SHOWN;
 				show_edge(commit);
@@ -300,8 +300,8 @@ static void do_traverse(struct rev_info *revs,
 		 * an uninteresting boundary commit may not have its tree
 		 * parsed yet, but we are not going to show them anyway
 		 */
-		if (commit->tree)
-			add_pending_tree(revs, commit->tree);
+		if (commit->maybe_tree)
+			add_pending_tree(revs, commit->maybe_tree);
 		show_commit(commit, show_data);
=20
 		if (revs->tree_blobs_in_commit_order)
diff --git a/log-tree.c b/log-tree.c
index bdf23c5f7b..99499af57c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -806,7 +806,7 @@ static int log_tree_diff(struct rev_info *opt, struct c=
ommit *commit, struct log
 		return 0;
=20
 	parse_commit_or_die(commit);
-	oid =3D &commit->tree->object.oid;
+	oid =3D &commit->maybe_tree->object.oid;
=20
 	/* Root commit? */
 	parents =3D get_saved_parents(opt, commit);
@@ -831,7 +831,7 @@ static int log_tree_diff(struct rev_info *opt, struct c=
ommit *commit, struct log
 			 * we merged _in_.
 			 */
 			parse_commit_or_die(parents->item);
-			diff_tree_oid(&parents->item->tree->object.oid,
+			diff_tree_oid(&parents->item->maybe_tree->object.oid,
 				      oid, "", &opt->diffopt);
 			log_tree_diff_flush(opt);
 			return !opt->loginfo;
@@ -846,7 +846,7 @@ static int log_tree_diff(struct rev_info *opt, struct c=
ommit *commit, struct log
 		struct commit *parent =3D parents->item;
=20
 		parse_commit_or_die(parent);
-		diff_tree_oid(&parent->tree->object.oid,
+		diff_tree_oid(&parent->maybe_tree->object.oid,
 			      oid, "", &opt->diffopt);
 		log_tree_diff_flush(opt);
=20
diff --git a/merge-recursive.c b/merge-recursive.c
index 869092f7b9..67886a4ff8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -101,7 +101,7 @@ static struct commit *make_virtual_commit(struct tree *=
tree, const char *comment
 	struct commit *commit =3D alloc_commit_node();
=20
 	set_merge_remote_desc(commit, comment, (struct object *)commit);
-	commit->tree =3D tree;
+	commit->maybe_tree =3D tree;
 	commit->object.parsed =3D 1;
 	return commit;
 }
@@ -2154,7 +2154,8 @@ int merge_recursive(struct merge_options *o,
 		read_cache();
=20
 	o->ancestor =3D "merged common ancestors";
-	clean =3D merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tre=
e,
+	clean =3D merge_trees(o, h1->maybe_tree, h2->maybe_tree,
+			    merged_common_ancestors->maybe_tree,
 			    &mrtree);
 	if (clean < 0) {
 		flush_output(o);
diff --git a/notes-merge.c b/notes-merge.c
index c09c5e0e47..1d3edc8942 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -600,14 +600,14 @@ int notes_merge(struct notes_merge_options *o,
 			printf("No merge base found; doing history-less merge\n");
 	} else if (!bases->next) {
 		base_oid =3D &bases->item->object.oid;
-		base_tree_oid =3D &bases->item->tree->object.oid;
+		base_tree_oid =3D &bases->item->maybe_tree->object.oid;
 		if (o->verbosity >=3D 4)
 			printf("One merge base found (%.7s)\n",
 			       oid_to_hex(base_oid));
 	} else {
 		/* TODO: How to handle multiple merge-bases? */
 		base_oid =3D &bases->item->object.oid;
-		base_tree_oid =3D &bases->item->tree->object.oid;
+		base_tree_oid =3D &bases->item->maybe_tree->object.oid;
 		if (o->verbosity >=3D 3)
 			printf("Multiple merge bases found. Using the first "
 				"(%.7s)\n", oid_to_hex(base_oid));
@@ -634,8 +634,8 @@ int notes_merge(struct notes_merge_options *o,
 		goto found_result;
 	}
=20
-	result =3D merge_from_diffs(o, base_tree_oid, &local->tree->object.oid,
-				  &remote->tree->object.oid, local_tree);
+	result =3D merge_from_diffs(o, base_tree_oid, &local->maybe_tree->object.=
oid,
+				  &remote->maybe_tree->object.oid, local_tree);
=20
 	if (result !=3D 0) { /* non-trivial merge (with or without conflicts) */
 		/* Commit (partial) result */
diff --git a/packfile.c b/packfile.c
index b1d33b646a..3eb9c4a36e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1925,7 +1925,7 @@ static int add_promisor_object(const struct object_id=
 *oid,
 		struct commit *commit =3D (struct commit *) obj;
 		struct commit_list *parents =3D commit->parents;
=20
-		oidset_insert(set, &commit->tree->object.oid);
+		oidset_insert(set, &commit->maybe_tree->object.oid);
 		for (; parents; parents =3D parents->next)
 			oidset_insert(set, &parents->item->object.oid);
 	} else if (obj->type =3D=3D OBJ_TAG) {
diff --git a/pretty.c b/pretty.c
index f7ce490230..42095ea495 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1161,10 +1161,10 @@ static size_t format_commit_one(struct strbuf *sb, =
/* in UTF-8 */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 		return 1;
 	case 'T':		/* tree hash */
-		strbuf_addstr(sb, oid_to_hex(&commit->tree->object.oid));
+		strbuf_addstr(sb, oid_to_hex(&commit->maybe_tree->object.oid));
 		return 1;
 	case 't':		/* abbreviated tree hash */
-		strbuf_add_unique_abbrev(sb, commit->tree->object.oid.hash,
+		strbuf_add_unique_abbrev(sb, commit->maybe_tree->object.oid.hash,
 					 c->pretty_ctx->abbrev);
 		return 1;
 	case 'P':		/* parent hashes */
diff --git a/ref-filter.c b/ref-filter.c
index 45fc56216a..783a3ee6cf 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -815,7 +815,7 @@ static void grab_commit_values(struct atom_value *val, =
int deref, struct object
 		if (deref)
 			name++;
 		if (!strcmp(name, "tree")) {
-			v->s =3D xstrdup(oid_to_hex(&commit->tree->object.oid));
+			v->s =3D xstrdup(oid_to_hex(&commit->maybe_tree->object.oid));
 		}
 		else if (!strcmp(name, "numparent")) {
 			v->value =3D commit_list_count(commit->parents);
diff --git a/revision.c b/revision.c
index b42c836d7a..7d66e32e83 100644
--- a/revision.c
+++ b/revision.c
@@ -440,8 +440,8 @@ static void file_change(struct diff_options *options,
 static int rev_compare_tree(struct rev_info *revs,
 			    struct commit *parent, struct commit *commit)
 {
-	struct tree *t1 =3D parent->tree;
-	struct tree *t2 =3D commit->tree;
+	struct tree *t1 =3D parent->maybe_tree;
+	struct tree *t2 =3D commit->maybe_tree;
=20
 	if (!t1)
 		return REV_TREE_NEW;
@@ -477,7 +477,7 @@ static int rev_compare_tree(struct rev_info *revs,
 static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *co=
mmit)
 {
 	int retval;
-	struct tree *t1 =3D commit->tree;
+	struct tree *t1 =3D commit->maybe_tree;
=20
 	if (!t1)
 		return 0;
@@ -615,7 +615,7 @@ static void try_to_simplify_commit(struct rev_info *rev=
s, struct commit *commit)
 	if (!revs->prune)
 		return;
=20
-	if (!commit->tree)
+	if (!commit->maybe_tree)
 		return;
=20
 	if (!commit->parents) {
diff --git a/sequencer.c b/sequencer.c
index f9d1001dee..3b2823c8b5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -499,8 +499,8 @@ static int do_recursive_merge(struct commit *base, stru=
ct commit *next,
 	o.show_rename_progress =3D 1;
=20
 	head_tree =3D parse_tree_indirect(head);
-	next_tree =3D next ? next->tree : empty_tree();
-	base_tree =3D base ? base->tree : empty_tree();
+	next_tree =3D next ? next->maybe_tree : empty_tree();
+	base_tree =3D base ? base->maybe_tree : empty_tree();
=20
 	for (xopt =3D opts->xopts; xopt !=3D opts->xopts + opts->xopts_nr; xopt++=
)
 		parse_merge_opt(&o, *xopt);
@@ -561,7 +561,7 @@ static int is_index_unchanged(void)
 			return error(_("unable to update cache tree"));
=20
 	return !oidcmp(&active_cache_tree->oid,
-		       &head_commit->tree->object.oid);
+		       &head_commit->maybe_tree->object.oid);
 }
=20
 static int write_author_script(const char *message)
@@ -1118,7 +1118,7 @@ static int try_to_commit(struct strbuf *msg, const ch=
ar *author,
 	}
=20
 	if (!(flags & ALLOW_EMPTY) && !oidcmp(current_head ?
-					      &current_head->tree->object.oid :
+					      &current_head->maybe_tree->object.oid :
 					      &empty_tree_oid, &tree)) {
 		res =3D 1; /* run 'git commit' to display error message */
 		goto out;
@@ -1216,12 +1216,12 @@ static int is_original_commit_empty(struct commit *=
commit)
 		if (parse_commit(parent))
 			return error(_("could not parse parent commit %s"),
 				oid_to_hex(&parent->object.oid));
-		ptree_oid =3D &parent->tree->object.oid;
+		ptree_oid =3D &parent->maybe_tree->object.oid;
 	} else {
 		ptree_oid =3D the_hash_algo->empty_tree; /* commit is root */
 	}
=20
-	return !oidcmp(ptree_oid, &commit->tree->object.oid);
+	return !oidcmp(ptree_oid, &commit->maybe_tree->object.oid);
 }
=20
 /*
diff --git a/sha1_name.c b/sha1_name.c
index 735c1c0b8e..26b22cb628 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -896,7 +896,7 @@ struct object *peel_to_type(const char *name, int namel=
en,
 		if (o->type =3D=3D OBJ_TAG)
 			o =3D ((struct tag*) o)->tagged;
 		else if (o->type =3D=3D OBJ_COMMIT)
-			o =3D &(((struct commit *) o)->tree->object);
+			o =3D &(((struct commit *) o)->maybe_tree->object);
 		else {
 			if (name)
 				error("%.*s: expected %s type, but the object "
diff --git a/tree.c b/tree.c
index b224115e0f..dbc5e0be54 100644
--- a/tree.c
+++ b/tree.c
@@ -109,7 +109,7 @@ static int read_tree_1(struct tree *tree, struct strbuf=
 *base,
 				    oid_to_hex(entry.oid),
 				    base->buf, entry.path);
=20
-			oidcpy(&oid, &commit->tree->object.oid);
+			oidcpy(&oid, &commit->maybe_tree->object.oid);
 		}
 		else
 			continue;
@@ -248,7 +248,7 @@ struct tree *parse_tree_indirect(const struct object_id=
 *oid)
 		if (obj->type =3D=3D OBJ_TREE)
 			return (struct tree *) obj;
 		else if (obj->type =3D=3D OBJ_COMMIT)
-			obj =3D &(((struct commit *) obj)->tree->object);
+			obj =3D &(((struct commit *) obj)->maybe_tree->object);
 		else if (obj->type =3D=3D OBJ_TAG)
 			obj =3D ((struct tag *) obj)->tagged;
 		else
diff --git a/walker.c b/walker.c
index dffb9c8e37..1d5f3059a2 100644
--- a/walker.c
+++ b/walker.c
@@ -87,7 +87,7 @@ static int process_commit(struct walker *walker, struct c=
ommit *commit)
 	walker_say(walker, "walk %s\n", oid_to_hex(&commit->object.oid));
=20
 	if (walker->get_tree) {
-		if (process(walker, &commit->tree->object))
+		if (process(walker, &commit->maybe_tree->object))
 			return -1;
 		if (!walker->get_all)
 			walker->get_tree =3D 0;
--=20
2.17.0

