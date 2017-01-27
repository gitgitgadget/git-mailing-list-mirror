Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1FDD1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 17:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbdA0R2q (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 12:28:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:60883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933971AbdA0R2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 12:28:42 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3j17-1cFDgo1n8L-00rKul; Fri, 27
 Jan 2017 18:21:31 +0100
Date:   Fri, 27 Jan 2017 18:21:30 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Sverre Rabbelier <srabbelier@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [PATCH v4] t/Makefile: add a rule to re-run previously-failed
 tests
In-Reply-To: <85044791cfcba35c1ad3d8138051f3f075cb0646.1485526641.git.johannes.schindelin@gmx.de>
Message-ID: <0563f07117e828c072ba542c1a57441e2e8efb81.1485537593.git.johannes.schindelin@gmx.de>
References: <85044791cfcba35c1ad3d8138051f3f075cb0646.1485526641.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6iYjDUVdF+AaghDFIRwv/ZyDJWYHjXR1jRb9kAZoGxSTPfmrqAA
 59KAjDSJnBeyx7zdL6QWpT3bqjzmfMpjI5SbimF5VEQ/mXbO3DmLe3s1yPhHvO2rW2gtAGg
 6YYDdYgM1GqItO/lgr0P62zD405MVeTV/3oqP74qeNW++FveJeA/e72fd3Gg2tBH/PomwD/
 ESr5mh5VUZBHgkBLhMcLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:848+JECq2HE=:l64n+BpvgE32ADiAQ3xjvh
 ls10jJ4zSLxi6PPII4I75LGzlrWwcx/6TpMEFNukZZ7kRo/zvLUdzqID2IOW8mfG/GkAQmHcS
 2vrS9/Hwex+pG0U+6jaj8Aua0vc9yAdGwmxL07QKr+RcTeaII+hICzDMIRAE9GTKxKR4ZpfGU
 8iY08Q4GhrzJZNfYHGyPA+H6DKBuo+TKagpUEU4LtgcVKcdqu86gTGNeDzFBKiJzAatGjd4D6
 TYu0joV5L+bpRp5ZkQjAzI0yJ8y022xhebFqMjLMS2hRTitcveTS5ehpqr9gFPtILXEU1BxnW
 z/pNrYb5pO/+LFEXg60Nl5vL6c5z6wqp1ipJIfEBMdFCAUkAdzE8qDRgqpt8Nt7mvmQj8yRo6
 XesL5svz2e+hCqENOHAssd2jCmWAkEOZnKhAyLMxnH8CbBeMzCOOwrf5+s0RbRJ9R9u4Qp1VQ
 KgFoD/tw9oIZq0v+TpTlaekOESm8/TeR9rLcHdbyED7p3tCGsBMkvq+mLhDS7N9QdOX7cobqE
 frcabClFprbGAtpmaNOKJOju/XsH/4xQLzSMuMW+ovIt3iMKkbEZTb6ordHUUwJCtIOtvaepU
 7RFBEVSvK5d+iS6T+C4pE1TnxX3FKTqlzMleQwPi6PR4dgqMxEq4MphX3pFdO5CwLNfJkw78j
 bb9LJY5crUxGCunHSaJsRjbezcD9eUY1twANl60J75zLhLyYYHd2QBJpKSB3vai3tuos2qhE0
 IF0kmrsbGHjmlChZaeHEA2yC3ERe8SBJ7sTP1Qmi+Cp92ZN/dbRDq54gMSWcI2eglQu7TDIbh
 pT9t5GA1Ue9ZGKpIr5xM6484oApAw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch automates the process of determining which tests failed
previously and re-running them.

While developing patch series, it is a good practice to run the test
suite from time to time, just to make sure that obvious bugs are caught
early.  With complex patch series, it is common to run `make -j15 -k
test`, i.e.  run the tests in parallel and *not* stop at the first
failing test but continue. This has the advantage of identifying
possibly multiple problems in one big test run.

It is particularly important to reduce the turn-around time thusly on
Windows, where the test suite spends 45 minutes on the computer on which
this patch was developed.

It is the most convenient way to determine which tests failed after
running the entire test suite, in parallel, to look for left-over "trash
directory.t*" subdirectories in the t/ subdirectory. However, those
directories might live outside t/ when overridden using the
--root=<directory> option, to which the Makefile has no access. The next
best method is to grep explicitly for failed tests in the test-results/
directory, which the Makefile *can* access.

Please note that the often-recommended `prove` tool requires Perl, and
that opens a whole new can of worms on Windows. As no native Windows Perl
comes with Subversion bindings, we have to use a Perl in Git for Windows
that uses the POSIX emulation layer named MSYS2 (which is a portable
version of Cygwin). When using this emulation layer under stress, e.g.
when running massively-parallel tests, unexplicable crashes occur quite
frequently, and instead of having a solution to the original problem, the
developer now has an additional, quite huge problem. For that reason, this
developer rejected `prove` as a solution and went with this patch instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/failing-tests-v4
Fetch-It-Via: git fetch https://github.com/dscho/git failing-tests-v4

 t/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/Makefile b/t/Makefile
index d613935f14..1bb06c36f2 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -35,6 +35,12 @@ all: $(DEFAULT_TEST_TARGET)
 test: pre-clean $(TEST_LINT)
 	$(MAKE) aggregate-results-and-cleanup
 
+failed:
+	@failed=$$(cd '$(TEST_RESULTS_DIRECTORY_SQ)' && \
+		grep -l '^failed [1-9]' *.counts | \
+		sed -n 's/\.counts$$/.sh/p') && \
+	test -z "$$failed" || $(MAKE) $$failed
+
 prove: pre-clean $(TEST_LINT)
 	@echo "*** prove ***"; $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache

base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe
-- 
2.11.1.windows.prerelease.2.9.g3014b57
