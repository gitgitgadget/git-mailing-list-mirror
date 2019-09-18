Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A00841F463
	for <e@80x24.org>; Wed, 18 Sep 2019 19:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbfIRTXZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 15:23:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58672 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbfIRTXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 15:23:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B863740E1;
        Wed, 18 Sep 2019 15:23:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n84BuIFzLcPLJoo+xH7oWAV3uXk=; b=rioF2/
        1l5+hHXaPtNoIf9WUSENRZYgVxxIN1R+S7JAvShuOORPy9jDyoBVUXvLJo8WYoV0
        QHnPRmxCP6r9gVPbr0c/M1pWCGH7H1Z5r7bnm6gPon0Nimy2rAbaDtMNY4ebMaan
        1qLnFeVglMFZQUly1xdqYvFZzkRiIqe9H89CY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p5bR/VPlptRSlcOSMvUN8DTMLa2hyJoZ
        B6W/JFKjjGCXiZz9PdjFCt2S2ulGKQhSjRcuKV0ajIZc4XT9XXVxdwLsGUuwUyqs
        GMu/cSQiHHbo35wi6TVHSb+WYi7IQ4BVslTCjvu8pOIE4IOLXS455HXExmtW9GLO
        GpwjXhyVtXQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83D20740DF;
        Wed, 18 Sep 2019 15:23:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B09C8740DA;
        Wed, 18 Sep 2019 15:23:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [GIT PULL] git-gui pull request
References: <20190917201334.hfbvuisdwkwgvwg5@yadavpratyush.com>
        <20190917205051.GA63601@dentonliu-ltm.internal.salesforce.com>
Date:   Wed, 18 Sep 2019 12:23:18 -0700
In-Reply-To: <20190917205051.GA63601@dentonliu-ltm.internal.salesforce.com>
        (Denton Liu's message of "Tue, 17 Sep 2019 13:50:51 -0700")
Message-ID: <xmqq7e655ryx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6635EB8-DA49-11E9-B710-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Pratyush,
>
> Since you're the maintainer now, you should submit a patch to
> Documentation/SubmittingPatches to change
>
> 	- `git-gui/` comes from git-gui project, maintained by Pat Thoyts:
>
> 		git://repo.or.cz/git-gui.git
>
> to have your own information.

There also is MaintNotes on the todo branch, which I'll take care
of.

FWIW, the following update to the draft release notes will be part
of what I'll push out, together with the "Third batch" update to the
master.

diff --git a/Documentation/RelNotes/2.24.0.txt b/Documentation/RelNotes/2.24.0.txt
index e123d2daa6..ff48d8582c 100644
--- a/Documentation/RelNotes/2.24.0.txt
+++ b/Documentation/RelNotes/2.24.0.txt
@@ -11,6 +11,9 @@ Backward compatibility note
 
 UI, Workflows & Features
 
+ * We now have an active interim maintainer for the Git-Gui part of
+   the system.  Praise and thank Pratyush Yadav for volunteering.
+
  * The command line parser learned "--end-of-options" notation; the
    standard convention for scripters to have hardcoded set of options
    first on the command line, and force the command to treat end-user
@@ -28,6 +31,21 @@ UI, Workflows & Features
  * Device-tree files learned their own userdiff patterns.
    (merge 3c81760bc6 sb/userdiff-dts later to maint).
 
+ * "git rebase --rebase-merges" learned to drive different merge
+   strategies and pass strategy specific options to them.
+
+ * A new "pre-merge-commit" hook has been introduced.
+
+ * Command line completion updates for "git -c var.name=val" have been
+   added.
+
+ * The lazy clone machinery has been taught that there can be more
+   than one promisor remote and consult them in order when downloading
+   missing objects on demand.
+
+ * The list-objects-filter API (used to create a sparse/lazy clone)
+   learned to take a combined filter specification.
+
 
 Performance, Internal Implementation, Development Support etc.
 
@@ -39,6 +57,20 @@ Performance, Internal Implementation, Development Support etc.
 
  * Further clean-up of the initialization code.
 
+ * xmalloc() used to have a mechanism to ditch memory and address
+   space resources as the last resort upon seeing an allocation
+   failure from the underlying malloc(), which made the code complex
+   and thread-unsafe with dubious benefit, as major memory resource
+   users already do limit their uses with various other mechanisms.
+   It has been simplified away.
+
+ * Unnecessary full-tree diff in "git log -L" machinery has been
+   optimized away.
+
+ * The http transport lacked some optimization the native transports
+   learned to avoid unnecessary ref advertisement, which has been
+   corrected.
+
 
 Fixes since v2.23
 -----------------
@@ -99,6 +131,10 @@ Fixes since v2.23
    subsequent steps.
    (merge 2c65d90f75 bc/reread-attributes-during-rebase later to maint).
 
+ * Tell cURL library to use the same malloc() implementation, with the
+   xmalloc() wrapper, as the rest of the system, for consistency.
+   (merge 93b980e58f cb/curl-use-xmalloc later to maint).
+
  * Other code cleanup, docfix, build fix, etc.
    (merge d1387d3895 en/fast-import-merge-doc later to maint).
    (merge 1c24a54ea4 bm/repository-layout-typofix later to maint).
