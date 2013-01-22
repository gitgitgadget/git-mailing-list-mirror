From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] Change 'git' to 'Git' whenever the whole system
 is referred to #1
Date: Tue, 22 Jan 2013 15:48:02 -0800
Message-ID: <7vsj5slqz1.fsf@alter.siamese.dyndns.org>
References: <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <1430594044.632790.1358795873467.JavaMail.ngmail@webmail20.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davvid@gmail.com, git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 00:48:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxnZv-0002cZ-Am
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 00:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330Ab3AVXsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 18:48:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab3AVXsH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 18:48:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86CAAB77B;
	Tue, 22 Jan 2013 18:48:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DXP2TC4tcJnDwA/SQSe+tCHi+Ys=; b=t/YbmN
	7JkFD8H5hQVA1ni3Zx2GV1m7wfBHvBGonZ7KLsFT/L37pbONmfoWMRexobm1oglf
	2s57eU5bYVZs0WwGemB7sJj7qUMe42nTRGxYDxSRo8zUUH8cudeuq1LksHNNMGlG
	ac7cydiIQ94NVf7RxKc1xtTnpRRw5iokGC9hw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NfdoXsYCGKHiTZRSFpfspYTVD7w7nE74
	Scn+7PbvMvlB2esJ6aZxebUGdRjiHyEDkrdxUlVfqSvsJWG36n1WzaFOCaObORf6
	Kmst/AMwZUidVjjraZZ7sH5H6nT62+NZFU57+MpwFojSdIa6flqDJblFuRHf6I3j
	NFu4yebXZGg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B9DBB77A;
	Tue, 22 Jan 2013 18:48:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FE37B777; Tue, 22 Jan 2013
 18:48:04 -0500 (EST)
In-Reply-To: <1430594044.632790.1358795873467.JavaMail.ngmail@webmail20.arcor-online.net>
 (Thomas Ackermann's message of "Mon, 21 Jan 2013 20:17:53 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A117E8C-64EE-11E2-BA56-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214263>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---

> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index 9f42c0d..14bdbbb 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -33,7 +33,7 @@ OPTIONS
>  
>  -f::
>  --force::
> -	If the git configuration variable clean.requireForce is not set
> +	If the Git configuration variable clean.requireForce is not set
>  	to false, 'git clean' will refuse to run unless given -f or -n.

Before this description, -d option talks about a different Git
repository; s/git/Git/ is needed there.

> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 597048b..47d9880 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -214,7 +214,7 @@ objects from the source repository into a pack in the cloned repository.
>  	Instead of placing the cloned repository where it is supposed
>  	to be, place the cloned repository at the specified directory,
>  	then make a filesytem-agnostic git symbolic link to there.

Shouldn't this be "Git symbolic link"?


> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 971977b..a7a4f75 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -347,7 +347,7 @@ install-webdoc : html
>  	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(WEBDOC_DEST)
>  
>  # You must have a clone of git-htmldocs and git-manpages repositories
> -# next to the git repository itself for the following to work.
> +# next to the Git repository itself for the following to work.
>  
>  quick-install: quick-install-man

This is *wrong*.  It refers to the name of the repository whose
natural name is "git", as most people get it by

	git clone git://git.kernel.org/pub/scm/git/git.git

and telling the users to do

	git clone git://git.kernel.org/pub/scm/git/git-htmldocs.git
	git clone git://git.kernel.org/pub/scm/git/git-manpages.git

in the same directory as they cloned git.git into (i.e. have these
two next to their clone of git.git, which is typically called "git").

I'll revert this part.

> diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
> index 262436b..1e5ef3b 100644
> --- a/Documentation/git-rm.txt
> +++ b/Documentation/git-rm.txt
> @@ -74,7 +74,7 @@ DISCUSSION
>  
>  The <file> list given to the command can be exact pathnames,
>  file glob patterns, or leading directory names.  The command
> -removes only the paths that are known to git.  Giving the name of
> +removes only the paths that are known to Git.  Giving the name of
>  a file that you have not told git about does not remove that file.

This should be "you have not told Git about".


> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index e2301f5..c07ad61 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt

> @@ -29,7 +29,7 @@ The command will only rewrite the _positive_ refs mentioned in the
>  command line (e.g. if you pass 'a..b', only 'b' will be rewritten).
>  If you specify no filters, the commits will be recommitted without any
>  changes, which would normally have no effect.  Nevertheless, this may be
> -useful in the future for compensating for some git bugs or such,
> +useful in the future for compensating for some Git bugs or such,
>  therefore such a usage is permitted.

The description before this hunk begins with "Lets you rewrite git
version history", which you need s/git/Git/.

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 9a914d0..3a62f50 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -525,8 +525,8 @@ $ git format-patch -M -B origin
>  Additionally, it detects and handles renames and complete rewrites
>  intelligently to produce a renaming patch.  A renaming patch reduces
>  the amount of text output, and generally makes it easier to review.
> -Note that non-git "patch" programs won't understand renaming patches, so
> -use it only when you know the recipient uses git to apply your patch.
> +Note that non-Git "patch" programs won't understand renaming patches, so
> +use it only when you know the recipient uses Git to apply your patch.

Unrelated to the topic of this series, but didn't GNU patch add this
recently?  Somebody needs a fact-check and may have to update the
above with something like "prior to GNU patch x.y..."


> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> index 9e0b3f6..071e947 100644
> --- a/Documentation/git-help.txt
> +++ b/Documentation/git-help.txt
> @@ -14,7 +14,7 @@ DESCRIPTION
>  -----------
>  
>  With no options and no COMMAND given, the synopsis of the 'git'
> -command and a list of the most commonly used git commands are printed
> +command and a list of the most commonly used Git commands are printed
>  on the standard output.
>  
>  If the option '--all' or '-a' is given, then all available commands are

After this hunk there is

	If a git command is named, a manual page for that...

It is trying to refer to things like "cat-file" as "git command"
(even though technically I would call them "subcommands"), and I
would say "cat-file" is a subcommand of the system whose whole is
known as "Git".  So I think s/git/Git/ is warranted here.

> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index 9ac2bba..2571f56 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -58,19 +58,19 @@ DIRECTORY" section below.)
>  --separate-git-dir=<git dir>::
>  
>  Instead of initializing the repository where it is supposed to be,
> -place a filesytem-agnostic git symbolic link there, pointing to the
> -specified git path, and initialize a git repository at the path. The
> -result is git repository can be separated from working tree. If this
> +place a filesytem-agnostic Git symbolic link there, pointing to the
> +specified Git path, and initialize a Git repository at the path. The
> +result is Git repository can be separated from working tree. If this

Not a problem with this conversion, but I think "pointing to the
specified [gG]it path" should be without "[gG]it".  There is nothing
specially Git about the path to the directory the user specifies. It
is just an ordinary filesystem path.


I'll try to fix all of the above up locally and re-queue, so please
eyeball the results once it is pushed out.
