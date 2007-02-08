From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Correct spelling of fast-import in docs.
Date: Thu, 8 Feb 2007 15:38:01 -0500
Message-ID: <20070208203801.GA956@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 21:38:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFG21-0007ww-Tg
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 21:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423320AbXBHUiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 15:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423319AbXBHUiJ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 15:38:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:32948 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423320AbXBHUiG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 15:38:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFG1j-0000yZ-1v; Thu, 08 Feb 2007 15:37:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3646D20FBAE; Thu,  8 Feb 2007 15:38:01 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39087>

Its spelled 'fast-import', not 'gfi'.  Linus and Dscho have both
recently pointed this out to me on the mailing list.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-fast-import.txt |  156 ++++++++++++++++++------------------
 1 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 01f4c8a..2a50520 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -15,15 +15,15 @@ DESCRIPTION
 This program is usually not what the end user wants to run directly.
 Most end users want to use one of the existing frontend programs,
 which parses a specific type of foreign source and feeds the contents
-stored there to git-fast-import (gfi).
+stored there to git-fast-import.
 
-gfi reads a mixed command/data stream from standard input and
+fast-import reads a mixed command/data stream from standard input and
 writes one or more packfiles directly into the current repository.
 When EOF is received on standard input, fast import writes out
 updated branch and tag refs, fully updating the current repository
 with the newly imported data.
 
-The gfi backend itself can import into an empty repository (one that
+The fast-import backend itself can import into an empty repository (one that
 has already been initialized by gitlink:git-init[1]) or incrementally
 update an existing populated repository.  Whether or not incremental
 imports are supported from a particular foreign source depends on
@@ -34,7 +34,7 @@ OPTIONS
 -------
 --date-format=<fmt>::
 	Specify the type of dates the frontend will supply to
-	gfi within `author`, `committer` and `tagger` commands.
+	fast-import within `author`, `committer` and `tagger` commands.
 	See ``Date Formats'' below for details about which formats
 	are supported, and their syntax.
 
@@ -65,28 +65,28 @@ OPTIONS
 	have been completed.
 
 --quiet::
-	Disable all non-fatal output, making gfi silent when it
+	Disable all non-fatal output, making fast-import silent when it
 	is successful.	This option disables the output shown by
 	\--stats.
 
 --stats::
-	Display some basic statistics about the objects gfi has
+	Display some basic statistics about the objects fast-import has
 	created, the packfiles they were stored into, and the
-	memory used by gfi during this run.  Showing this output
+	memory used by fast-import during this run.  Showing this output
 	is currently the default, but can be disabled with \--quiet.
 
 
 Performance
 -----------
-The design of gfi allows it to import large projects in a minimum
+The design of fast-import allows it to import large projects in a minimum
 amount of memory usage and processing time.  Assuming the frontend
-is able to keep up with gfi and feed it a constant stream of data,
+is able to keep up with fast-import and feed it a constant stream of data,
 import times for projects holding 10+ years of history and containing
 100,000+ individual commits are generally completed in just 1-2
 hours on quite modest (~$2,000 USD) hardware.
 
 Most bottlenecks appear to be in foreign source data access (the
-source just cannot extract revisions fast enough) or disk IO (gfi
+source just cannot extract revisions fast enough) or disk IO (fast-import
 writes as fast as the disk will take the data).  Imports will run
 faster if the source data is stored on a different drive than the
 destination Git repository (due to less IO contention).
@@ -94,28 +94,28 @@ destination Git repository (due to less IO contention).
 
 Development Cost
 ----------------
-A typical frontend for gfi tends to weigh in at approximately 200
+A typical frontend for fast-import tends to weigh in at approximately 200
 lines of Perl/Python/Ruby code.  Most developers have been able to
 create working importers in just a couple of hours, even though it
-is their first exposure to gfi, and sometimes even to Git.  This is
+is their first exposure to fast-import, and sometimes even to Git.  This is
 an ideal situation, given that most conversion tools are throw-away
 (use once, and never look back).
 
 
 Parallel Operation
 ------------------
-Like `git-push` or `git-fetch`, imports handled by gfi are safe to
+Like `git-push` or `git-fetch`, imports handled by fast-import are safe to
 run alongside parallel `git repack -a -d` or `git gc` invocations,
 or any other Git operation (including `git prune`, as loose objects
-are never used by gfi).
+are never used by fast-import).
 
-gfi does not lock the branch or tag refs it is actively importing.
-After the import, during its ref update phase, gfi tests each
+fast-import does not lock the branch or tag refs it is actively importing.
+After the import, during its ref update phase, fast-import tests each
 existing branch ref to verify the update will be a fast-forward
 update (the commit stored in the ref is contained in the new
 history of the commit to be written).  If the update is not a
-fast-forward update, gfi will skip updating that ref and instead
-prints a warning message.  gfi will always attempt to update all
+fast-forward update, fast-import will skip updating that ref and instead
+prints a warning message.  fast-import will always attempt to update all
 branch refs, and does not stop on the first failure.
 
 Branch updates can be forced with \--force, but its recommended that
@@ -125,35 +125,35 @@ is not necessary for an initial import into an empty repository.
 
 Technical Discussion
 --------------------
-gfi tracks a set of branches in memory.  Any branch can be created
+fast-import tracks a set of branches in memory.  Any branch can be created
 or modified at any point during the import process by sending a
 `commit` command on the input stream.  This design allows a frontend
 program to process an unlimited number of branches simultaneously,
 generating commits in the order they are available from the source
 data.  It also simplifies the frontend programs considerably.
 
-gfi does not use or alter the current working directory, or any
+fast-import does not use or alter the current working directory, or any
 file within it.  (It does however update the current Git repository,
 as referenced by `GIT_DIR`.)  Therefore an import frontend may use
 the working directory for its own purposes, such as extracting file
 revisions from the foreign source.  This ignorance of the working
-directory also allows gfi to run very quickly, as it does not
+directory also allows fast-import to run very quickly, as it does not
 need to perform any costly file update operations when switching
 between branches.
 
 Input Format
 ------------
 With the exception of raw file data (which Git does not interpret)
-the gfi input format is text (ASCII) based.  This text based
+the fast-import input format is text (ASCII) based.  This text based
 format simplifies development and debugging of frontend programs,
 especially when a higher level language such as Perl, Python or
 Ruby is being used.
 
-gfi is very strict about its input.  Where we say SP below we mean
+fast-import is very strict about its input.  Where we say SP below we mean
 *exactly* one space.  Likewise LF means one (and only one) linefeed.
 Supplying additional whitespace characters will cause unexpected
 results, such as branch names or file names with leading or trailing
-spaces in their name, or early termination of gfi when it encounters
+spaces in their name, or early termination of fast-import when it encounters
 unexpected input.
 
 Date Formats
@@ -164,7 +164,7 @@ in the \--date-format=<fmt> command line option.
 
 `raw`::
 	This is the Git native format and is `<time> SP <offutc>`.
-	It is also gfi's default format, if \--date-format was
+	It is also fast-import's default format, if \--date-format was
 	not specified.
 +
 The time of the event is specified by `<time>` as the number of
@@ -184,7 +184,7 @@ by users who are located in the same location and timezone.  In this
 case a reasonable offset from UTC could be assumed.
 +
 Unlike the `rfc2822` format, this format is very strict.  Any
-variation in formatting will cause gfi to reject the value.
+variation in formatting will cause fast-import to reject the value.
 
 `rfc2822`::
 	This is the standard email format as described by RFC 2822.
@@ -206,7 +206,7 @@ value to UTC prior to storage.  Therefore it is important that
 this information be as accurate as possible.
 +
 If the source material uses RFC 2822 style dates,
-the frontend should let gfi handle the parsing and conversion
+the frontend should let fast-import handle the parsing and conversion
 (rather than attempting to do it itself) as the Git parser has
 been well tested in the wild.
 +
@@ -221,7 +221,7 @@ ambiguity in parsing.
 +
 This is a toy format.  The current time and timezone of this system
 is always copied into the identity string at the time it is being
-created by gfi.  There is no way to specify a different time or
+created by fast-import.  There is no way to specify a different time or
 timezone.
 +
 This particular format is supplied as its short to implement and
@@ -238,7 +238,7 @@ date format other than `now`.
 
 Commands
 ~~~~~~~~
-gfi accepts several commands to update the current repository
+fast-import accepts several commands to update the current repository
 and control the current import process.  More detailed discussion
 (with examples) of each command follows later.
 
@@ -264,7 +264,7 @@ and control the current import process.  More detailed discussion
 	needed to perform an import.
 
 `checkpoint`::
-	Forces gfi to close the current packfile, generate its
+	Forces fast-import to close the current packfile, generate its
 	unique SHA-1 checksum and index, and start a new packfile.
 	This command is optional and is not needed to perform
 	an import.
@@ -293,7 +293,7 @@ Git, so importing the CVS branch symbol `RELENG-1_0` would use
 `<ref>` must be a valid refname in Git.  As `LF` is not valid in
 a Git refname, no quoting or escaping syntax is supported here.
 
-A `mark` command may optionally appear, requesting gfi to save a
+A `mark` command may optionally appear, requesting fast-import to save a
 reference to the newly created commit for future use by the frontend
 (see below for format).  It is very common for frontends to mark
 every commit they create, thereby allowing future branch creation
@@ -303,7 +303,7 @@ The `data` command following `committer` must supply the commit
 message (see below for `data` command syntax).  To import an empty
 commit message use a 0 length data.  Commit messages are free-form
 and are not interpreted by Git.  Currently they must be encoded in
-UTF-8, as gfi does not permit other encodings to be specified.
+UTF-8, as fast-import does not permit other encodings to be specified.
 
 Zero or more `filemodify`, `filedelete` and `filedeleteall` commands
 may be included to update the contents of the branch prior to
@@ -316,7 +316,7 @@ wipes the branch clean (see below).
 ^^^^^^^^
 An `author` command may optionally appear, if the author information
 might differ from the committer information.  If `author` is omitted
-then gfi will automatically use the committer's information for
+then fast-import will automatically use the committer's information for
 the author portion of the commit.  See below for a description of
 the fields in `author`, as they are identical to `committer`.
 
@@ -341,12 +341,12 @@ their syntax.
 `from`
 ^^^^^^
 Only valid for the first commit made on this branch by this
-gfi process.  The `from` command is used to specify the commit
+fast-import process.  The `from` command is used to specify the commit
 to initialize this branch from.  This revision will be the first
 ancestor of the new commit.
 
 Omitting the `from` command in the first commit of a new branch will
-cause gfi to create that commit with no ancestor. This tends to be
+cause fast-import to create that commit with no ancestor. This tends to be
 desired only for the initial commit of a project.  Omitting the
 `from` command on existing branches is required, as the current
 commit on that branch is automatically assumed to be the first
@@ -357,13 +357,13 @@ quoting or escaping syntax is supported within `<committish>`.
 
 Here `<committish>` is any of the following:
 
-* The name of an existing branch already in gfi's internal branch
-  table.  If gfi doesn't know the name, its treated as a SHA-1
+* The name of an existing branch already in fast-import's internal branch
+  table.  If fast-import doesn't know the name, its treated as a SHA-1
   expression.
 
 * A mark reference, `:<idnum>`, where `<idnum>` is the mark number.
 +
-The reason gfi uses `:` to denote a mark reference is this character
+The reason fast-import uses `:` to denote a mark reference is this character
 is not legal in a Git branch name.  The leading `:` makes it easy
 to distingush between the mark 42 (`:42`) and the branch 42 (`42`
 or `refs/heads/42`), or an abbreviated SHA-1 which happened to
@@ -381,10 +381,10 @@ current branch value should be written as:
 ----
 	from refs/heads/branch^0
 ----
-The `{caret}0` suffix is necessary as gfi does not permit a branch to
+The `{caret}0` suffix is necessary as fast-import does not permit a branch to
 start from itself, and the branch is created in memory before the
 `from` command is even read from the input.  Adding `{caret}0` will force
-gfi to resolve the commit through Git's revision parsing library,
+fast-import to resolve the commit through Git's revision parsing library,
 rather than its internal branch table, thereby loading in the
 existing value of the branch.
 
@@ -392,7 +392,7 @@ existing value of the branch.
 ^^^^^^^
 Includes one additional ancestor commit, and makes the current
 commit a merge commit.  An unlimited number of `merge` commands per
-commit are permitted by gfi, thereby establishing an n-way merge.
+commit are permitted by fast-import, thereby establishing an n-way merge.
 However Git's other tools never create commits with more than 15
 additional ancestors (forming a 16-way merge).  For this reason
 it is suggested that frontends do not use more than 15 `merge`
@@ -493,14 +493,14 @@ update the content.
 Issuing a `filedeleteall` followed by the needed `filemodify`
 commands to set the correct content will produce the same results
 as sending only the needed `filemodify` and `filedelete` commands.
-The `filedeleteall` approach may however require gfi to use slightly
+The `filedeleteall` approach may however require fast-import to use slightly
 more memory per active branch (less than 1 MiB for even most large
 projects); so frontends that can easily obtain only the affected
 paths for a commit are encouraged to do so.
 
 `mark`
 ~~~~~~
-Arranges for gfi to save a reference to the current object, allowing
+Arranges for fast-import to save a reference to the current object, allowing
 the frontend to recall this object at a future point in time, without
 knowing its SHA-1.  Here the current object is the object creation
 command the `mark` command appears within.  This can be `commit`,
@@ -536,7 +536,7 @@ where `<name>` is the name of the tag to create.
 
 Tag names are automatically prefixed with `refs/tags/` when stored
 in Git, so importing the CVS branch symbol `RELENG-1_0-FINAL` would
-use just `RELENG-1_0-FINAL` for `<name>`, and gfi will write the
+use just `RELENG-1_0-FINAL` for `<name>`, and fast-import will write the
 corresponding ref as `refs/tags/RELENG-1_0-FINAL`.
 
 The value of `<name>` must be a valid refname in Git and therefore
@@ -553,13 +553,13 @@ The `data` command following `tagger` must supply the annotated tag
 message (see below for `data` command syntax).  To import an empty
 tag message use a 0 length data.  Tag messages are free-form and are
 not interpreted by Git.  Currently they must be encoded in UTF-8,
-as gfi does not permit other encodings to be specified.
+as fast-import does not permit other encodings to be specified.
 
-Signing annotated tags during import from within gfi is not
+Signing annotated tags during import from within fast-import is not
 supported.  Trying to include your own PGP/GPG signature is not
 recommended, as the frontend does not (easily) have access to the
 complete set of bytes which normally goes into such a signature.
-If signing is required, create lightweight tags from within gfi with
+If signing is required, create lightweight tags from within fast-import with
 `reset`, then create the annotated versions of those tags offline
 with the standard gitlink:git-tag[1] process.
 
@@ -611,11 +611,11 @@ however, as marks are inexpensive to store and easy to use.
 `data`
 ~~~~~~
 Supplies raw data (for use as blob/file content, commit messages, or
-annotated tag messages) to gfi.  Data can be supplied using an exact
+annotated tag messages) to fast-import.  Data can be supplied using an exact
 byte count or delimited with a terminating line.  Real frontends
 intended for production-quality conversions should always use the
 exact byte count format, as it is more robust and performs better.
-The delimited format is intended primarily for testing gfi.
+The delimited format is intended primarily for testing fast-import.
 
 Exact byte count format::
 	The frontend must specify the number of bytes of data.
@@ -632,7 +632,7 @@ included in `<count>` and will not be included in the imported data.
 
 Delimited format::
 	A delimiter string is used to mark the end of the data.
-	gfi will compute the length by searching for the delimiter.
+	fast-import will compute the length by searching for the delimiter.
 	This format is primarly useful for testing and is not
 	recommended for real data.
 +
@@ -644,14 +644,14 @@ Delimited format::
 +
 where `<delim>` is the chosen delimiter string.  The string `<delim>`
 must not appear on a line by itself within `<raw>`, as otherwise
-gfi will think the data ends earlier than it really does.  The `LF`
+fast-import will think the data ends earlier than it really does.  The `LF`
 immediately trailing `<raw>` is part of `<raw>`.  This is one of
 the limitations of the delimited format, it is impossible to supply
 a data chunk which does not have an LF as its last byte.
 
 `checkpoint`
 ~~~~~~~~~~~~
-Forces gfi to close the current packfile, start a new one, and to
+Forces fast-import to close the current packfile, start a new one, and to
 save out all current branch refs, tags and marks.
 
 ....
@@ -659,9 +659,9 @@ save out all current branch refs, tags and marks.
 	LF
 ....
 
-Note that gfi automatically switches packfiles when the current
+Note that fast-import automatically switches packfiles when the current
 packfile reaches \--max-pack-size, or 4 GiB, whichever limit is
-smaller.  During an automatic packfile switch gfi does not update
+smaller.  During an automatic packfile switch fast-import does not update
 the branch refs, tags or marks.
 
 As a `checkpoint` can require a significant amount of CPU time and
@@ -672,37 +672,37 @@ several minutes for a single `checkpoint` command to complete.
 Frontends may choose to issue checkpoints during extremely large
 and long running imports, or when they need to allow another Git
 process access to a branch.  However given that a 30 GiB Subversion
-repository can be loaded into Git through gfi in about 3 hours,
+repository can be loaded into Git through fast-import in about 3 hours,
 explicit checkpointing may not be necessary.
 
 
 Tips and Tricks
 ---------------
 The following tips and tricks have been collected from various
-users of gfi, and are offered here as suggestions.
+users of fast-import, and are offered here as suggestions.
 
 Use One Mark Per Commit
 ~~~~~~~~~~~~~~~~~~~~~~~
 When doing a repository conversion, use a unique mark per commit
 (`mark :<n>`) and supply the \--export-marks option on the command
-line.  gfi will dump a file which lists every mark and the Git
+line.  fast-import will dump a file which lists every mark and the Git
 object SHA-1 that corresponds to it.  If the frontend can tie
 the marks back to the source repository, it is easy to verify the
 accuracy and completeness of the import by comparing each Git
 commit to the corresponding source revision.
 
 Coming from a system such as Perforce or Subversion this should be
-quite simple, as the gfi mark can also be the Perforce changeset
+quite simple, as the fast-import mark can also be the Perforce changeset
 number or the Subversion revision number.
 
 Freely Skip Around Branches
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Don't bother trying to optimize the frontend to stick to one branch
 at a time during an import.  Although doing so might be slightly
-faster for gfi, it tends to increase the complexity of the frontend
+faster for fast-import, it tends to increase the complexity of the frontend
 code considerably.
 
-The branch LRU builtin to gfi tends to behave very well, and the
+The branch LRU builtin to fast-import tends to behave very well, and the
 cost of activating an inactive branch is so low that bouncing around
 between branches has virtually no impact on import performance.
 
@@ -714,7 +714,7 @@ tags which are a subset of the files available in the repository.
 
 Importing these tags as-is in Git is impossible without making at
 least one commit which ``fixes up'' the files to match the content
-of the tag.  Use gfi's `reset` command to reset a dummy branch
+of the tag.  Use fast-import's `reset` command to reset a dummy branch
 outside of your normal branch space to the base commit for the tag,
 then commit one or more file fixup commits, and finally tag the
 dummy branch.
@@ -731,12 +731,12 @@ Doing so will allow tools such as gitlink:git-blame[1] to track
 through the real commit history and properly annotate the source
 files.
 
-After gfi terminates the frontend will need to do `rm .git/TAG_FIXUP`
+After fast-import terminates the frontend will need to do `rm .git/TAG_FIXUP`
 to remove the dummy branch.
 
 Import Now, Repack Later
 ~~~~~~~~~~~~~~~~~~~~~~~~
-As soon as gfi completes the Git repository is completely valid
+As soon as fast-import completes the Git repository is completely valid
 and ready for use.  Typicallly this takes only a very short time,
 even for considerably large projects (100,000+ commits).
 
@@ -748,7 +748,7 @@ run the repack in the background and let it finish when it finishes.
 There is no reason to wait to explore your new Git project!
 
 If you choose to wait for the repack, don't try to run benchmarks
-or performance tests until repacking is completed.  gfi outputs
+or performance tests until repacking is completed.  fast-import outputs
 suboptimal packfiles that are simply never seen in real use
 situations.
 
@@ -764,7 +764,7 @@ project will benefit from the smaller repository.
 
 Packfile Optimization
 ---------------------
-When packing a blob gfi always attempts to deltify against the last
+When packing a blob fast-import always attempts to deltify against the last
 blob written.  Unless specifically arranged for by the frontend,
 this will probably not be a prior version of the same file, so the
 generated delta will not be the smallest possible.  The resulting
@@ -773,20 +773,20 @@ packfile will be compressed, but will not be optimal.
 Frontends which have efficient access to all revisions of a
 single file (for example reading an RCS/CVS ,v file) can choose
 to supply all revisions of that file as a sequence of consecutive
-`blob` commands.  This allows gfi to deltify the different file
+`blob` commands.  This allows fast-import to deltify the different file
 revisions against each other, saving space in the final packfile.
 Marks can be used to later identify individual file revisions during
 a sequence of `commit` commands.
 
-The packfile(s) created by gfi do not encourage good disk access
-patterns.  This is caused by gfi writing the data in the order
+The packfile(s) created by fast-import do not encourage good disk access
+patterns.  This is caused by fast-import writing the data in the order
 it is received on standard input, while Git typically organizes
 data within packfiles to make the most recent (current tip) data
 appear before historical data.  Git also clusters commits together,
 speeding up revision traversal through better cache locality.
 
 For this reason it is strongly recommended that users repack the
-repository with `git repack -a -d` after gfi completes, allowing
+repository with `git repack -a -d` after fast-import completes, allowing
 Git to reorganize the packfiles for faster data access.  If blob
 deltas are suboptimal (see above) then also adding the `-f` option
 to force recomputation of all deltas can significantly reduce the
@@ -795,23 +795,23 @@ final packfile size (30-50% smaller can be quite typical).
 
 Memory Utilization
 ------------------
-There are a number of factors which affect how much memory gfi
+There are a number of factors which affect how much memory fast-import
 requires to perform an import.  Like critical sections of core
-Git, gfi uses its own memory allocators to ammortize any overheads
-associated with malloc.  In practice gfi tends to ammoritize any
+Git, fast-import uses its own memory allocators to ammortize any overheads
+associated with malloc.  In practice fast-import tends to ammoritize any
 malloc overheads to 0, due to its use of large block allocations.
 
 per object
 ~~~~~~~~~~
-gfi maintains an in-memory structure for every object written in
+fast-import maintains an in-memory structure for every object written in
 this execution.  On a 32 bit system the structure is 32 bytes,
 on a 64 bit system the structure is 40 bytes (due to the larger
 pointer sizes).  Objects in the table are not deallocated until
-gfi terminates.  Importing 2 million objects on a 32 bit system
+fast-import terminates.  Importing 2 million objects on a 32 bit system
 will require approximately 64 MiB of memory.
 
 The object table is actually a hashtable keyed on the object name
-(the unique SHA-1).  This storage configuration allows gfi to reuse
+(the unique SHA-1).  This storage configuration allows fast-import to reuse
 an existing or already written object and avoid writing duplicates
 to the output packfile.  Duplicate blobs are surprisingly common
 in an import, typically due to branch merges in the source.
@@ -831,7 +831,7 @@ of the two classes is significantly different.
 
 Inactive branches are stored in a structure which uses 96 or 120
 bytes (32 bit or 64 bit systems, respectively), plus the length of
-the branch name (typically under 200 bytes), per branch.  gfi will
+the branch name (typically under 200 bytes), per branch.  fast-import will
 easily handle as many as 10,000 inactive branches in under 2 MiB
 of memory.
 
@@ -846,7 +846,7 @@ As active branches store metadata about the files contained on that
 branch, their in-memory storage size can grow to a considerable size
 (see below).
 
-gfi automatically moves active branches to inactive status based on
+fast-import automatically moves active branches to inactive status based on
 a simple least-recently-used algorithm.  The LRU chain is updated on
 each `commit` command.  The maximum number of active branches can be
 increased or decreased on the command line with \--active-branches=.
@@ -867,7 +867,7 @@ tree names are pooled in a common string table, allowing the filename
 overhead) no matter how many times it occurs within the project.
 
 The active branch LRU, when coupled with the filename string pool
-and lazy loading of subtrees, allows gfi to efficiently import
+and lazy loading of subtrees, allows fast-import to efficiently import
 projects with 2,000+ branches and 45,114+ files in a very limited
 memory footprint (less than 2.7 MiB per active branch).
 
-- 
1.5.0.rc4
