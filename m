From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 16/17] Documentation: do not convert ... operator to
 ellipses
Date: Fri, 20 Aug 2010 05:39:48 -0500
Message-ID: <20100820103948.GP10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:41:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmP2U-0006tK-Vu
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132Ab0HTKlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 06:41:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42815 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab0HTKl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 06:41:29 -0400
Received: by iwn5 with SMTP id 5so693420iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=q8Z2P+q8t71VXvEKWfFjBkRbdY9V89FxTl1usQEPcjk=;
        b=bTZLrGVFgTSkn+HywGGwpNWBYVjQfEArH7LIfQNVEmyL1NV/LMWBZRyaZsGmc/wM/R
         Ira9qmyvnTVajKGfGCQo/IK4iRlyhZq5e6MvAQcozeFhi7j4q0GZq0TBTZ/s6cUD61+r
         9IRD15NP+IGYKBIjtwDGvVS4kQL0RiSNilwIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cOyMzSO5P6QXoryzYmuY0nAAV20wNJBafeV+9g0799vaMzi4duWqwlImkygW5+BX4v
         lfBIsKZjhCKpxjLcfJBBk+JHQz5C5sORBOj2qqqeY7aXRZeK5kppHH2bIVIFFR7mjyCq
         8sNNzL9GGgthvWGRYHubZNzwa3oIVNh5R1EoM=
Received: by 10.231.19.6 with SMTP id y6mr1312308iba.16.1282300889113;
        Fri, 20 Aug 2010 03:41:29 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm2504587ibh.10.2010.08.20.03.41.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:41:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154011>

The symmetric difference or merge-base operator ... as used by
rev-list and diff is actually three period characters.  If it
gets replaced by an ellipsis glyph in the manual, that would
stop readers from copying and pasting it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-checkout.txt     |    2 +-
 Documentation/git-push.txt         |    2 +-
 Documentation/git-rebase.txt       |    2 +-
 Documentation/rev-list-options.txt |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 1bacd2e..e015373 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -170,7 +170,7 @@ As a special case, the `"@\{-N\}"` syntax for the N-th last branch
 checks out the branch (instead of detaching).  You may also specify
 `-` which is synonymous with `"@\{-1\}"`.
 +
-As a further special case, you may use `"A...B"` as a shortcut for the
+As a further special case, you may use `"A\...B"` as a shortcut for the
 merge base of `A` and `B` if there is exactly one merge base. You can
 leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 658ff2f..020955f 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -200,7 +200,7 @@ summary::
 	For a successfully pushed ref, the summary shows the old and new
 	values of the ref in a form suitable for using as an argument to
 	`git log` (this is `<old>..<new>` in most cases, and
-	`<old>...<new>` for forced non-fast-forward updates).
+	`<old>\...<new>` for forced non-fast-forward updates).
 +
 For a failed update, more details are given:
 +
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index be23ad2..2ed62ca 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -207,7 +207,7 @@ OPTIONS
 	<upstream>.  May be any valid commit, and not just an
 	existing branch name.
 +
-As a special case, you may use "A...B" as a shortcut for the
+As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index cc562a0..e2237ae 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -321,7 +321,7 @@ excluded from the output.
 	reflog entries from the most recent one to older ones.
 	When this option is used you cannot specify commits to
 	exclude (that is, '{caret}commit', 'commit1..commit2',
-	nor 'commit1...commit2' notations cannot be used).
+	nor 'commit1\...commit2' notations cannot be used).
 +
 With '\--pretty' format other than oneline (for obvious reasons),
 this causes the output to have two extra lines of information
-- 
1.7.2.2.536.g42dab.dirty
