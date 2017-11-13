Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1A9B1F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 22:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbdKMWim (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 17:38:42 -0500
Received: from mout.gmx.net ([212.227.17.22]:65047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751376AbdKMWik (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 17:38:40 -0500
Received: from bedhanger.strangled.net ([188.192.144.31]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MOSNd-1eK8882i61-005pg4; Mon, 13 Nov 2017 23:38:05 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v2 2/6] checkout: describe_detached_head: remove ellipsis after committish
Date:   Mon, 13 Nov 2017 23:36:50 +0100
Message-Id: <20171113223654.27732-2-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171113223654.27732-1-bedhanger@gmx.de>
References: <20171113223654.27732-1-bedhanger@gmx.de>
References: <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <EA775C6AB4684B7A86A88C733C132827@PhilipOakley>
X-Provags-ID: V03:K0:mHZPu7GUkb7umsybGAxvi6FlSBEBwu4YFJt0feDWZ+rm7vV/Ql3
 vmOg6qt9MQx1/wYOTlVdc3bqYpKzf2VDrBqOAQewtTkp+D14eopMEgLmil8erd3WuWlDhKk
 FQ3CQFTaMAn9RVtqTV16oig5I7jMFl2L416Sv85vTK+tcFAC1r6AxmluDHY0tYVjZYE9Y9X
 zJ6GO0yziQ/vLTN8Q0hHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x8UMTlu7ocU=:i3Rg4M2dnLpQOkyR4sj3dm
 sFNSHF2ww3EJO5unOJwzvbFzx52Lj+jr0RcaMpfwZpUYYs6vDuZcjRa1bE5ZfSJB6lFhLoe9B
 mvXjZX+OV+OMP+4pnJb3DK+HolzZSidGigAe0YxtRJkqjmTQMyiH1ikue+49yEx9/7c4gSxlB
 3J3fMTPzln9ADmyQmvqCYt49vYWjQIeFYgsvf5OX8un/lZhbuLL+4UH3LkchTaTWFYBrTBgq8
 HCIYdwMGYJ+WnxbF92tCoPT4rCXcct/BaSjVoQnt8Z+CHExiVZg0FxYjT9gxC3jTQRNTsbY3k
 eH3X47fMvd/M3/R4rvzrD+RXz8bHoaENpQvjIH6cZUATqpr/VSdONicMb5S/JAq2ppnWiwPbV
 +SrjN/8z2sSYRDn8XTu9B+rnWnicCQj64K49d2Gz63nk8W1AIye4FmDll3F3HeUkTAfLOq/NY
 W7bkKAFndN4AniUIGv16fPdv8qYnwpHnNRe8e2O9xetf+a2i5LqVxH4pMrKqiNCE1ILCQmf7T
 CBAvfpncw3oZRLBd+DAnOese6XEYqcCVVKtCW7OowIre1KqXYkX0/prz03t1DJsnHbBjITgNj
 huWkpww6xojHD9eEM1fHLBZJLPM23PDVyh1D4+SV2wzNX8lc3iQ7X/F1pe7nH0LTNfRiTupqw
 eTUftl8XLKF5iLRmVk+fw43l0cGOBTDPDcg8K80jiJ/mwUu5IMHSigg52HOHhIz9nlXW5aXj0
 DoCu6CH+JLdIDAQpWN8+XvZR0TeJIxXA5euJHPPxOLi5KhDMdYTdicj76CrNdQs9pz7ZTW80A
 HMpxL+9Ct0RREAeCPISMvSfZutUNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do not want an ellipsis displayed following an (abbreviated) SHA-1
value.

The days when this was necessary to indicate the truncation to
lower-level Git commands and/or the user are bygone.

However, to ease the transition, the ellipsis will still be printed if
the user (actively!) sets the config option core.printsha1ellipsis to
true.

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
 builtin/checkout.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6c2b4cd419a4..101a16a14a76 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -402,8 +402,13 @@ static void describe_detached_head(const char *msg, struct commit *commit)
 	struct strbuf sb = STRBUF_INIT;
 	if (!parse_commit(commit))
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
-	fprintf(stderr, "%s %s... %s\n", msg,
-		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
+	if (print_sha1_ellipsis) {
+		fprintf(stderr, "%s %s... %s\n", msg,
+			find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
+	} else {
+		fprintf(stderr, "%s %s %s\n", msg,
+			find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV), sb.buf);
+	}
 	strbuf_release(&sb);
 }
 
-- 
2.13.6

