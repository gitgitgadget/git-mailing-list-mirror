Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB7BE20C11
	for <e@80x24.org>; Sun,  3 Dec 2017 21:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbdLCV3J (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 16:29:09 -0500
Received: from mout.gmx.net ([212.227.17.22]:65001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752499AbdLCV3I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 16:29:08 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MA9FV-1eFF4w3edl-00BOCq; Sun, 03 Dec 2017 22:28:32 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v5 3/7] print_sha1_ellipsis: introduce helper
Date:   Sun,  3 Dec 2017 22:27:39 +0100
Message-Id: <20171203212743.10228-3-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171203212743.10228-1-bedhanger@gmx.de>
References: <20171203212743.10228-1-bedhanger@gmx.de>
References: <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com> <20171124235330.15157-1-bedhanger@gmx.de> <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com> <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:62xhBCcQKPxXjdHiF/Deol3huxnhQr+H8HY+N1DRZ0HReoW23LL
 ZBjf/wpfvCHzEECH3PpJxLKYW3F5MdlKmSRiaEhB6AIgVsZgCz9vuqkNgNJbdG5KyfTHZE+
 1J1uTxZ4xIPTE1DDHeEHAqcj1aAfSGEeIkWh9V3MqPR6j/b2SVcj3BE8PdaBiLYsryXQdjh
 /ELymtE8/Qoy275eBFnSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gU+JiD7P2Yo=:59QJxon9FPrOMwGXaXwmpe
 DunJKaqSRZa+c6BjStFmDPpJzZJr/Vzseg//bw3cmKJLje/ef56Qs8cs5y4aUVoynZKctFVNy
 9ymIyOyT4rC5KIZZCSuFZbSex1wYWK/6+zDHu6Rf/w+Np8imXn22cH8jWAlysXKA3k+PhR+GP
 qCn0XDt67XFk/XFR6rekc6kT9kmyWvgFIffBqxxNfo+Vm1qThaMbEwDkcQj9RAMGBTCAP7Y5y
 bys48DtAoIr80EyeK3Gd9Hw0iym+A91WKPRVipmCJCc5zlfmTIjdFL+fFTe3Vejk5rqi1QeU8
 wVb4yiMvK70bnJXVXNNinu05KcYktr28q2NDkpJTlh1hyJNsyptK/gtC3CZUshofWozZftjpI
 DUtJu2POILHXiiSPIQkWNhnB3leYhxSW68rMcvmzlqcHQ/v3G81Jo27fqV+kpTu0tz2r+mgR7
 bNpY5dULdX7EwrEQZRp2g2c2oEH0bUfFqsFVoZy+s3S3F/601D8BqJQvsy/GbJwencD2lYAlg
 rQ1UqN85hZxYvT5RxGlqzc2LlHH1KG89CfhsDjaFFqFwPUF1tjOPVYpQ87HrApSXKvTz+AX39
 R8s+eRgg3OObMol6hMQdVteMOwCQWojYRdxEpsHxLHnnMNnd+Wf1CEryV1hMlw7Tn2+2IQHE5
 5wapQZeLRq7QHOqFvU8H/gM5xyhPoPGAA2txDFc3zKxHCrgehZOxZ6F0b9QPP6NtDm0BDlgbI
 DK0oDLq+MZhvGiUoqw4mCjSkBbz9dkZGcFnWD9ZUVshplAWHjyqpfyeAyN+yBw74fixtnl24W
 XBuubSu0QGJl10KXyvrc/k7UIpkNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a helper print_sha1_ellipsis() that pays attention to the
GIT_PRINT_SHA1_ELLIPSIS environment variable, and prepare the tests to
unconditionally set it for the test pieces that will be broken once the code
stops showing the extra dots by default.

The removal of these dots is merely a plan at this step and has not happened
yet but soon will.

Document GIT_PRINT_SHA1_ELLIPSIS.

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
v4: improve env var handling (rename, helper func to query, docu)
v5: rewrite series to take Junio's comments in <xmqqd145k9td.fsf@gitster.mtv.corp.google.com> aboard
 Documentation/git.txt        |  9 +++++++++
 cache.h                      |  6 ++++++
 environment.c                | 15 +++++++++++++++
 t/t3040-subprojects-basic.sh |  2 +-
 t/t4013-diff-various.sh      |  2 +-
 t/t9300-fast-import.sh       |  2 +-
 6 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 483a1f35475e..395c88c8a31f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -731,6 +731,15 @@ corresponding standard handle, and if `GIT_REDIRECT_STDERR` is
 `2>&1`, standard error will be redirected to the same handle as
 standard output.
 
+`GIT_PRINT_SHA1_ELLIPSIS` (deprecated)::
+	If set to `yes`, print an ellipsis following an
+	(abbreviated) SHA-1 value.  This affects indications of
+	detached HEADs (linkgit:git-checkout[1]) and the raw
+	diff output (linkgit:git-diff[1]).  Printing an
+	ellipsis in the cases mentioned is no longer considered
+	adequate and support for it is likely to be removed in the
+	foreseeable future (along with the variable).
+
 Discussion[[Discussion]]
 ------------------------
 
diff --git a/cache.h b/cache.h
index 2e143450514c..dc30f6b92025 100644
--- a/cache.h
+++ b/cache.h
@@ -1958,4 +1958,10 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
 
+/*
+ * Should we print an ellipsis after an abbreviated SHA-1 value
+ * when doing diff-raw output or indicating a detached HEAD?
+ */
+extern int print_sha1_ellipsis(void);
+
 #endif /* CACHE_H */
diff --git a/environment.c b/environment.c
index 8fa032f30742..63ac38a46f8f 100644
--- a/environment.c
+++ b/environment.c
@@ -344,3 +344,18 @@ int use_optional_locks(void)
 {
 	return git_env_bool(GIT_OPTIONAL_LOCKS_ENVIRONMENT, 1);
 }
+
+int print_sha1_ellipsis(void)
+{
+	/*
+	 * Determine if the calling environment contains the variable
+	 * GIT_PRINT_SHA1_ELLIPSIS set to "yes".
+	 */
+	static int cached_result = -1; /* unknown */
+
+	if (cached_result < 0) {
+		const char *v = getenv("GIT_PRINT_SHA1_ELLIPSIS");
+		cached_result = (v && !strcasecmp(v, "yes"));
+	}
+	return cached_result;
+}
diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index 0a4ff6d824a0..b81eb5fd6ffa 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -19,7 +19,7 @@ test_expect_success 'setup: create subprojects' '
 	git update-index --add sub1 &&
 	git add sub2 &&
 	git commit -q -m "subprojects added" &&
-	git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
+	GIT_PRINT_SHA1_ELLIPSIS="yes" git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
 	git branch save HEAD &&
 	cat >expected <<-\EOF &&
 	:000000 160000 00000... A	sub1
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index c515e3e53fee..9bed64d53e01 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -131,7 +131,7 @@ do
 	test_expect_success "git $cmd" '
 		{
 			echo "\$ git $cmd"
-			git $cmd |
+			GIT_PRINT_SHA1_ELLIPSIS="yes" git $cmd |
 			sed -e "s/^\\(-*\\)$V\\(-*\\)\$/\\1g-i-t--v-e-r-s-i-o-n\2/" \
 			    -e "s/^\\(.*mixed; boundary=\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
 			echo "\$"
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index d47560b6343d..e4d06accc458 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -876,7 +876,7 @@ test_expect_success 'L: verify internal tree sorting' '
 	EXPECT_END
 
 	git fast-import <input &&
-	git diff-tree --abbrev --raw L^ L >output &&
+	GIT_PRINT_SHA1_ELLIPSIS="yes" git diff-tree --abbrev --raw L^ L >output &&
 	test_cmp expect output
 '
 
-- 
2.13.6

