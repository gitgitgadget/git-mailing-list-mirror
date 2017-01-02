Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C71205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 12:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932603AbdABMJO (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 07:09:14 -0500
Received: from mout.gmx.net ([212.227.17.22]:51764 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932557AbdABMJM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 07:09:12 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGzwE-1cJ7bO33Pm-00Dmhq; Mon, 02
 Jan 2017 13:09:04 +0100
Date:   Mon, 2 Jan 2017 13:09:03 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Segev Finer <segev208@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] connect: handle putty/plink also in GIT_SSH_COMMAND
Message-ID: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:989kvKrMW/hYf3QcCEf/yM/KLBlKXFg0x00UbWUOiMIPvTe4ztJ
 161hIcddVbQyzqiun7mcYMCmyuodc6GO7dBEqJJJcDERddByRStmBxkkxbQwEVyNp/NKYyt
 7jZKwjpU8R6XhBEuLqyLJsQVs/T4MRX/1ZV8Zja9TdeEL3i/b3DwGvBMRuCprOMODnkFHXM
 vKLiyI5uuylm99xDMTRxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5k0ruAMAf+I=:llOksrdOhAbZjYUe8jHH8R
 qWIdS/BoByNyosPnHIvcbBf3oVhgyhYSJxvScdnRiAOepLq4l8yiC7vPITmYdW4jx0w6F9mpR
 DNp+RBwmN5aWbPxfsaKF4cHQ8w2FFeCLNs3JXxZr0yKY6H1rXorQGrS0rde86o7qImlpP+EH3
 Vnnpc49JDtHikVg9leZHr1+VhRjGEUZl79uzlU1KzfxuvNigxyFuAFgFyPR2B1hedT0TZWyAF
 HKG1NYK/ksoNNTN0Zbz/Q0knZXp1T8ia4MpdK7O+r9eiGTQwzcCTgt2ZS4bpHiZTNP8hQDOfT
 QYcsqfB9CaptCnNLIEHlEaYR3hdfw0Y/lSwHtcjcwoz7ofhWbJZqv6evJ+gwaPe1GLq2ma4Yx
 Q0caZkDmhbyah3ECbGJ+Y+Ep5Qq440seHHjhLAbC5n801hyvVUMeCeZlh6V7VNMr08/WZBkzx
 VBT5zfKduhhFcqsmM7mluwY+3FByR5pr3Y3pbddgdSebT4y/JywgOrkBmRyV4lfqelyYtSDqz
 XoOKr+XNNPlKse6AdL7ZMArHem0kKrMVNZsCFzgBAyMSX4iRD/3w+7EzC+Xmzxu3Nd5eTznsx
 HLdDv84XCkQdwfaGVx8Qcncedpv+OIAERJDiy/zPY08l139se/U2rFMPllc7PgkIBboyjmMP7
 2tqx6cuxEAlLoiLqLhrFF3jobTcvKPKk+WHY5LxPl2bST/HbXGMTBsJSrGOCPbo2JJ7fxqYXd
 pe2Kxi8RlbEtyv19QxDxt41o6Vpfh24dS231AvAesC5EZOHAbuqauDtADdZpdGSUHLw2JvueT
 opDPmPwHAwkwDWEJNinSLEmwTyjtM6FjSo28xtpwRuz51JFMBe0VZqrU98uU2Ed4rmmU3/ssl
 0EKFIFHuxmP0EA89sRlzQL/zUXhD9PaB2mgqWA5KULY0nw45IS8fLrJOiDRbOErNdDs6eZpM+
 fj381lRhP3wqmxm8SX7QkOMJj52eeJjPNZK/Andkqgj4oa+YqORGKNNlsghik3wU+gHAfQVj1
 9BynbPbtjWyA/N++zGgq+0SeAJKCxPFHbF/hkoVmWuMoA7GjWmU5F6CUPBgNE3LiAg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Segev Finer <segev208@gmail.com>

Git for Windows has special support for the popular SSH client PuTTY:
when using PuTTY's non-interactive version ("plink.exe"), we use the -P
option to specify the port rather than OpenSSH's -p option. TortoiseGit
ships with its own, forked version of plink.exe, that adds support for
the -batch option, and for good measure we special-case that, too.

However, this special-casing of PuTTY only covers the case where the
user overrides the SSH command via the environment variable GIT_SSH
(which allows specifying the name of the executable), not
GIT_SSH_COMMAND (which allows specifying a full command, including
additional command-line options).

When users want to pass any additional arguments to (Tortoise-)Plink,
such as setting a private key, they are required to either use a shell
script named plink or tortoiseplink or duplicate the logic that is
already in Git for passing the correct style of command line arguments,
which can be difficult, error prone and annoying to get right.

This patch simply reuses the existing logic and expands it to cover
GIT_SSH_COMMAND, too.

Note: it may look a little heavy-handed to duplicate the entire
command-line and then split it, only to extract the name of the
executable. However, this is not a performance-critical code path, and
the code is much more readable this way.

Signed-off-by: Segev Finer <segev208@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/putty-w-args-v1
Fetch-It-Via: git fetch https://github.com/dscho/git putty-w-args-v1


	Original Pull Request:
	https://github.com/git-for-windows/git/pull/1006

 connect.c        | 23 ++++++++++++++++-------
 t/t5601-clone.sh | 15 +++++++++++++++
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/connect.c b/connect.c
index 8cb93b0720..c81f77001b 100644
--- a/connect.c
+++ b/connect.c
@@ -772,6 +772,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 			int putty = 0, tortoiseplink = 0;
 			char *ssh_host = hostandport;
 			const char *port = NULL;
+			char *ssh_argv0 = NULL;
 			transport_check_allowed("ssh");
 			get_host_and_port(&ssh_host, &port);
 
@@ -792,10 +793,15 @@ struct child_process *git_connect(int fd[2], const char *url,
 			}
 
 			ssh = get_ssh_command();
-			if (!ssh) {
-				const char *base;
-				char *ssh_dup;
-
+			if (ssh) {
+				char *split_ssh = xstrdup(ssh);
+				const char **ssh_argv;
+
+				if (split_cmdline(split_ssh, &ssh_argv))
+					ssh_argv0 = xstrdup(ssh_argv[0]);
+				free(split_ssh);
+				free((void *)ssh_argv);
+			} else {
 				/*
 				 * GIT_SSH is the no-shell version of
 				 * GIT_SSH_COMMAND (and must remain so for
@@ -807,8 +813,11 @@ struct child_process *git_connect(int fd[2], const char *url,
 				if (!ssh)
 					ssh = "ssh";
 
-				ssh_dup = xstrdup(ssh);
-				base = basename(ssh_dup);
+				ssh_argv0 = xstrdup(ssh);
+			}
+
+			if (ssh_argv0) {
+				const char *base = basename(ssh_argv0);
 
 				tortoiseplink = !strcasecmp(base, "tortoiseplink") ||
 					!strcasecmp(base, "tortoiseplink.exe");
@@ -816,7 +825,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 					!strcasecmp(base, "plink") ||
 					!strcasecmp(base, "plink.exe");
 
-				free(ssh_dup);
+				free(ssh_argv0);
 			}
 
 			argv_array_push(&conn->args, ssh);
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index a433394200..5b228e2675 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -386,6 +386,21 @@ test_expect_success 'tortoiseplink is like putty, with extra arguments' '
 	expect_ssh "-batch -P 123" myhost src
 '
 
+test_expect_success 'double quoted plink.exe in GIT_SSH_COMMAND' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
+	GIT_SSH_COMMAND="\"$TRASH_DIRECTORY/plink.exe\" -v" \
+		git clone "[myhost:123]:src" ssh-bracket-clone-plink-3 &&
+	expect_ssh "-v -P 123" myhost src
+'
+
+SQ="'"
+test_expect_success 'single quoted plink.exe in GIT_SSH_COMMAND' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
+	GIT_SSH_COMMAND="$SQ$TRASH_DIRECTORY/plink.exe$SQ -v" \
+		git clone "[myhost:123]:src" ssh-bracket-clone-plink-4 &&
+	expect_ssh "-v -P 123" myhost src
+'
+
 # Reset the GIT_SSH environment variable for clone tests.
 setup_ssh_wrapper
 

base-commit: e05806da9ec4aff8adfed142ab2a2b3b02e33c8c
-- 
2.11.0.rc3.windows.1
