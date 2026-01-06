Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3B0EADC
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725860; cv=none; b=lNY08QBtFI6ZCZkVRhqngwS5dMmJ8L7xV0Czy3f2afTTTlapCLLZi9I2ZFjuys6IjqjW1859V1/bek3ztbFJd1gKiqccAr5TiZ7iU1lCrWjzesO+LetnZR9zm7WTcEAEE2r8n3owxr5d0ayGb5C+kO5my5uIiPrYrexazq4SQqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725860; c=relaxed/simple;
	bh=PAU8zgAz08WPcLXDqZljTGz1BQq5ghRec8UgdsznBgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKUlfIKblCFwdwp35MdTfRiRcG7m6oOStqGYECToA1VJAK1lZSX5Lkno3OKquCfXTSlWjnIUykJ8lrGUpnxwplKzwfUZVuRPXhNsqJ5XYZ8rHzJ2vdQ3jz6/sG/ev3lWWRHqnDuRBs3TF0OLii5oUkGddvKa2GwBNdm788A4PMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:403d:7b0b:71b8:1a60])
	(Authenticated sender: jn.avila@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 9A70B780333;
	Tue,  6 Jan 2026 19:57:27 +0100 (CET)
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <avila.jn@gmail.com>
To: git@vger.kernel.org, Michael Lyons <git@michael.lyo.nz>
Cc: Michael Lyons <git@michael.lyo.nz>
Subject: Re: [PATCH] doc: git-blame: convert blame to new doc format
Date: Tue, 06 Jan 2026 19:57:27 +0100
Message-ID: <7894506.EvYhyI6sBW@piment-oiseau>
In-Reply-To: <20260105230220.519303-1-git@michael.lyo.nz>
References: <20260105230220.519303-1-git@michael.lyo.nz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, 6 January 2026 00:02:17 CET Michael Lyons wrote:
> - Use _<placeholder>_ instead of <placeholder> in the description
> - Use _underscores_ around sample commits, ranges, and math involving
> or associated with <placeholders>
> - Use `backticks` for keywords and more complex option
> descriptions. The new rendering engine will apply synopsis rules to
> these spans.
> 
> Signed-off-by: Michael Lyons <git@michael.lyo.nz>

Thanks for helping out.

> ---
>  Documentation/blame-options.adoc | 100 +++++++++++++++----------------
>  Documentation/git-blame.adoc     |  60 +++++++++----------
>  2 files changed, 80 insertions(+), 80 deletions(-)
> 
> diff --git a/Documentation/blame-options.adoc b/Documentation/blame-
options.adoc
> index 1fb948fc76..1f5b6ec57d 100644
> --- a/Documentation/blame-options.adoc
> +++ b/Documentation/blame-options.adoc
> @@ -1,105 +1,105 @@
> --b::
> +`-b`::
>  	Show blank SHA-1 for boundary commits.  This can also
>  	be controlled via the `blame.blankBoundary` config option.
> 
> ---root::
> +`--root`::
>  	Do not treat root commits as boundaries.  This can also be
>  	controlled via the `blame.showRoot` config option.
> 
> ---show-stats::
> +`--show-stats`::
>  	Include additional statistics at the end of blame output.
> 
> --L <start>,<end>::
> --L :<funcname>::
> -	Annotate only the line range given by '<start>,<end>',
> -	or by the function name regex '<funcname>'.
> +`-L <start>,<end>`::
> +`-L :<funcname>`::
> +	Annotate only the line range given by _<start>,<end>_,

It would be better to use backticks, so that the comma is formatted as a 
keyword: `<start>,<end>`

> +	or by the function name regex _<funcname>_.
>  	May be specified multiple times. Overlapping ranges are allowed.
>  +
> -'<start>' and '<end>' are optional. `-L <start>` or `-L <start>,` spans 
from
> -'<start>' to end of file. `-L ,<end>` spans from start of file to '<end>'.
> +_<start>_ and _<end>_ are optional. `-L <start>` or `-L <start>,` spans 
from
> +_<start>_ to end of file. `-L ,<end>` spans from start of file to _<end>_.
>  +
>  include::line-range-format.adoc[]
> 
> --l::
> +`-l`::
>  	Show long rev (Default: off).
> 
> --t::
> +`-t`::
>  	Show raw timestamp (Default: off).
> 
> --S <revs-file>::
> -	Use revisions from revs-file instead of calling linkgit:git-rev-
list[1].
> +`-S <revs-file>`::
> +	Use revisions from _revs-file_ instead of calling linkgit:git-rev-
list[1].

Placeholders keep their brackets: _<rev-file>_ in prose.

> 
> ---reverse <rev>..<rev>::
> +`--reverse <rev>..<rev>`::

Here, I would differentiate the names of the two placeholders, <start>..<end> 
as used below.

>  	Walk history forward instead of backward. Instead of showing
>  	the revision in which a line appeared, this shows the last
>  	revision in which a line has existed. This requires a range of
> -	revision like START..END where the path to blame exists in
> -	START.  `git blame --reverse START` is taken as `git blame
> +	revision like _START..END_ where the path to blame exists in
> +	_START_.  `git blame --reverse START` is taken as `git blame
>  	--reverse START..HEAD` for convenience.

Here, let's transition to the <placeholder> format: <start>..<end> and so on.

> 
> ---first-parent::
> +`--first-parent`::
>  	Follow only the first parent commit upon seeing a merge
>  	commit. This option can be used to determine when a line
>  	was introduced to a particular integration branch, rather
>  	than when it was introduced to the history overall.
> 
> --p::
> ---porcelain::
> +`-p`::
> +`--porcelain`::
>  	Show in a format designed for machine consumption.
> 
> ---line-porcelain::
> +`--line-porcelain`::
>  	Show the porcelain format, but output commit information for
>  	each line, not just the first time a commit is referenced.
> -	Implies --porcelain.
> +	Implies `--porcelain`.
> 
> ---incremental::
> +`--incremental`::
>  	Show the result incrementally in a format designed for
>  	machine consumption.
> 
> ---encoding=<encoding>::
> +`--encoding=<encoding>`::
>  	Specifies the encoding used to output author names

During the conversion, I take the opportunity to change also the mood of the 
description to imperative: "Specify ..."

>  	and commit summaries. Setting it to `none` makes blame
>  	output unconverted data. For more information see the
>  	discussion about encoding in the linkgit:git-log[1]
>  	manual page.
> 
> ---contents <file>::
> -	Annotate using the contents from the named file, starting from <rev>
> -	if it is specified, and HEAD otherwise. You may specify '-' to make
> +`--contents <file>`::
> +	Annotate using the contents from the named file, starting from 
_<rev>_

Here, to lighten a bit the style and create visual internal references, we 
could make a "placeholder pun":

Annotate using the contents from _<file>_, ...

> +	if it is specified, and `HEAD` otherwise. You may specify `-` to 
make
>  	the command read from the standard input for the file contents.
> 
> ---date <format>::
> -	Specifies the format used to output dates. If --date is not
> -	provided, the value of the blame.date config variable is
> -	used. If the blame.date config variable is also not set, the
> +`--date <format>`::
> +	Specifies the format used to output dates. If `--date` is not

Imperative mood.

> +	provided, the value of the `blame.date` config variable is
> +	used. If the `blame.date` config variable is also not set, the
>  	iso format is used. For supported values, see the discussion
> -	of the --date option at linkgit:git-log[1].
> +	of the `--date` option at linkgit:git-log[1].
> 
> ---progress::
> ---no-progress::
> +`--progress`::
> +`--no-progress`::
>  	Progress status is reported on the standard error stream
>  	by default when it is attached to a terminal. This flag
>  	enables progress reporting even if not attached to a
>  	terminal. Can't use `--progress` together with `--porcelain`
>  	or `--incremental`.

Here maybe swap the first two sentences, remove the "This flags" and convert 
to imperative mood. The first sentence is a bit redundant.

As a general rule, I tend to reorder/reword the paragraph to describe the 
effect in the first sentence of the description with an imperative mood. 

> 
> --M[<num>]::
> +`-M[<num>]`::
>  	Detect moved or copied lines within a file. When a commit
>  	moves or copies a block of lines (e.g. the original file
> -	has A and then B, and the commit changes it to B and then
> -	A), the traditional 'blame' algorithm notices only half of
> +	has _A_ and then _B_, and the commit changes it to _B_ and then
> +	_A_), the traditional `blame` algorithm notices only half of
>  	the movement and typically blames the lines that were moved
> -	up (i.e. B) to the parent and assigns blame to the lines that
> -	were moved down (i.e. A) to the child commit.  With this
> +	up (i.e. _B_) to the parent and assigns blame to the lines that
> +	were moved down (i.e. _A_) to the child commit.  With this
>  	option, both groups of lines are blamed on the parent by
>  	running extra passes of inspection.
>  +
> -<num> is optional but it is the lower bound on the number of
> +_<num>_ is optional, but it is the lower bound on the number of
>  alphanumeric characters that Git must detect as moving/copying
>  within a file for it to associate those lines with the parent
>  commit. The default value is 20.
> 
> --C[<num>]::
> +`-C[<num>]`::
>  	In addition to `-M`, detect lines moved or copied from other
>  	files that were modified in the same commit.  This is
>  	useful when you reorganize your program and move code
> @@ -109,14 +109,14 @@ commit. The default value is 20.
>  	option is given three times, the command additionally
>  	looks for copies from other files in any commit.
>  +
> -<num> is optional but it is the lower bound on the number of
> +_<num>_ is optional, but it is the lower bound on the number of
>  alphanumeric characters that Git must detect as moving/copying
>  between files for it to associate those lines with the parent
>  commit. And the default value is 40. If there are more than one
> -`-C` options given, the <num> argument of the last `-C` will
> +`-C` options given, the _<num>_ argument of the last `-C` will
>  take effect.
> 
> ---ignore-rev <rev>::
> +`--ignore-rev <rev>`::
>  	Ignore changes made by the revision when assigning blame, as if the
>  	change never happened.  Lines that were changed or added by an 
ignored
>  	commit will be blamed on the previous commit that changed that line 
or
> @@ -126,26 +126,26 @@ take effect.
>  	another commit will be marked with a `?` in the blame output.  If 
the
>  	`blame.markUnblamableLines` config option is set, then those lines 
touched
>  	by an ignored commit that we could not attribute to another revision 
are
> -	marked with a '*'. In the porcelain modes, we print 'ignored' and
> -	'unblamable' on a newline respectively.
> +	marked with a `*`. In the porcelain modes, we print _ignored_ and
> +	_unblamable_ on a newline respectively.
> 

If the words are printed "verbatim", then the format is backticked: `ignored` 
and `unblamable`.


> ---ignore-revs-file <file>::
> -	Ignore revisions listed in `file`, which must be in the same format 
as an
> +`--ignore-revs-file <file>`::
> +	Ignore revisions listed in _<file>_, which must be in the same 
format as an
>  	`fsck.skipList`.  This option may be repeated, and these files will 
be
>  	processed after any files specified with the `blame.ignoreRevsFile` 
config
>  	option.  An empty file name, `""`, will clear the list of revs from
>  	previously processed files.
> 
> ---color-lines::
> +`--color-lines`::
>  	Color line annotations in the default format differently if they 
come from
>  	the same commit as the preceding line. This makes it easier to 
distinguish
>  	code blocks introduced by different commits. The color defaults to 
cyan and
>  	can be adjusted using the `color.blame.repeatedLines` config option.
> 
> ---color-by-age::
> +`--color-by-age`::
>  	Color line annotations depending on the age of the line in the 
default format.
>  	The `color.blame.highlightRecent` config option controls what color 
is used for
>  	each range of age.
> 
> --h::
> +`-h`::
>  	Show help message.

This diff is quite large. If there are no other reasons to split the patch 
according to some semantic reason, then please split file by file.


> diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
> index adcbb6f5dc..7dc93f90b2 100644
> --- a/Documentation/git-blame.adoc
> +++ b/Documentation/git-blame.adoc
> @@ -7,12 +7,12 @@ git-blame - Show what revision and author last modified 
each line
> of a file
> 
>  SYNOPSIS
>  --------
> -[verse]
> -'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w]
> [--incremental] -	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C]
> [--since=<date>]
> -	    [--ignore-rev <rev>] [--ignore-revs-file <file>]
> -	    [--color-lines] [--color-by-age] [--progress] [--abbrev=<n>]
> -	    [ --contents <file> ] [<rev> | --reverse <rev>..<rev>] [--] 
<file>
> +[synopsis]
> +git blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w]
> [--incremental] +	  [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C]
> [--since=<date>]
> +	  [--ignore-rev <rev>] [--ignore-revs-file <file>]
> +	  [--color-lines] [--color-by-age] [--progress] [--abbrev=<n>]
> +	  [ --contents <file> ] [<rev> | --reverse <rev>..<rev>] [--] <file>
> 
>  DESCRIPTION
>  -----------
> @@ -30,7 +30,7 @@ lines that were copied and pasted from another file, etc., 
see
> the `-C` and `-M` options.
> 
>  The report does not tell you anything about lines which have been deleted 
or
> -replaced; you need to use a tool such as 'git diff' or the "pickaxe"
> +replaced; you need to use a tool such as `git diff` or the "pickaxe"
>  interface briefly mentioned in the following paragraph.
> 
>  Apart from supporting file annotation, Git also supports searching the
> @@ -50,47 +50,47 @@ OPTIONS
>  -------
>  include::blame-options.adoc[]
> 
> --c::
> +`-c`::
>  	Use the same output mode as linkgit:git-annotate[1] (Default: off).
> 
> ---score-debug::
> +`--score-debug`::
>  	Include debugging information related to the movement of
>  	lines between files (see `-C`) and lines moved within a
>  	file (see `-M`).  The first number listed is the score.
>  	This is the number of alphanumeric characters detected
>  	as having been moved between or within files.  This must be above
> -	a certain threshold for 'git blame' to consider those lines
> +	a certain threshold for `git blame` to consider those lines
>  	of code to have been moved.
> 
> --f::
> ---show-name::
> +`-f`::
> +`--show-name`::
>  	Show the filename in the original commit.  By default
>  	the filename is shown if there is any line that came from a
>  	file with a different name, due to rename detection.
> 
> --n::
> ---show-number::
> +`-n`::
> +`--show-number`::
>  	Show the line number in the original commit (Default: off).
> 
> --s::
> +`-s`::
>  	Suppress the author name and timestamp from the output.
> 
> --e::
> ---show-email::
> +`-e`::
> +`--show-email`::
>  	Show the author email instead of the author name (Default: off).
>  	This can also be controlled via the `blame.showEmail` config
>  	option.
> 
> --w::
> +`-w`::
>  	Ignore whitespace when comparing the parent's version and
>  	the child's to find where the lines came from.
> 
>  include::diff-algorithm-option.adoc[]
> 
> ---abbrev=<n>::
> -	Instead of using the default 7+1 hexadecimal digits as the
> -	abbreviated object name, use <m>+1 digits, where <m> is at
> -	least <n> but ensures the commit object names are unique.
> +`--abbrev=<n>`::
> +	Instead of using the default _7+1_ hexadecimal digits as the
> +	abbreviated object name, use _<m>+1_ digits, where _<m>_ is at
> +	least _<n>_ but ensures the commit object names are unique.
>  	Note that 1 column
>  	is used for a caret to mark the boundary commit.
> 
> @@ -124,21 +124,21 @@ header at the minimum has the first line which has:
>  This header line is followed by the following information
>  at least once for each commit:
> 
> -- the author name ("author"), email ("author-mail"), time
> -  ("author-time"), and time zone ("author-tz"); similarly
> +- the author name (`author`), email (`author-mail`), time
> +  (`author-time`), and time zone (`author-tz`); similarly
>    for committer.
>  - the filename in the commit that the line is attributed to.
> -- the first line of the commit log message ("summary").
> +- the first line of the commit log message (`summary`).
> 
>  The contents of the actual line are output after the above
> -header, prefixed by a TAB. This is to allow adding more
> +header, prefixed by a _TAB_. This is to allow adding more
>  header elements later.
> 
>  The porcelain format generally suppresses commit information that has
>  already been seen. For example, two lines that are blamed to the same
>  commit will both be shown, but the details for that commit will be shown
>  only once. Information which is specific to individual lines will not be
> -grouped together, like revs to be marked 'ignored' or 'unblamable'. This
> +grouped together, like revs to be marked _ignored_ or _unblamable_. This

Here, I would backtick instead.

>  is more efficient, but may require more state be kept by the reader. The
>  `--line-porcelain` option can be used to output full commit information
>  for each line, allowing simpler (but less efficient) usage like:
> @@ -152,7 +152,7 @@ for each line, allowing simpler (but less efficient) 
usage
> like: SPECIFYING RANGES
>  -----------------
> 
> -Unlike 'git blame' and 'git annotate' in older versions of git, the extent
> +Unlike `git blame` and `git annotate` in older versions of git, the extent
>  of the annotation can be limited to both line ranges and revision
>  ranges. The `-L` option, which limits annotation to a range of lines, may 
be
>  specified multiple times.
> @@ -173,7 +173,7 @@ which limits the annotation to the body of the `hello`
> subroutine.
> 
>  When you are not interested in changes older than version
>  v2.6.18, or changes older than 3 weeks, you can use revision
> -range specifiers similar to 'git rev-list':
> +range specifiers similar to `git rev-list`:
> 
>  	git blame v2.6.18.. -- foo
>  	git blame --since=3.weeks -- foo
> @@ -232,7 +232,7 @@ parser (which should be quite natural for most scripting

I noted in the section "INCREMENTAL OUTPUT" that there are some descriptions 
of line output that adhere to the synopsis style. In such case, we can apply 
the style for better uniformity:

diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
index adcbb6f5dc..390c3d1361 100644
--- a/Documentation/git-blame.adoc
+++ b/Documentation/git-blame.adoc
@@ -212,8 +212,9 @@ does not contain the actual lines from the file that is 
being
 annotated.
 
 . Each blame entry always starts with a line of:
-
-       <40-byte-hex-sha1> <sourceline> <resultline> <num-lines>
++
+[synopsis]
+<40-byte-hex-sha1> <sourceline> <resultline> <num-lines>
 +
 Line numbers count from 1.
 
@@ -224,8 +225,9 @@ Line numbers count from 1.
 
 . Unlike the Porcelain format, the filename information is always
   given and terminates the entry:
-
-       "filename" <whitespace-quoted-filename-goes-here>
++
+[synopsis]
+filename <whitespace-quoted-filename-goes-here>
 +
 and thus it is really quite easy to parse for some line- and word-oriented
 parser (which should be quite natural for most scripting languages).




> languages). +
>  [NOTE]
>  For people who do parsing: to make it more robust, just ignore any
> -lines between the first and last one ("<sha1>" and "filename" lines)
> +lines between the first and last one (_<sha1>_ and _filename_ lines)

_<sha1> does not appear anywhere; I guess they referred to _<40-byte-hex-
sha1>_
filename is a keyword which appears in the line above: `filename`

>  where you do not recognize the tag words (or care about that particular
>  one) at the beginning of the "extended information" lines. That way, if
>  there is ever added information (like the commit encoding or extended

That's very good for a first try. Now, I hope that you will be ok to review my 
patches :-)

JN


