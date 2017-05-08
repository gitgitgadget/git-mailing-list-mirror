Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 771C520188
	for <e@80x24.org>; Mon,  8 May 2017 01:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbdEHBip (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 21:38:45 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34148 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbdEHBio (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 21:38:44 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so2075053pfk.1
        for <git@vger.kernel.org>; Sun, 07 May 2017 18:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bim9nxOnx23a3VzY82I3Zuzf3FRNudlx5a0o43mubLc=;
        b=MEYv3lrmryRUGm8S5RNKZt5ft4qofuTWFRtZFe6SLWSKx/oA9jeQz6m564LrLnKBk8
         J7btvLBjJsH8lr5CIdSftsOx54Q80X577sbvhX9RT5Fcx3iCundd8iUzLHoA2mjyAUc8
         C6Sf2TMmAXAsrIXctf5TEdpuzxuOZ0TbXkNgUXAAjWZ+4LZRkoE2JGf6TEgF/Q5qyS9J
         nyfKw0Z3csE8slnIedvI9sUEs3NVUQOtvvUCq64bdlRt97ADxwQ/+R9oeDjBCzhioNcD
         4zIKS4lkc+6CPxhzFvJsbSJJV15oChG2liwqAbiUuDpYovw8bg9HdkFHa5xLOM+gKtST
         7d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bim9nxOnx23a3VzY82I3Zuzf3FRNudlx5a0o43mubLc=;
        b=FHFTWJ1o1vwiCLzvFH9VLQXoXIjSgqKQ05itIC3q0MewHEIYYiQQydvDICce5Hv+LV
         fnbfinGkKWxONajEntjxWVU+zrUw485j2ZJLWo68lf4hj7WgHG7MC/f0IzEP0UoCegEn
         TfngDbb1Kn9F6afBp5oL1DbaWYCBARdYrwshckAGxBMrFa8IrbISeEvzb71MMQVdKTij
         PbnrgK8o8IdQuINzL0u0C4Z2HIlR3hUi4vrMDtBVg6ZHwTNo7eWcSmld3vA1Jtpp5M2p
         Z2A9hW/nIQpybt6Urmx4Orw2dcntvoNiYAATg7YaQH1LxMlujfQAsgjb8guA4+y8p6Td
         dEzA==
X-Gm-Message-State: AN3rC/57/coGmKwkJr52beaEpbZbIsmigJuTT0pgn6pykGb6vksojnJv
        tOqpO4ljN2y6RnGJoo8=
X-Received: by 10.84.208.102 with SMTP id f35mr82218945plh.19.1494207523778;
        Sun, 07 May 2017 18:38:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id v63sm18997213pfb.104.2017.05.07.18.38.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 18:38:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] doc: replace a couple of broken gmane links
References: <20170505100803.13238-1-avarab@gmail.com>
        <xmqqwp9sb0nd.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 08 May 2017 10:38:42 +0900
In-Reply-To: <xmqqwp9sb0nd.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 08 May 2017 10:25:10 +0900")
Message-ID: <xmqqshkgb00t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Perhaps someone else will have better luck with the other ones, which
>> are:

Here is my attempt to fill the remainder.

 Documentation/git-bisect-lk2009.txt | 2 +-
 git-rebase--interactive.sh          | 2 +-
 t/t4038-diff-combined.sh            | 2 +-
 tree-walk.c                         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index b5d5e8b544..78479b003e 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1353,6 +1353,6 @@ References
 - [[[4]]] https://public-inbox.org/git/7vps5xsbwp.fsf_-_@assigned-by-dhcp.cox.net/[Junio C Hamano. 'Automated bisect success story'.]
 - [[[5]]] https://lwn.net/Articles/317154/[Christian Couder. 'Fully automated bisecting with "git bisect run"'. LWN.net.]
 - [[[6]]] https://lwn.net/Articles/277872/[Jonathan Corbet. 'Bisection divides users and developers'. LWN.net.]
-- [[[7]]] http://article.gmane.org/gmane.linux.scsi/36652/[Ingo Molnar. 'Re: BUG 2.6.23-rc3 can't see sd partitions on Alpha'. Gmane.]
+- [[[7]]] http://marc.info/?l=linux-kernel&m=119702753411680&w=2[Ingo Molnar. 'Re: BUG 2.6.23-rc3 can't see sd partitions on Alpha'. Linux-kernel mailing list.]
 - [[[8]]] https://www.kernel.org/pub/software/scm/git/docs/git-bisect.html[Junio C Hamano and the git-list. 'git-bisect(1) Manual Page'. Linux Kernel Archives.]
 - [[[9]]] https://github.com/Ealdwulf/bbchop[Ealdwulf. 'bbchop'. GitHub.]
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2c9c0165b5..90b1fbe9cf 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -5,7 +5,7 @@
 # Copyright (c) 2006 Johannes E. Schindelin
 #
 # The original idea comes from Eric W. Biederman, in
-# http://article.gmane.org/gmane.comp.version-control.git/22407
+# https://public-inbox.org/git/m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com/
 #
 # The file containing rebase commands, comments, and empty lines.
 # This file is created by "git rebase -i" then edited by the user.  As
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 0b4f7dfdc6..e2824d3437 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -354,7 +354,7 @@ test_expect_failure 'combine diff coalesce three parents' '
 '
 
 # Test for a bug reported at
-# http://thread.gmane.org/gmane.comp.version-control.git/224410
+# https://public-inbox.org/git/20130515143508.GO25742@login.drsnuggles.stderr.nl/
 # where a delete lines were missing from combined diff output when they
 # occurred exactly before the context lines of a later change.
 test_expect_success 'combine diff missing delete bug' '
diff --git a/tree-walk.c b/tree-walk.c
index ff77605680..f25a08fddf 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1075,7 +1075,7 @@ static enum interesting do_match(const struct name_entry *entry,
 		 * later on.
 		 * max_depth is ignored but we may consider support it
 		 * in future, see
-		 * http://thread.gmane.org/gmane.comp.version-control.git/163757/focus=163840
+		 * https://public-inbox.org/git/7vmxo5l2g4.fsf@alter.siamese.dyndns.org/
 		 */
 		if (ps->recursive && S_ISDIR(entry->mode))
 			return entry_interesting;
