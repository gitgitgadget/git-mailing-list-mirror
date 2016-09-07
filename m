Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CC8D1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 15:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756271AbcIGPUP (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 11:20:15 -0400
Received: from mout.gmx.net ([212.227.17.21]:58821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756589AbcIGPUI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 11:20:08 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MSMr9-1bbvUR3Kwd-00TSSO; Wed, 07 Sep 2016 17:20:00
 +0200
Date:   Wed, 7 Sep 2016 17:19:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ralf Thielow <ralf.thielow@gmail.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug? ran into a "fatal" using interactive rebase
In-Reply-To: <CAN0XMO+ZOV3M02wJ_=oMPbN4ch-=7gA_pXEegfHApvSNeOu3KA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1609071714540.129229@virtualbox>
References: <CAN0XMO+ZOV3M02wJ_=oMPbN4ch-=7gA_pXEegfHApvSNeOu3KA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fKMhuDWeozG6IfaeKRBf59GSTprypCcwfUa8VC06ChTiF++JAoE
 35VYKJxQdHnniGV1PvRfgPlOYCCiV6vhTFxONJlHT/EnyPUjMzi3XjPO8kY7pxEi79AYEJn
 OWZZZzReo5DYI8KUksmklMdHTpnDXTgJHNJRBHKNTNCNQlHQOWUTOWtoEBGj1obF7JIp1NC
 Yvtkv3OAwasW6wa/922gQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yVUx5gME6x4=:uprM0WNibFJXpb4EgdzQao
 7kafUpM4xfTZ7q7SMe/kBLV25vpqw4mnYRqS6eBPeUtSHyMc6BapthHC+1mdNLfvq8eDlyA4z
 qv9/PfAlw2TX/kMphv1DGTwWOIAex+mD8o8G6e/pvhjdAdnvzsL49IrfDI/DMny8+1F7USOyh
 WmAng/mtAHQT48b+/s7rzPFWOlBsSyQ59sBbUU9wMLDmDVC8yg84VBsARJFTurWyiY0R3oyQQ
 0KpTAmTyblsF7U9ZfkJ5trrM5OuJy+mxPw6KBro07Zm9O5vpBiD7gcDfL9sATO3T2gGSy3Kyi
 iAB3vxdm6uJvn9KNo3M+/JA5sQF0oOOxT/eFk+DgCyq7uM/wrlnaVPlIrMim0EwbdsMgDzxJl
 SPjA9nGIIthSG+ZmaB/xAzd4E0HLTwkBeRdpnD23pIU+89zJqp0Muzd0LuauDJ9p3CPgwEr1w
 WPmNO6IzELjcGPM8kxGiWks3Rqlw4A7Uqi9ZILlPfjzWKgNvqzBSEXk7+fswGwAPVCd+6UE7w
 vOkKfd8M1BBNlwNQqzmb2y4ZD+5Dbf7WyKAhkHtEsm6axWE0uI+CIGt2vORIkVPnx8u7ElGqX
 A2/9UliFC6lBZDtfEvmLhchRLGP8aAzn1PV6OqeL+eAkExaAjZtz4HWSUhSSKEuLwfEDerC1s
 lPwjY9Ua6t0en90aS7t3+lxQxUkKwWU6I2SKWfS/tpBuNenzlQClbk83sDt+DYmUJZPgcaS/t
 6x0nRbY/8lZT4+a2g1rCwTNWyaCD7YoXma5GW7xqKFTq+DuSCx9fnCuKCMFZhTF6OocLdWGPh
 Wa9Mn5z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

On Tue, 6 Sep 2016, Ralf Thielow wrote:

> today I accidentally triggered a "fatal" using interactive rebase.
> 
> If you edit the instruction sheet after 'rebase -i' and add an unknown
> command, Git stops because it doesn't know the command.
> That's fine, however, now we are in a state where 'git status' fails with
> 
> interactive rebase in progress; onto 311f279
> fatal: Could not open file .git/rebase-merge/done for reading: No such
> file or directory

There was some discussion revolving around this (IIRC Matthieu was
involved, hence I Cc:ed him) and I was under the impression that we fixed
the status code not to assume the presence of the "done" file.

Apparently I was wrong...

So, something like this should help (if you are interested in seeing this
patch included, please run with it, as I am running short on time):

-- snipsnap --
diff --git a/wt-status.c b/wt-status.c
index 6225a2d..8e4d999 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1072,14 +1072,17 @@ static void abbrev_sha1_in_line(struct strbuf *line)
 	strbuf_list_free(split);
 }
 
-static void read_rebase_todolist(const char *fname, struct string_list *lines)
+static void read_rebase_todolist(const char *fname, struct string_list *lines, int gently)
 {
 	struct strbuf line = STRBUF_INIT;
 	FILE *f = fopen(git_path("%s", fname), "r");
 
-	if (!f)
+	if (!f) {
+		if (gently)
+			return;
 		die_errno("Could not open file %s for reading",
 			  git_path("%s", fname));
+	}
 	while (!strbuf_getline_lf(&line, f)) {
 		if (line.len && line.buf[0] == comment_line_char)
 			continue;
@@ -1102,8 +1105,8 @@ static void show_rebase_information(struct wt_status *s,
 		struct string_list have_done = STRING_LIST_INIT_DUP;
 		struct string_list yet_to_do = STRING_LIST_INIT_DUP;
 
-		read_rebase_todolist("rebase-merge/done", &have_done);
-		read_rebase_todolist("rebase-merge/git-rebase-todo",
		&yet_to_do);
+		read_rebase_todolist("rebase-merge/done", &have_done, 1);
+		read_rebase_todolist("rebase-merge/git-rebase-todo", &yet_to_do, 0);
 
 		if (have_done.nr == 0)
 			status_printf_ln(s, color, _("No commands done."));



