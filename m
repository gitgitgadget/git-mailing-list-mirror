Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127071F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeACQzA (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:55:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:64641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbeACQy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:54:58 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.20]) by
 mail.gmx.com (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MdFwl-1eFWPd3CLL-00ITCL; Wed, 03 Jan 2018 17:54:54 +0100
Date:   Wed, 3 Jan 2018 17:54:54 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] t0302 & t3900: add forgotten quotes
In-Reply-To: <cover.1514998470.git.johannes.schindelin@gmx.de>
Message-ID: <2b7912156d94eff38c130403fcf831b5f8d5bd4d.1514998471.git.johannes.schindelin@gmx.de>
References: <cover.1514998470.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:E7sJGK1cQGScxaYSjLLJ0eqPsmf+O+Dow1XIRAYWico1SBQYUrV
 hF9omeiy0l1UdsTjugC+UK4v3QF+lYinrdZW7FGhm+6dxbORupjPhE/Q4YxLNiCvxWePDKY
 Ki9XUHB5cD7/62G6sylQMUVCkGIcSZEQKwq5X63fBIu+j1H/MMnUgNIpIbC9qo9r1TiqVmt
 V+/g52m0LAXv8DBVb54hg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R29uzScujIw=:fEEZcR7NQkhZcH0vAWdXeL
 UYuQFZBXU59i77LtKEvz4AiH9MzQQxjJHd3Kf4adJOFmMbEjCze3UMEqJ8GBket4dm76ZIPLP
 vCz9E1QhL8brfQx5c+IPsg/hbZF+UOdC1WY9+XlItRUAMlXA0cdkpmw4eSR98O6zdDbCYOjhU
 cvr5W5SgSegPJddCzxzSIIuH8YuHwkb9LJP1WwUGLGoX4BkMATBTdjOkxk/eJfPTUPMPD9Drq
 s/KgSnhdbYJrx6O3CR3Gq6gT14IYbeixZoNIaodnMf8LMxpBSyDNEfw+zcq253FLCY5NV8OiM
 cy+9JkgGHW8a5KIR5m/0K3rvAkIe9n9jchjNRPIf56vv5q9FT/1TV5BQJFVbOgf78BN5Ts8ke
 PP8vHPIRSmqipy8cjyRKLw88XOYVaz14yyU0CTnV+DgUTAmHI0TqExuUR5JqnmKc7znPpLPF4
 kjbS6v4Sn9mdoUa4OeioJ4ixU6CXrFfvnlCAZ3ScfyYwhVaeVSvj5yltsVEUHPzdJWmTWwrXt
 pZYfQUY9Nt4jeuJlQFtf/Xvp0/gN9KOWydot5U5GL60584XcSitb7KlPZI5GWIHUSfpa7upI5
 Yb9U3sk9ZnhZ2vJxTvuYXUcv91zEH1JVt4HgmX74U8uyQqEz1He3l0EYEeIrw+EgDNwoajfJh
 kHCRMNLo6uSmAtX9AZVo+FoKwX71lS7sjmFfyXYDuHQ5K60i4pEopMX0COJG6jpxrdnDtQRDY
 heCaV3QjK5b1jHP8UeB+HHNKZBl7DfdEpLGZ0O2NdlA0UgIgZQvQkd7zkX3W30hvbPnaQEFmz
 RSP8wPpogL/n7g+WOKw7MO9h+ZV+V1ZwhUgyhigEkKqs7ZSOZvnRwemVR3Pps/HDtaDKe/l
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cleaning up files in the $HOME directory, it really makes sense to
quote the path, especially in Git's test suite, where the HOME directory
is *guaranteed* to contain spaces in its name.

It would appear that those two tests pass even without cleaning up the
files, but really more by pure chance than by design (the cleanup seems
not actually to be necessary).

However, if anybody would have a left-over `trash/` directory in Git's
`t/` directory, these tests would fail, because they would all of a
sudden try to delete that directory, but without the `-r` (recursive)
flag. That is how this issue was found.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0302-credential-store.sh | 2 +-
 t/t3900-i18n-commit.sh      | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 1d8d1f210b9..d6b54e8c65a 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -37,7 +37,7 @@ helper_test store
 unset XDG_CONFIG_HOME
 
 test_expect_success 'if custom xdg file exists, home and xdg files not created' '
-	test_when_finished "rm -f $HOME/xdg/git/credentials" &&
+	test_when_finished "rm -f \"$HOME/xdg/git/credentials\"" &&
 	test -s "$HOME/xdg/git/credentials" &&
 	test_path_is_missing "$HOME/.git-credentials" &&
 	test_path_is_missing "$HOME/.config/git/credentials"
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 3b94283e355..9e4e694d939 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -40,7 +40,7 @@ test_expect_success 'UTF-16 refused because of NULs' '
 '
 
 test_expect_success 'UTF-8 invalid characters refused' '
-	test_when_finished "rm -f $HOME/stderr $HOME/invalid" &&
+	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
 	echo "UTF-8 characters" >F &&
 	printf "Commit message\n\nInvalid surrogate:\355\240\200\n" \
 		>"$HOME/invalid" &&
@@ -49,7 +49,7 @@ test_expect_success 'UTF-8 invalid characters refused' '
 '
 
 test_expect_success 'UTF-8 overlong sequences rejected' '
-	test_when_finished "rm -f $HOME/stderr $HOME/invalid" &&
+	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
 	rm -f "$HOME/stderr" "$HOME/invalid" &&
 	echo "UTF-8 overlong" >F &&
 	printf "\340\202\251ommit message\n\nThis is not a space:\300\240\n" \
@@ -59,7 +59,7 @@ test_expect_success 'UTF-8 overlong sequences rejected' '
 '
 
 test_expect_success 'UTF-8 non-characters refused' '
-	test_when_finished "rm -f $HOME/stderr $HOME/invalid" &&
+	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
 	echo "UTF-8 non-character 1" >F &&
 	printf "Commit message\n\nNon-character:\364\217\277\276\n" \
 		>"$HOME/invalid" &&
@@ -68,7 +68,7 @@ test_expect_success 'UTF-8 non-characters refused' '
 '
 
 test_expect_success 'UTF-8 non-characters refused' '
-	test_when_finished "rm -f $HOME/stderr $HOME/invalid" &&
+	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
 	echo "UTF-8 non-character 2." >F &&
 	printf "Commit message\n\nNon-character:\357\267\220\n" \
 		>"$HOME/invalid" &&
-- 
2.15.1.windows.2.391.g0b42e3c56de
