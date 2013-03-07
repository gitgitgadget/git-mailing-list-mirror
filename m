From: Greg Price <price@MIT.EDU>
Subject: Re: [PATCH] add: Clarify documentation of -A and -u
Date: Thu, 7 Mar 2013 05:13:15 -0500
Message-ID: <20130307101314.GP22203@biohazard-cafe.mit.edu>
References: <20130306072610.GB15534@biohazard-cafe.mit.edu>
 <7vhakoqwri.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 11:13:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDXpd-0001ka-2m
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 11:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210Ab3CGKNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 05:13:22 -0500
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:62223 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932093Ab3CGKNT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Mar 2013 05:13:19 -0500
X-AuditID: 12074424-b7f936d0000008eb-c1-5138683ed3e6
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 02.89.02283.E3868315; Thu,  7 Mar 2013 05:13:18 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id r27ADGGV017954;
	Thu, 7 Mar 2013 05:13:17 -0500
Received: from localhost (BIOHAZARD-CAFE.MIT.EDU [18.9.64.18])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id r27ADFFN012042;
	Thu, 7 Mar 2013 05:13:16 -0500
Content-Disposition: inline
In-Reply-To: <7vhakoqwri.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IR4hTV1rXLsAg0WH9VyKLrSjeTRUPvFWYH
	Jo+Ll5Q9Pm+SC2CK4rJJSc3JLEst0rdL4MpYcsSkYJJxxYZ9jewNjFs0uhg5OSQETCQ2/f7F
	DGGLSVy4t56ti5GLQ0hgH6NEz9ZfLBDOBkaJA90/oZxPjBLrn75kA2lhEVCR+Ld1KzuIzSag
	IPFj/jqwUSICahIT2w6xgNjMAuIS6+aeB6sRFrCRuPr2Mlgvr4C1xLLFc8BsIYF0iR9LVkHF
	BSVOznwC1aslcePfS6YuRg4gW1pi+T8OkDCngJlE26PlrCC2KNAJ1/a3s01gFJyFpHsWku5Z
	CN0LGJlXMcqm5Fbp5iZm5hSnJusWJyfm5aUW6Zrr5WaW6KWmlG5iBAUuu4vKDsbmQ0qHGAU4
	GJV4eDfkmAcKsSaWFVfmHmKU5GBSEuW1SLAIFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCe0EO
	KMebklhZlVqUD5OS5mBREue9nnLTH+jfxJLU7NTUgtQimKwMB4eSBK93OlCjYFFqempFWmZO
	CUKaiYMTZDgP0HAdkBre4oLE3OLMdIj8KUZdjgXXHr1gFGLJy89LlRLn1QApEgApyijNg5sD
	SzivGMWB3hLmZQSp4gEmK7hJr4CWMAEt8QsGW1KSiJCSamCMvhq+rCnFsSNMW+rhnhO/bz5d
	tDLYSOuoK993JtnYbGGvznz3U2rHWPhEPjMeYGlelqVz3FX9o2SfY8S/mGKvkG/etf82PTi1
	NEGu8GO8ToG0x98dF0NjtrZvOt8rHeH5n2XzBUl/8dN6sdtVNu9dsb5OUt75fUxu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217586>

On Wed, Mar 06, 2013 at 09:10:57AM -0800, Junio C Hamano wrote:
> I do not know if mentioning what -A does in the description for -u
> (and vice versa) makes it easier to understand or more confusing
> (not rhetorical: I suspect some may find it easier and others not).
> 
> But "and the default behaviour will..." here _is_ confusing.  After
> reading this patch three times, I still cannot tell what "default"
> you are trying to describe.  Is it "-u" without arguments?  Is it
> "add" without "-u" nor "-A"?  Is it something else???

I meant the behavior without -A or -u.  This could be fixed directly
by s/the default behavior will/with neither -A nor -u we/.  But we can
also keep revising -- there's definitely more room to make this
clearer!  I suggest new versions at the bottom of this message.

I do think that it's important that the reader be able to see clearly
what the option does as a contrast with what the command does without
the option.  Normally in a man page this is how the option is
described in the first place -- for example, the next entry in this
very man page says "Record *only* the fact that the path will be added
later", rather than "Record the fact that ..."  These two descriptions
suffer from not doing that, so that it's not clear which parts of the
behavior they describe are just what 'add' does with no options and
which parts are actually due to the option.


> Whenever you see an incomprehensible technobabble followed by "That
> means", "In other words", etc., you (not limited to Greg-you but
> figuratively "everybody") should see if it makes it easier to read
> to remove everything up to that "That means" [...]

Seems like a reasonable heuristic.


> 	-u::
>         --update::
> 		Update modified and/or removed paths in the index
> 		that match <pathspec> with the current state of the
> 		working tree files.  No new path is added because
> 		this considers only the paths that are already in
> 		the index.
> 
> 	-A::
>         --all::
> 		Update the index to record the current state of the
> 		working tree files that match <pathspec>.  Note that
> 		new paths will be added to the index, in addition to
> 		modified and/or removed paths.

These are good -- I especially like that they're shorter.  I do think
they're still likely to be confusing.  The lead sentences are hard to
tell apart from each other or one's mental model of what 'add' alone
does, though the contrasts that follow them help.  I also think the
lead sentence for '--all' isn't really correct -- we update the index
not only for the working tree files that match <pathspec>, but also
where there is no working tree file, only an index entry.  (So the
sentence actually describes what 'add' with neither option does.)

Maybe it's worth taking a step back.  The overall taxonomy is
 * 'add' alone considers matching filenames in the working tree
 * 'add -u' considers matching filenames in the index
 * 'add -A' considers matching filenames in both the index and the
   working tree
and in each case we make the index match the working tree on those
files.  Or, put another way,
 * 'add' alone modifies and adds files
 * 'add -u' modifies and removes files
 * 'add -A' modifies, adds, and removes files

Here's a crack at making those distinctions clear.  I've also tried to
make the descriptions as parallel as possible, as what they're saying
is very similar.

-u::
--update::
	Update the index just where it already has an entry matching
	<pathspec>.  This removes as well as modifies index entries to
	match the working tree, but adds no new files.

-A::
--all::
	Update the index not only where the working tree has a file
	matching <pathspec> but also where the index already has an
	entry.  This adds, modifies, and removes index entries to
	match the working tree.

These are the shortest in the discussion so far, and I think they're
also the clearest.

Then follow both with the "If no <pathspec>" paragraph.  I just
noticed that the paragraph actually needs a small modification to fit
'-A', too.  New patch below.

Greg


From: Greg Price <price@mit.edu>
Date: Thu, 7 Mar 2013 02:08:21 -0800
Subject: [PATCH] add: Clarify documentation of -A and -u

The documentation of '-A' and '-u' is very confusing for someone who
doesn't already know what they do.  Describe them with fewer words and
clearer parallelism to each other and to the behavior of plain 'add'.

Also mention the default <pathspec> for '-A' as well as '-u', because
it applies to both.

Signed-off-by: Greg Price <price@mit.edu>
---
 Documentation/git-add.txt | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 388a225..b0944e5 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -100,12 +100,9 @@ apply to the index. See EDITING PATCHES below.
 
 -u::
 --update::
-	Only match <pathspec> against already tracked files in
-	the index rather than the working tree. That means that it
-	will never stage new files, but that it will stage modified
-	new contents of tracked files and that it will remove files
-	from the index if the corresponding files in the working tree
-	have been removed.
+	Update the index just where it already has an entry matching
+	<pathspec>.  This removes as well as modifies index entries to
+	match the working tree, but adds no new files.
 +
 If no <pathspec> is given, the current version of Git defaults to
 "."; in other words, update all tracked files in the current directory
@@ -114,10 +111,15 @@ of Git, hence the form without <pathspec> should not be used.
 
 -A::
 --all::
-	Like `-u`, but match <pathspec> against files in the
-	working tree in addition to the index. That means that it
-	will find new files as well as staging modified content and
-	removing files that are no longer in the working tree.
+	Update the index not only where the working tree has a file
+	matching <pathspec> but also where the index already has an
+	entry.	This adds, modifies, and removes index entries to
+	match the working tree.
++
+If no <pathspec> is given, the current version of Git defaults to
+"."; in other words, update all files in the current directory
+and its subdirectories. This default will change in a future version
+of Git, hence the form without <pathspec> should not be used.
 
 -N::
 --intent-to-add::
-- 
1.7.11.3
