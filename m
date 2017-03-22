Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CCEE20323
	for <e@80x24.org>; Wed, 22 Mar 2017 15:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760685AbdCVPCD (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 11:02:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:60964 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760665AbdCVPBn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 11:01:43 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8NWM-1busFr2tOs-00w0OM; Wed, 22
 Mar 2017 16:01:33 +0100
Date:   Wed, 22 Mar 2017 16:01:19 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 1/3] t7504: document regression: reword no longer calls
 commit-msg
In-Reply-To: <cover.1490194846.git.johannes.schindelin@gmx.de>
Message-ID: <773531a3892fb78e8f70e540fc000bceb2c1bb7b.1490194846.git.johannes.schindelin@gmx.de>
References: <cover.1490194846.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZzVylD2Qcx8uv/6ICaF7kwrhjKpQX+bRsFMh8WDR+UlM9K+FNYq
 ykAMoSiL+Ojk0vsrtYE848BBNHMwrEAHp95WNc6L9OIDLUr9ECKlrjWSjiRSZzbxvu+b6+a
 cdv6wf7BgC7fmas7NOAV1hOwRoRwrA27S+j6OYmPniEKg7TDWihm0hx3cPkT4erfTpVdkG6
 ClnTy0sMfZT1lVNrH6iuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KLox/C+davc=:TE71lZllp5+/2OxZGbJDr3
 duGIzYeowzm+PK4Y71uKJ4JY7jEelg3zzoRXjSKGuJthMnjS0UyJ9/9SsAflWDqEpGIQO6RQx
 70f+Xd9Vra9FU660KLW82Dw4dZrBabL6A/MhZYeHwJE2cocXsGEjpQnqvKGnrG7aIbSWv1xmV
 DcovajjeMCB/mGA7tpQGhsLGDdYsXy/98YUp4MCDiwoCHqEZxvq0lAYlD/NFGg8MTvJydjr5K
 MPE4CLllV8OI382pIrkhfIvZ3WbEM/ynVr/dE0VEPBYDGqI/E1iqhkkp5fnxA5L3ASIODyXwQ
 8gtqY94c4nxROFGo51Y7wbCNzHHDEZ9ginuBKI+QhLQzpVBqVI2rxTWws8Y0U30y4oB3268jP
 1SIGsq2OCqAFJmZlvIJbpfd5MUzwemQfnrD8viamcphQAhBGoxAG+AR9PNNkAfhg3Y2TAUrxq
 eIlbQ+5G5R7rdn/SXjI8iP/sB9AS5tuL8emfMhxBkYNR98VBCee8ZZmvgRUD7tz8O+j8UyADv
 E+/w4ZEBy/oboofLPFLt9l6bKhMMZepCIp/h9aYLrestlPAo4yOCdYLSO+XcqBc6Owv2P9C+N
 K3xtSPGlcIk3jx4mMQzH68iG3Lg09ySq4HJVKvkj6Q0TvTi5PMKt3K+9a0gmplsO0LijibOm0
 7+O3ZwyQBgcgdVtAhxzj6+yyjLTqz6vXo+my5xC64ZN0uc/+l1dRjG7xPTKpEG+PKb3BJzTPK
 rg/FmhKcSx85UjBxZ0YrGKZo8DuJyZF+XqxjTMHGDAtYG0Eui3tceUqnmtUhoNtAQ1i4WrO5M
 bpkXARTTPdB9d/eSET2jAYn1ct6GQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `reword` command of an interactive rebase used to call the
commit-msg hooks, but that regressed when we switched to the
rebase--helper backed by the sequencer.

Noticed by Sebastian Schuberth.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7504-commit-msg-hook.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 8728db61d38..c3d9ab02a3b 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -220,4 +220,21 @@ test_expect_success "hook doesn't edit commit message (editor)" '
 
 '
 
+# set up fake editor to replace `pick` by `reword`
+cat > reword-editor <<'EOF'
+#!/bin/sh
+mv "$1" "$1".bup &&
+sed 's/^pick/reword/' <"$1".bup >"$1"
+EOF
+chmod +x reword-editor
+REWORD_EDITOR="$(pwd)/reword-editor"
+export REWORD_EDITOR
+
+test_expect_failure 'hook is called for reword during `rebase -i`' '
+
+	GIT_SEQUENCE_EDITOR="\"$REWORD_EDITOR\"" git rebase -i HEAD^ &&
+	commit_msg_is "new message"
+
+'
+
 test_done
-- 
2.12.1.windows.1


