Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FCCF205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756335AbdABP2P (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:28:15 -0500
Received: from mout.gmx.net ([212.227.17.21]:58578 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755648AbdABP2M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:28:12 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MX19U-1c33aY141k-00W0GB; Mon, 02
 Jan 2017 16:27:54 +0100
Date:   Mon, 2 Jan 2017 16:27:53 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 17/38] sequencer (rebase -i): update refs after a successful
 rebase
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <ff57bff73a0d9a6cc961fdf00a608f3d554bb719.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:A/a9YnHyXhscPJ+ldvyGhgQ+paOLNVgEp2xyHxZcmqydhWC4Ne9
 pUiFJhy6sZO/eOR9h949s9ee9PVOD7ixxIDdy6vX1g3qEcVHRhtKsXt4Uy/abZjfJnMIAUf
 EPI+3Q+Dnw87V7KKFQ5gerWqZwKAg/Xf2zEA/rYXGo56G/CsaOHyh+RrJvvARCZ6npsURlv
 mqq96C8qQ4nE2WRoV/yeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yDTBZ38/52c=:wwHLs9nULdwPTSfDwUYxTR
 5nLofouDWoo+I/8JbMKPed8ipvjBsopUeK+vfaUT4oMfdSu8Zea4al6ocZG/m1NXBlcGtmSW7
 bxMw8GBBDsVwhWAIRd1JNj2U3qTY/vrX9t4ocU5dH3FBsKptRmxpvV98BAb26vj9A6xX3Fsda
 JErcje5cProd1pQaQGdo/2SNX56tQkJTqrzjN11dxZsssgkfu5GF3POkZ2g+PobJB4JlNFuna
 vVwCP30OevqDi2bnqYx6MtilNeRppiM9EQ0Dfv4M4JvHjmrX5osUnXjx5KL9z19BOisI+AwxK
 IbEt3hdPq/0RzbeStp73MIicH/rxBQSE7Jz7QIxwPGsFPrtWC+mviwKH8wmq1GjwwoGmdZpZs
 w/EwAd3HVwvyEYWZh/BFGJHxbnsc9aeF3H3ln30YLAuoqY0aQGl1cmzq8EwwvUr7ldrakmXlN
 NiET4XNRnNNeU8h2nEFuXZAo/TpGd91N7VpkuSj5azmF6789jBWW+R5E18bou11rEeBAivpV+
 V26bL5vf6A2KXgk2DohMDuCSqqwJdasc/aAmFOu4EO0WrW6ewsAFgjRtEoLawepaSnbLcDKF5
 2BOt3w7mZb6AFQGUt80n20I85iOvqF4MaHj9uv55PHRmKvZGJdhpqQj2+qPRduUozWlm01ggC
 AjWTHnNus5vk3npFpmYA/HcdIQ10vNd1ZSkX4dxmx/N/mdGR7+tlWAehFUFZ9dAxWKT0fD0hg
 0QXYN0tORU7Ycmgc7/etbsOtom9JCxP9+EV65ixukLTUrTRepLUDOpc7CTo/sJ2B+e8FB24fj
 biIktmWqUr5HKydNL7HmklpDqLOIKFdrhoKm4hEmYe2BEg9NYsX07XtC0x6bXB3MN0MifWlYw
 W1OEeo0g5mQInMZq+DGkyV+oEWsanNMNxlqlfmxEKpt63RgCm5xq8H3Ash5v3zdgzcGjCphbR
 Fs0F+WWvxk81eY0ksl7UfSBk1teXwNUtLd+C5r4mFlaPbUEcvkLC/stdayYumUUJCH2BtXwCK
 N1UZI1tGXTA5BZU/Q5v+fl4Hopc1uqdEDMyilrC1NUd5UDTVgXUnY1Qq2nEx0PfumQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An interactive rebase operates on a detached HEAD (to keep the reflog
of the original branch relatively clean), and updates the branch only
at the end.

Now that the sequencer learns to perform interactive rebases, it also
needs to learn the trick to update the branch before removing the
directory containing the state of the interactive rebase.

We introduce a new head_ref variable in a wider scope than necessary at
the moment, to allow for a later patch that prints out "Successfully
rebased and updated <ref>".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 6a840216b1..80b2b2a975 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -102,6 +102,8 @@ static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
+static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
+static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
 
 static inline int is_rebase_i(const struct replay_opts *opts)
 {
@@ -1784,12 +1786,53 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 	}
 
 	if (is_rebase_i(opts)) {
-		struct strbuf buf = STRBUF_INIT;
+		struct strbuf head_ref = STRBUF_INIT, buf = STRBUF_INIT;
 
 		/* Stopped in the middle, as planned? */
 		if (todo_list->current < todo_list->nr)
 			return 0;
 
+		if (read_oneliner(&head_ref, rebase_path_head_name(), 0) &&
+				starts_with(head_ref.buf, "refs/")) {
+			unsigned char head[20], orig[20];
+			int res;
+
+			if (get_sha1("HEAD", head)) {
+				res = error(_("cannot read HEAD"));
+cleanup_head_ref:
+				strbuf_release(&head_ref);
+				strbuf_release(&buf);
+				return res;
+			}
+			if (!read_oneliner(&buf, rebase_path_orig_head(), 0) ||
+					get_sha1_hex(buf.buf, orig)) {
+				res = error(_("could not read orig-head"));
+				goto cleanup_head_ref;
+			}
+			strbuf_addf(&buf, "rebase -i (finish): %s onto ",
+				head_ref.buf);
+			if (!read_oneliner(&buf, rebase_path_onto(), 0)) {
+				res = error(_("could not read 'onto'"));
+				goto cleanup_head_ref;
+			}
+			if (update_ref(buf.buf, head_ref.buf, head, orig,
+					REF_NODEREF, UPDATE_REFS_MSG_ON_ERR)) {
+				res = error(_("could not update %s"),
+					head_ref.buf);
+				goto cleanup_head_ref;
+			}
+			strbuf_reset(&buf);
+			strbuf_addf(&buf,
+				"rebase -i (finish): returning to %s",
+				head_ref.buf);
+			if (create_symref("HEAD", head_ref.buf, buf.buf)) {
+				res = error(_("could not update HEAD to %s"),
+					head_ref.buf);
+				goto cleanup_head_ref;
+			}
+			strbuf_reset(&buf);
+		}
+
 		if (opts->verbose) {
 			struct rev_info log_tree_opt;
 			struct object_id orig, head;
@@ -1810,6 +1853,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			}
 		}
 		strbuf_release(&buf);
+		strbuf_release(&head_ref);
 	}
 
 	/*
-- 
2.11.0.rc3.windows.1


