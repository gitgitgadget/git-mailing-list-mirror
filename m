Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F037C207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 21:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425758AbdD1VcH (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 17:32:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:56380 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422822AbdD1VcF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 17:32:05 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMHaL-1dBd591ywf-007z2g; Fri, 28
 Apr 2017 23:31:58 +0200
Date:   Fri, 28 Apr 2017 23:31:42 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 03/10] rebase -i: remove useless indentation
In-Reply-To: <cover.1493414945.git.johannes.schindelin@gmx.de>
Message-ID: <fefd59fb626a9a0ddd6c9bc3a7a42d6d1016b4c3.1493414945.git.johannes.schindelin@gmx.de>
References: <cover.1493207864.git.johannes.schindelin@gmx.de> <cover.1493414945.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6rYUoD0CRX7u9Vj47KZPuVgM9kOI8GRM1Nq32hAosyGMUiSTqmb
 tX0nFJKPlZyqmdtZMaGmNeoS3+9e60rKs6ga8eHBaEW+6InrQ0R02eY1C4gyv01dYbwmwL6
 bVjNYbnNPHgR8hXs1FO6+WiajWLjKw8vozpHv304kNNC/g6TTkGz5nBh/O6J6gtwVhnJMMy
 OuDlhULrOw6sQLlyfSxWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MHyA/n78utc=:DlPDsYDDGKVzU5sEFWd4TM
 sRATsFjYQxO2bQj0rNy5kH2hKOFXVtizFhMV3p9DBHuG7Gnr8oq13vlswfiMGRBCi8a9vwoIw
 ExCeiF0vLplVgxwC3Yn4dPCzXHTT5+0Vir4Fp9sY6Yz+hw9uhDREVnsPalb+wRpFf9edCEinq
 PwPjEykvAQbrf+kbFNg+WK4EWi0UOVJuG3ae5RHUyNzrvJwByFqY1jfhhLiUIG6EQLaawjzvs
 zu7RN246iwEm5M+FrStgJty4hHOQ+yuVwwwkuW5Flawj2HN3DiLP9fzkqm0FeVEP0Rl49BUGo
 QatSnwvCWDayd7GQ9ZU78Xen9g+YYeXWi5Fk/+LZWq9Tjd167ShYv3jjVH/6CSwgU6vNA+8ak
 bm3yc6MTjv4tSOJ6nkG6WFSWkmP/oWV0cbgcCMpiX/SL90v9sf/jnqDdgatNjSWhUcNQ0ynCs
 3//eLMoTt548jGMIG7P46FKDOrJnWkh0FMfc2lJU4GiQrr0VVBCOy7g7odsBIKCaIrz5T5FKv
 iyH22cu0Xq5MC6lWLafcpP6D1b5r4EKPSLoya+Use1Tqm+yPgXwd/1ZmPLZ3dqqW2JvimN8wj
 EtIHaGd5CdfihbUe/BeaudjcgE7IEUKa5bUpInwlVAhVhIiQ60azHcRUtt8AiZuT25/sAn2xA
 9Z16Fce6MLDzZI/k1TMBU1W50Hin5ohxC08j9LNbRLOVFfAlmk5acYTUJ7TWWNhQq5LyJjjEv
 1Nq1R8Rljm6mC2iXNQdXYdZlmS+zKXjm9EqOC1nvS+X+jUjadSGPoOovfmajAss6coaNl7GVS
 tS8Hroq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commands used to be indented, and it is nice to look at, but when we
transform the SHA-1s, the indentation is removed. So let's do away with it.

For the moment, at least: when we will use the upcoming rebase--helper
to transform the SHA-1s, we *will* keep the indentation and can
reintroduce it. Yet, to be able to validate the rebase--helper against
the output of the current shell script version, we need to remove the
extra indentation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 609e150d38f..c40b1fd1d2e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -155,13 +155,13 @@ reschedule_last_action () {
 append_todo_help () {
 	gettext "
 Commands:
- p, pick = use commit
- r, reword = use commit, but edit the commit message
- e, edit = use commit, but stop for amending
- s, squash = use commit, but meld into previous commit
- f, fixup = like \"squash\", but discard this commit's log message
- x, exec = run command (the rest of the line) using shell
- d, drop = remove commit
+p, pick = use commit
+r, reword = use commit, but edit the commit message
+e, edit = use commit, but stop for amending
+s, squash = use commit, but meld into previous commit
+f, fixup = like \"squash\", but discard this commit's log message
+x, exec = run command (the rest of the line) using shell
+d, drop = remove commit
 
 These lines can be re-ordered; they are executed from top to bottom.
 " | git stripspace --comment-lines >>"$todo"
-- 
2.12.2.windows.2.800.gede8f145e06


