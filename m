Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B7320450
	for <e@80x24.org>; Fri,  3 Nov 2017 16:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbdKCQHE (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 12:07:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:60744 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbdKCQHD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 12:07:03 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0Ppl-1dGlgm2tX3-00ucM2; Fri, 03
 Nov 2017 17:07:01 +0100
Date:   Fri, 3 Nov 2017 17:06:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Orgad Shaneh <orgads@gmail.com>
cc:     git <git@vger.kernel.org>
Subject: Re: Regression[2.14.3->2.15]: Interactive rebase fails if submodule
 is modified
In-Reply-To: <CAGHpTBJTm=3f_VCnNLeE=V4CwvC6dM8qCmGRPDap6rszcpb65A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711031658190.6482@virtualbox>
References: <CAGHpTBJTm=3f_VCnNLeE=V4CwvC6dM8qCmGRPDap6rszcpb65A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Uao5s3erGKVHZGI1ZxdeOTCHFvHqQhgE5+wwGyG6jg14xPOzro5
 LWkz0GF1pu+G0IkmJ36raEHvcp3MCPh2HnOkbcv8M8hqUj6a3Nx3rl2ouRAXF/fH2psKmwI
 aaQqMLKt4g/xvKgWY+VPn9vpZ+urqHzLckbX36iWfaz2Kf1zZ7xo6FAHD771cJE9jZhF+Ta
 9JmPUq8/8i4V54k+bGDGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lyt6ElTLTzo=:TV2igPFoR8Me9jIIq/kaag
 52dQ1FI7azAhl2Ggr7F0IYIklkFwL96s7qOVdsQ+1noEo/s8OuiTXQp8i404V41mpjCYThOYZ
 iUo2OOVzEmo0oqFgBWLLkFZ1E2El+n6WyVPllvRJD70qId7UHxyfYh5So7Sc/KxqquBnOj4nE
 LUBX+9vR+S/djkATwPbO1BxPQ5DWUgv4snpCAW2fnCWFsvRlCFzViVZyClC0ZUJcRx5Ejt0Ze
 Xv+DfycbLOEshNAs32eHzoG0Gz2nK68Sei3IWWvSQkvaJHig3Vc7E6fsFOhPR0TDDcQA4Huid
 dCiMx13HLmOC2yZcDK+g9W6ara+6UBgyqd5atfn6dOrXBCXaaFwYH5LpzqJw7qexqGsOVeXb1
 KubJVLIB4gSg0XLu4hIXxPDxQzuI0Ll1iPfEFQX1LrSlJw5Rm7Stz1pUlpxhoKPokB3f6tsqP
 V1Vj6Yyky/uC281uWJNGeqLbxHXfyV1MTKo7JbI8FUWX4fWhQIF4yHmzujln2e0ztMFdUoslb
 JbA1IfG//B8GCMLxqY+4NGBvMN29y0apQpKTQ67ozJ+PAufvt3a9VniExTv0yZAxR9KYU98FP
 BgT6JU8S/r+ixF1A45xO50FqRgR3/AUGf/uDygS1+CQBiRS4k+DjXcYOg7WgAqanSx4EsGJKt
 PVqS4Qoysm9TEOuG+ffBfrB9V9ZrdJEJOS8ilScmMWdtvtilv2lfOv3mtFhVFUoVfiOR1LArt
 zHcWBuOf/sjAv6qLzy/+TNfEqWHT8sef3j7fz+tMPjjtLpjp92Z49NT70SCBIK1iFeOfLbg0c
 oNVZ611JH1GeR833+gvqqHMul3XJJHa/28mHKUVaV5WpmZN40g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Orgad,

On Thu, 2 Nov 2017, Orgad Shaneh wrote:

> I can't reproduce this with a minimal example, but it happens in my project.
> 
> What I tried to do for reproducing is:
> rm -rf super sub
> mkdir sub; cd sub; git init
> git commit --allow-empty -m 'Initial commit'
> mkdir ../super; cd ../super
> git init
> git submodule add ../sub
> touch foo; git add foo sub
> git commit -m 'Initial commit'
> touch a; git add a; git commit -m 'a'
> touch b; git add b; git commit -m 'b'
> cd sub; git commit --allow-empty -m 'New commit'; cd ..
> git rebase -i HEAD^^
> 
> Then drop a.
> 
> In my project I get:
> error: cannot rebase: You have unstaged changes.
> 
> This works fine with 2.14.3.

I tried to turn this into a regression test, but I cannot make it fail:

-- snip --
diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
index ebf4f5e4b2c..55aebe53191 100755
--- a/t/t3426-rebase-submodule.sh
+++ b/t/t3426-rebase-submodule.sh
@@ -20,7 +20,7 @@ git_rebase () {
 	git rebase "$1"
 }
 
-test_submodule_switch "git_rebase"
+#test_submodule_switch "git_rebase"
 
 git_rebase_interactive () {
 	git status -su >expect &&
@@ -38,6 +38,27 @@ git_rebase_interactive () {
 	git rebase -i "$1"
 }
 
-test_submodule_switch "git_rebase_interactive"
+#test_submodule_switch "git_rebase_interactive"
+
+test_expect_success '123' '
+	git init sub &&
+	test_commit -C sub init-submodule &&
+	git init super &&
+	git -C super submodule add ../sub &&
+	(
+		cd super &&
+		test_tick &&
+		touch foo &&
+		git add sub foo &&
+		git commit -m initial &&
+		test_commit a &&
+		test_commit b &&
+		test_commit -C sub new &&
+		set_fake_editor &&
+		FAKE_LINES=2 &&
+		export FAKE_LINES &&
+		git rebase -i HEAD^^
+	)
+'
 
 test_done
-- snap --

Can you help me spot what I did wrong?

Ciao,
Dscho
