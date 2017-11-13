Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E91581F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 22:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbdKMWi4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 17:38:56 -0500
Received: from mout.gmx.net ([212.227.15.19]:61487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751376AbdKMWiw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 17:38:52 -0500
Received: from bedhanger.strangled.net ([188.192.144.31]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LgHvY-1f21St0jfI-00njTW; Mon, 13 Nov 2017 23:38:15 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v2 6/6] Testing: provide tests requiring them with ellipses after SHA-1 values
Date:   Mon, 13 Nov 2017 23:36:54 +0100
Message-Id: <20171113223654.27732-6-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171113223654.27732-1-bedhanger@gmx.de>
References: <20171113223654.27732-1-bedhanger@gmx.de>
References: <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <EA775C6AB4684B7A86A88C733C132827@PhilipOakley>
X-Provags-ID: V03:K0:5O3tS7FUSveBCVicjDCw5BJexMnPv5qp/beEWzInvzF2vXgrvht
 8y9yLIEkvIThycdvQN4AU79loXnNJncTuQYjEVo1zpzhq6SYhbX35N4b0Yb5lqfB7XuxSO6
 uxzwflsNcxsho8l+xwnL2y2bZ/dj6XDLonmpHBInKtdgCho3H4K26i+xFxo66rtpiVG/nMC
 rpjg4K73LkKhAgSUXbdnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Cp6OAY25N8E=:3XKNggTEVTdT73NBfcFvlO
 13u/QAhseI5qtP4zJLZQ3CL5PurPZq2dN9YNOsLDM/BLvFVhddezOeQNE9tO6nK+TlaU0UkgZ
 u4VVg3ORsi8W+HSTuAGUvbMxs5kAEmt8RDvUsBqAc68xnBKzGl4tBpHOJC6MnvhZSvztEbK2D
 TSG8IJgFIip8aEHHiaaHH02mI9ZhVMbOjQ9yDS96cncLsfAnEBazZxiGoC6hiEAIT8vv7J3j4
 cYNz1mI+1dLemaDD+tOs/GAezAVZr/cLGI3oOg/r+Vl85FWFww2odFohPV4whVMp3H8rQZpp+
 I8HtLphQVpfNNmOrF1VR/Eua2uboMSUldQVbOonHcfN6zdtjgtK5Bpz80tnxkudq1j3Z7UBsC
 sog7HzyW8dk1fjZllYaFuD407cEUNhYFdlvLgxPuCBfmC1z2x1oaX/tWCjh89og9GMNGQ5v73
 Gym+STIY9fo2VIYTr0YE/bPUjUxGuMF5MqyehLXvQJ68GtJ6HiP7FW2hVYcvF6MnJUSaz2Hh6
 3uOHEtlOQQZSvAZUVC3+QmkmiqM3fssd07ct7aQM3yXbzSrxrz4iJtXOySFhLMJdNjLXeAcd5
 MngBfb08h11EchiA6ALmh2Qhl9PbpR5WthJ/6ZJJeQaBr2SfOaSH2q0SMQ9Vi37oXtkJKv6jt
 lgNIRDk+wf9ADmHApwIKVmI4pdbhFhUIqqJMrQT01ifXITLR9jOtnf0ul+o0+yT3ID/e062Cf
 Ye7DihIGBN0GEZMxxFuMycdXSt0u5Uu98G5eC0iByG0MqJJQ1JmbvmGh6sGDuJtzmMUMt+ty7
 U96KrNiCFfF/6iBUObmKD8bU+L9ag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Where needed, we arrange for invocations of Git as if

   "-c core.printsha1ellipsis=true"

had been specified on the command-line.  This furnishes ellipses in the
output which then matches what is expected.

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
 t/t3040-subprojects-basic.sh | 12 ++++++++++++
 t/t4013-diff-various.sh      | 12 ++++++++++++
 t/t9300-fast-import.sh       | 12 ++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index 0a4ff6d824a0..63b85bfdd4f9 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -3,6 +3,18 @@
 test_description='Basic subproject functionality'
 . ./test-lib.sh
 
+# Some of the tests expect an ellipsis after the (abbreviated)
+# SHA-1 value.  The code below results in Git being called with
+# "-c core.printsha1ellipsis=true" which satisfies those tests.
+do_print_sha1_ellipsis="'core.printsha1ellipsis=true'"
+if test -z "${GIT_CONFIG_PARAMETERS}"
+then
+	GIT_CONFIG_PARAMETERS="${do_print_sha1_ellipsis}"
+else
+	GIT_CONFIG_PARAMETERS="${GIT_CONFIG_PARAMETERS} ${do_print_sha1_ellipsis}"
+fi
+export GIT_CONFIG_PARAMETERS
+
 test_expect_success 'setup: create superproject' '
 	: >Makefile &&
 	git add Makefile &&
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index c515e3e53fee..8ee14c7c6796 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -7,6 +7,18 @@ test_description='Various diff formatting options'
 
 . ./test-lib.sh
 
+# Some of the tests expect an ellipsis after the (abbreviated)
+# SHA-1 value.  The code below results in Git being called with
+# "-c core.printsha1ellipsis=true" which satisfies those tests.
+do_print_sha1_ellipsis="'core.printsha1ellipsis=true'"
+if test -z "${GIT_CONFIG_PARAMETERS}"
+then
+	GIT_CONFIG_PARAMETERS="${do_print_sha1_ellipsis}"
+else
+	GIT_CONFIG_PARAMETERS="${GIT_CONFIG_PARAMETERS} ${do_print_sha1_ellipsis}"
+fi
+export GIT_CONFIG_PARAMETERS
+
 LF='
 '
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index d47560b6343d..6cc41b90dafa 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -7,6 +7,18 @@ test_description='test git fast-import utility'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
 
+# Some of the tests expect an ellipsis after the (abbreviated)
+# SHA-1 value.  The code below results in Git being called with
+# "-c core.printsha1ellipsis=true" which satisfies those tests.
+do_print_sha1_ellipsis="'core.printsha1ellipsis=true'"
+if test -z "${GIT_CONFIG_PARAMETERS}"
+then
+	GIT_CONFIG_PARAMETERS="${do_print_sha1_ellipsis}"
+else
+	GIT_CONFIG_PARAMETERS="${GIT_CONFIG_PARAMETERS} ${do_print_sha1_ellipsis}"
+fi
+export GIT_CONFIG_PARAMETERS
+
 verify_packs () {
 	for p in .git/objects/pack/*.pack
 	do
-- 
2.13.6

