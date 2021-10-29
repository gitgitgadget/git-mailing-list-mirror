Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9695C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FBE61165
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhJ2Ns3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 09:48:29 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51289 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhJ2Ns2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 09:48:28 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N3omW-1mp0uJ3zjU-00zm1G; Fri, 29 Oct 2021 15:45:47 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id DC12F1E01E7;
        Fri, 29 Oct 2021 13:45:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XOKpwIELHPOu; Fri, 29 Oct 2021 15:45:46 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (30-usr-pf-main.vpn.it.cetitec.com [10.8.5.30])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 57D501E01E6;
        Fri, 29 Oct 2021 15:45:46 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Fri, 29 Oct 2021 15:45:45 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Subject: [PATCH] Document positive variant of commit and merge option
 "--no-verify"
Message-ID: <YXv7CW4QHQOzFla6@pflmari>
References: <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
 <YXlBhmfXl3wFQ5Bj@pflmari>
 <YXlD5ecNSdeBSMoS@coredump.intra.peff.net>
 <YXlTpzrY7KFqRlno@pflmari>
 <xmqq4k92w7do.fsf@gitster.g>
 <YXpFTJTo0pKhM7xG@pflmari>
 <YXpZddOixrJDd//s@pflmari>
 <edca7f6b-e89c-7efa-c6f5-2c3aaaea54f9@gmail.com>
 <YXrFaJXbuSuwfhQ7@pflmari>
 <7be2fde3-69b2-1da7-bb94-7c181490f626@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be2fde3-69b2-1da7-bb94-7c181490f626@gmail.com>
X-Provags-ID: V03:K1:uOMjZXVnhURLvtwpxJ5fLXp6v7/jgZqWmF2GJi7veQhb9uzZJXZ
 x5Rz8JBNkceJSIHzrCMrtvHOzyPuXWbz/BncqezVmw6n9lGTLEN/zCLzD0ywa6UmFX42deA
 6EiByHy8m4uZWU9HYvo3CzlO3S4cILb9OORZuV3SBHY0E7KMzltDjw94RNCJlrIICvhbzDq
 oo7t0R8L4Svhe46ALNzVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4PbOkbULtCQ=:kqcIu+kIHH8RXsAbXQJ/k2
 kHz8YhrO2NVOCOnoedqeDh886GEifnH/YbK1Da5bC14lu/tXkjU22VJkP9hNRzOXZ7aTjIYAW
 uQtxAz19ikfw9/zOYcQEE3uFU2KvW53XPxX8gxqwa9UxZ+X37kKlOxbkzwAJsmTsTf2Y3Buja
 yjGk+VAz5ASg22Aba2XMV9yYytG5S22+7ZCcIey25NM+v2oiQvXlaaKAgj+dLDcK2MkAse3xU
 sEMCQ+KllE7WM3egmRADWRiRSaakgjeCWpCNP8OYAkLx9GxpQYfjkV2Tjh+O6FR7TxO9ZP5rj
 vf/09BEqTMBlOhJ/XZyBDQmwUCmuNfZ0piNjzHFsqwKOLEQstiwLprqsSd6JCRaLvfdX/m9cU
 hbniq4zM/wUKtszxvKcryvY8eEMUUm0vUyfwaH+0VorV38rke1spsScwQcXhx1BuvQE6BcPij
 pRB0pfvtbN8IMtOTmtisam8TKH5t4bAmGnP//yb1kCrv5sPsJQtHhxBvtoI2BhFwF+qNMEcBD
 YzJ6lawB1qVrL33VgLfh7U9d/FRYbgPI5zLbZy3HsNh8FLgNeGuPAVSH5O9iztmqVMFw/76Ei
 dOVJgQUmLz1xHajBZuNDz3Yxk0G0viBqJlFCy/wCKj2ru3HxUGnPEDQCox99iP0vRGOpraCj3
 VGcFxim2XimG0y0INQxP1mDdyFdBvzxWLNyX7KLOq780FNArvWVo2zhbRQTLrc3H11ojsOQTY
 yJn3o8IdSqbSG7cT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alex Riesen <raa.lkml@gmail.com>

This documents "--verify" option of the commands. It can be used to re-enable
the hooks disabled by an earlier "--no-verify" in command-line.

Signed-off-by: Alexander Riesen <raa.lkml@gmail.com>
---

Phillip Wood, Fri, Oct 29, 2021 15:32:16 +0200:
> On 28/10/2021 16:44, Alex Riesen wrote:
> > diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> > index a3baea32ae..2268787483 100644
> > --- a/Documentation/git-commit.txt
> > +++ b/Documentation/git-commit.txt
> > @@ -174,9 +174,14 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
> >   -n::
> >   --no-verify::
> > -	This option bypasses the pre-commit and commit-msg hooks.
> > +	By default, pre-commit and commit-msg hooks are run. When one of these
> 
> As I suggested yesterday I think this would be better if it kept the "the"
> from the original text as you do below for the merge documentation -
> s/default, /&the /

Updated:

    -n::
    --[no-]verify::
	    By default, the pre-commit and commit-msg hooks are run.
	    When any of `--no-verify` or `-n` is given, these are bypassed.
	    See also linkgit:githooks[5].

> > --- a/Documentation/merge-options.txt
> > +++ b/Documentation/merge-options.txt
> > @@ -112,8 +112,9 @@ option can be used to override --squash.
> >   +
> >   With --squash, --commit is not allowed, and will fail.
> > ---no-verify::
> > -	This option bypasses the pre-merge and commit-msg hooks.
> > +--[no-]verify::
> > +	By default, the pre-merge and commit-msg hooks are run.
> > +	When `--no-verify` is given, these are bypassed.
> >   	See also linkgit:githooks[5].
> 
> This text looks good. It would be nice to be consistent when documenting
> "--verify" and "--no-verify" so that documentation for commit and merge both
> have either a separate entry for each option as you have for commit or a
> shared entry as you have here for merge. I'd be tempted to use this form in
> the commit documentation.

So I did.

Regards,
Alex

 Documentation/git-commit.txt    | 5 +++--
 Documentation/merge-options.txt | 5 +++--
 t/t7504-commit-msg-hook.sh      | 8 ++++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a3baea32ae..b27a4c4c34 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -173,8 +173,9 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 	(see http://developercertificate.org/ for more information).
 
 -n::
---no-verify::
-	This option bypasses the pre-commit and commit-msg hooks.
+--[no-]verify::
+	By default, the pre-commit and commit-msg hooks are run.
+	When any of `--no-verify` or `-n` is given, these are bypassed.
 	See also linkgit:githooks[5].
 
 --allow-empty::
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 80d4831662..80267008af 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -112,8 +112,9 @@ option can be used to override --squash.
 +
 With --squash, --commit is not allowed, and will fail.
 
---no-verify::
-	This option bypasses the pre-merge and commit-msg hooks.
+--[no-]verify::
+	By default, the pre-merge and commit-msg hooks are run.
+	When `--no-verify` is given, these are bypassed.
 	See also linkgit:githooks[5].
 
 -s <strategy>::
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 31b9c6a2c1..67fcc19637 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -130,6 +130,14 @@ test_expect_success '--no-verify with failing hook' '
 
 '
 
+test_expect_success '-n followed by --verify with failing hook' '
+
+	echo "even more" >> file &&
+	git add file &&
+	test_must_fail git commit -n --verify -m "even more"
+
+'
+
 test_expect_success '--no-verify with failing hook (editor)' '
 
 	echo "more stuff" >> file &&
-- 
2.33.0.22.g8cd9218530

