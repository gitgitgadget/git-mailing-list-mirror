Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9211F462
	for <e@80x24.org>; Sat,  1 Jun 2019 15:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfFAPvQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jun 2019 11:51:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62398 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfFAPvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jun 2019 11:51:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A75C5C33F;
        Sat,  1 Jun 2019 11:51:12 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:mime-version:content-type; s=sasl; bh=fyF
        UQI69g9GZIsfG8dTZDwVK7Hk=; b=ck+U+1cMckP0O150/+qq6VFzRgwUFHhRwEc
        oZOcYI04qNFIIfwxVwuE5kOcwlwCp7haRCdaVkigCDvkVSfgMc2fmU40kmDKt40a
        fHVPaRIw2RfS9sjB9eVdjOWoGQYH9eoWQWXpK3jRLoUl31LKDF5cv7CJnl+b7Y6d
        7L576fNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:mime-version:content-type; q=dns; s=sasl; b=
        vnU+mTXHIttGrRGdiUtW4ce4nguCeb+6H3xu5cmHku6GvFzujLEUG6Rf5Q49xaHS
        SRFMyo6Z2NrlXGmDwtuJHSxtVqLPh68wMhz8BgVv2zFOd721miBvOr7eGVD3FbFT
        NGKO5jxgDMHot7pIv/ovenBsIlAMhvKOekwtAB28jCM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22C165C33E;
        Sat,  1 Jun 2019 11:51:12 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0AB915C33D;
        Sat,  1 Jun 2019 11:51:08 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Sat, 1 Jun 2019 11:51:06 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] RelNotes: minor typo fixes in 2.22.0 draft
Message-ID: <20190601155106.GK3654@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 12C58D6E-8485-11E9-A5B1-B0405B776F7B-09356542!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
These are all just minor typos I noticed while reading the
release notes.

I did find the first entry on the checkout --no-overlay read
a bit strangely with the multiple "out's" in '... checking
out paths out ...'.  Is it any easier to read with:

    * "git checkout --no-overlay" can be used to trigger a new mode of
  -   checking out paths out of the tree-ish, that allows paths that
  +   checking out paths from the tree-ish, which allows paths that
      match the pathspec that are in the current index and working tree
      and are not in the tree-ish.

? (There's any number of other ways to drop one of the
"out's" [and similarly replaces a "that" with "which"] in
the sentence, of course.  Whether it's worth doing at all is
really the question.)

 Documentation/RelNotes/2.22.0.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RelNotes/2.22.0.txt b/Documentation/RelNotes/2.22.0.txt
index 84e1ba6106..5aa4a256ae 100644
--- a/Documentation/RelNotes/2.22.0.txt
+++ b/Documentation/RelNotes/2.22.0.txt
@@ -181,7 +181,7 @@ Performance, Internal Implementation, Development Support etc.
    been optimized out.
 
  * Mechanically and systematically drop "extern" from function
-   declarlation.
+   declaration.
 
  * The script to aggregate perf result unconditionally depended on
    libjson-perl even though it did not have to, which has been
@@ -270,7 +270,7 @@ Fixes since v2.21
  * On platforms where "git fetch" is killed with SIGPIPE (e.g. OSX),
    the upload-pack that runs on the other end that hangs up after
    detecting an error could cause "git fetch" to die with a signal,
-   which led to a flakey test.  "git fetch" now ignores SIGPIPE during
+   which led to a flaky test.  "git fetch" now ignores SIGPIPE during
    the network portion of its operation (this is not a problem as we
    check the return status from our write(2)s).
    (merge 143588949c jk/no-sigpipe-during-network-transport later to maint).
@@ -358,7 +358,7 @@ Fixes since v2.21
    (merge b5a0bd694c nd/read-tree-reset-doc later to maint).
 
  * Code clean-up around a much-less-important-than-it-used-to-be
-   update_server_info() funtion.
+   update_server_info() function.
    (merge b3223761c8 jk/server-info-rabbit-hole later to maint).
 
  * The message given when "git commit -a <paths>" errors out has been
@@ -450,7 +450,7 @@ Fixes since v2.21
  * When given a tag that points at a commit-ish, "git replace --graft"
    failed to peel the tag before writing a replace ref, which did not
    make sense because the old graft mechanism the feature wants to
-   mimick only allowed to replace one commit object with another.
+   mimic only allowed to replace one commit object with another.
    This has been fixed.
    (merge ee521ec4cb cc/replace-graft-peel-tags later to maint).
 
@@ -500,7 +500,7 @@ Fixes since v2.21
    conflicts are resolved in working tree *.h files but before the
    resolved results are added to the index.  This has been corrected.
 
- * "git chery-pick" (and "revert" that shares the same runtime engine)
+ * "git cherry-pick" (and "revert" that shares the same runtime engine)
    that deals with multiple commits got confused when the final step
    gets stopped with a conflict and the user concluded the sequence
    with "git commit".  Attempt to fix it by cleaning up the state
@@ -535,7 +535,7 @@ Fixes since v2.21
    todo-list "rebase -i -r" uses should not be shown as a hex object
    name.
 
- * A prerequiste check in the test suite to see if a working jgit is
+ * A prerequisite check in the test suite to see if a working jgit is
    available was made more robust.
    (merge abd0f28983 tz/test-lib-check-working-jgit later to maint).
 
-- 
Todd
