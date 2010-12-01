From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] git-add.txt: Order options alphabetically
Date: Wed, 01 Dec 2010 13:53:42 -0500
Message-ID: <1291229622.11917.14.camel@drew-northup.unet.maine.edu>
References: <1291218145-13016-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jari.aalto@cante.net
X-From: git-owner@vger.kernel.org Wed Dec 01 19:54:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNrop-0000er-E7
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 19:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab0LASyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 13:54:10 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:41995 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900Ab0LASyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 13:54:08 -0500
Received: from [130.111.39.151] (drew-northup.unet.maine.edu [130.111.39.151])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id oB1IrlG2014011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 1 Dec 2010 13:53:47 -0500
In-Reply-To: <1291218145-13016-1-git-send-email-jari.aalto@cante.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=2 Fuz1=2
	Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: oB1IrlG2014011
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1291834438.04127@72WtSkdoTGH1U52QoCSCLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162572>


On Wed, 2010-12-01 at 17:42 +0200, jari.aalto@cante.net wrote:
> From: Jari Aalto <jari.aalto@cante.net>
> 
> 
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/git-add.txt |  106 ++++++++++++++++++++++----------------------
>  1 files changed, 53 insertions(+), 53 deletions(-)
> 
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 54aaaeb..83751c6 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -46,24 +46,26 @@ be used to add ignored files with the `-f` (force) option.
>  Please see linkgit:git-commit[1] for alternative ways to add content to a
>  commit.
>  
> -
>  OPTIONS
>  -------
> -<filepattern>...::
> -	Files to add content from.  Fileglobs (e.g. `*.c`) can
> -	be given to add all matching files.  Also a
> -	leading directory name (e.g. `dir` to add `dir/file1`
> -	and `dir/file2`) can be given to add all files in the
> -	directory, recursively.
>  
> --n::
> ---dry-run::
> -	Don't actually add the file(s), just show if they exist and/or will
> -	be ignored.
> +-A::
> +--all::
> +	Like `-u`, but match <filepattern> against files in the
> +	working tree in addition to the index. That means that it
> +	will find new files as well as staging modified content and
> +	removing files that are no longer in the working tree.
>  
> --v::
> ---verbose::
> -        Be verbose.
> +-e, \--edit::
> +	Open the diff vs. the index in an editor and let the user
> +	edit it.  After the editor was closed, adjust the hunk headers
> +	and apply the patch to the index.
> ++
> +The intent of this option is to pick and choose lines of the patch to
> +apply, or even to modify the contents of lines to be staged. This can be
> +quicker and more flexible than using the interactive hunk selector.
> +However, it is easy to confuse oneself and create a patch that does not
> +apply to the index. See EDITING PATCHES below.
>  
>  -f::
>  --force::
> @@ -76,6 +78,30 @@ OPTIONS
>  	operation to a subset of the working tree. See ``Interactive
>  	mode'' for details.
>  
> +--ignore-errors::
> +	If some files could not be added because of errors indexing
> +	them, do not abort the operation, but continue adding the
> +	others. The command shall still exit with non-zero status.
> +
> +--ignore-missing::
> +	This option can only be used together with --dry-run. By using
> +	this option the user can check if any of the given files would
> +	be ignored, no matter if they are already present in the work
> +	tree or not.
> +
> +-n::
> +--dry-run::
> +	Don't actually add the file(s), just show if they exist and/or will
> +	be ignored.
> +
> +-N::
> +--intent-to-add::
> +	Record only the fact that the path will be added later. An entry
> +	for the path is placed in the index with no content. This is
> +	useful for, among other things, showing the unstaged content of
> +	such files with `git diff` and committing them with `git commit
> +	-a`.
> +
>  -p::
>  --patch::
>  	Interactively choose hunks of patch between the index and the
> @@ -87,16 +113,9 @@ This effectively runs `add --interactive`, but bypasses the
>  initial command menu and directly jumps to the `patch` subcommand.
>  See ``Interactive mode'' for details.
>  
> --e, \--edit::
> -	Open the diff vs. the index in an editor and let the user
> -	edit it.  After the editor was closed, adjust the hunk headers
> -	and apply the patch to the index.
> -+
> -The intent of this option is to pick and choose lines of the patch to
> -apply, or even to modify the contents of lines to be staged. This can be
> -quicker and more flexible than using the interactive hunk selector.
> -However, it is easy to confuse oneself and create a patch that does not
> -apply to the index. See EDITING PATCHES below.
> +--refresh::
> +	Don't add the file(s), but only refresh their stat()
> +	information in the index.
>  
>  -u::
>  --update::
> @@ -111,41 +130,22 @@ If no <filepattern> is given, default to "."; in other words,
>  update all tracked files in the current directory and its
>  subdirectories.
>  
> --A::
> ---all::
> -	Like `-u`, but match <filepattern> against files in the
> -	working tree in addition to the index. That means that it
> -	will find new files as well as staging modified content and
> -	removing files that are no longer in the working tree.
> -
> --N::
> ---intent-to-add::
> -	Record only the fact that the path will be added later. An entry
> -	for the path is placed in the index with no content. This is
> -	useful for, among other things, showing the unstaged content of
> -	such files with `git diff` and committing them with `git commit
> -	-a`.
> -
> ---refresh::
> -	Don't add the file(s), but only refresh their stat()
> -	information in the index.
> -
> ---ignore-errors::
> -	If some files could not be added because of errors indexing
> -	them, do not abort the operation, but continue adding the
> -	others. The command shall still exit with non-zero status.
> -
> ---ignore-missing::
> -	This option can only be used together with --dry-run. By using
> -	this option the user can check if any of the given files would
> -	be ignored, no matter if they are already present in the work
> -	tree or not.
> +-v::
> +--verbose::
> +        Be verbose.
>  
>  \--::
>  	This option can be used to separate command-line options from
>  	the list of files, (useful when filenames might be mistaken
>  	for command-line options).
>  
> +<filepattern>...::
> +	Files to add content from.  Fileglobs (e.g. `*.c`) can
> +	be given to add all matching files.  Also a
> +	leading directory name (e.g. `dir` to add `dir/file1`
> +	and `dir/file2`) can be given to add all files in the
> +	directory, recursively.
> +
>  
>  Configuration
>  -------------

Jari,
First off, this patch (and set I've seen thus far) has little no commit
message. Second (lacking a commit message to tell me), WHY? Some
projects order options alphabetically and some in the order they are
expected to be most often used. Other documentation writers just specify
the options in the same order they were provided in the synopsis (which
can rarely be successfully alphabetized). Some have no order whatsoever.

So again I ask, why make this change? Did you plan on changing the the
short help displayed by git add -h as well?



-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
