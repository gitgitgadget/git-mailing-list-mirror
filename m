From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH] man: git pull -r is a short for --rebase
Date: Fri, 17 Aug 2012 12:48:52 -0700
Message-ID: <7vk3wxti3f.fsf@alter.siamese.dyndns.org>
References: <20120816095018.GD5489@suse.cz>
 <7v1uj63iyx.fsf@alter.siamese.dyndns.org>
 <2BB1E674DD214C66B06660612F34109D@PhilipOakley>
 <7vk3wy1t7l.fsf@alter.siamese.dyndns.org>
 <B7310EA0CC00423EB5B26E3FAAB54541@PhilipOakley>
 <7vfw7mvy40.fsf_-_@alter.siamese.dyndns.org>
 <4E6C3BEFBD5345CC9FE0DC3C3AD41788@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Miklos Vajna" <vmiklos@suse.cz>, "Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 21:49:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2SXY-0006bv-1v
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 21:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066Ab2HQTs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 15:48:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754004Ab2HQTs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 15:48:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 215389827;
	Fri, 17 Aug 2012 15:48:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UALBkeZ0Gmiz5S6kyLm7i8zCvbg=; b=Ut379I
	mhuiN56dIHQWJYxoQlSHstRXsfggSbC5ORWHsQuFxN9M4Ze4HqIMxNwMTdOLerZq
	CyM87Lzp1P0YV4pl7sxCZOuDXKHi1Kgf4B2jbpENirCMqJgQxtc1ElxsgS6g+keR
	4OGnKPQW/1ti+iaih2665JywCOlCH1S0/x5BY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FeYGgoVnLEHq/hjhvpdk2VfSDx2+R8LO
	XuMbuQK7sJUxxgrCNyatCAMmF1XE7CJxxyrOwHHQVAR8sSxRfo5wASiSwTVF7Qw1
	UC+v9OS5DlpddnJ5hWyLC4OXnwzFCbgK/3o6nQ2Gw1plr4jPrXO9Ua+OjnUPJsIg
	S84qiPIu9pc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1023D9826;
	Fri, 17 Aug 2012 15:48:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14B9E9821; Fri, 17 Aug 2012
 15:48:53 -0400 (EDT)
In-Reply-To: <4E6C3BEFBD5345CC9FE0DC3C3AD41788@PhilipOakley> (Philip Oakley's
 message of "Fri, 17 Aug 2012 19:22:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9345C9EC-E8A4-11E1-B44C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203640>

"Philip Oakley" <philipoakley@iee.org> writes:

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index ca85d1d..75b35ce 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -22,11 +22,13 @@ unusually rich command set that provides both high-level operations
>  and full access to internals.
>  
>  See linkgit:gittutorial[7] to get started, then see
> -link:everyday.html[Everyday Git] for a useful minimum set of commands, and
> -"man git-commandname" for documentation of each command.  CVS users may
> -also want to read linkgit:gitcvs-migration[7].  See
> -the link:user-manual.html[Git User's Manual] for a more in-depth
> -introduction.
> +link:everyday.html[Everyday Git] for a useful minimum set of commands.
> +Use "man git-commandname" for documentation of each command, or "git help".
> +
> +CVS users may also want to read linkgit:gitcvs-migration[7].
> +
> +See the link:user-manual.html[Git User's Manual] for a more in-depth
> +introduction, and linkgit:gitcli[7] for details of git's command line interface.
>  
>  The '<command>' is either a name of a Git command (see below) or an alias
>  as defined in the configuration file (see linkgit:git-config[1]).

I would prefer to keep the description section of git(1) not overly
long.

The first paragraph (not much shown above) concisely describes what
Git is, so that people who were interested in other "git" can
quickly tell that this is not a page to read about it.  I think it
is in good shape.

The purpose of the second paragraph is to guide people who are not
ready to dive into this page and refer them to other pages with the
introductory material, and also tell them that they can come back to
this page to learn the set of commands Git offers once they are
familiar with the concepts.

And then, before going into the list of commands, we should tell
them what we are listing, and where they can find more information.

So in that sense, we would really want to keep the second paragraph
short and to the point.  Referring migrating CVS users to another
page before they get acquainted with Git like the current page does
is a mistake.  On the other hand, gitcli may deserve to be mentioned
in the third paragraph that gives the reader the sense of the overall
structure of the documentation.

The mention of cvs migration used to be more important in earlier
days, but I think it was out of place to have it early in the
document even back then.  It probably can be moved down to the
FURTHER DOCUMENTATION section.

So how about doing it this way?

-- >8 --
Subject: [PATCH] Documentation: update the introductory section

The second paragraph in the git(1) description section were meant to
guide people who are not ready to dive into this page away from here.
Referring migrating CVS users to another page before they get
acquainted with Git was somewhat out of place.  Move the reference to
the "FURTHER DOCUMENTATION" section and push that section down.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 60 +++++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index eb6b2c0..33028a9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -22,18 +22,17 @@ unusually rich command set that provides both high-level operations
 and full access to internals.
 
 See linkgit:gittutorial[7] to get started, then see
-link:everyday.html[Everyday Git] for a useful minimum set of commands, and
-"man git-commandname" for documentation of each command.  CVS users may
-also want to read linkgit:gitcvs-migration[7].  See
-the link:user-manual.html[Git User's Manual] for a more in-depth
-introduction.
+link:everyday.html[Everyday Git] for a useful minimum set of
+commands.  The link:user-manual.html[Git User's Manual] has a more
+in-depth introduction.
 
-The '<command>' is either a name of a Git command (see below) or an alias
-as defined in the configuration file (see linkgit:git-config[1]).
+After you mastered the basic concepts, you can come back to this
+page to learn what commands git offers.  You can learn more about
+individual git commands with "git help command".  linkgit:gitcli[7]
+manual page gives you an overview of the command line command syntax.
 
-Formatted and hyperlinked version of the latest git
-documentation can be viewed at
-`http://git-htmldocs.googlecode.com/git/git.html`.
+Formatted and hyperlinked version of the latest git documentation
+can be viewed at `http://git-htmldocs.googlecode.com/git/git.html`.
 
 ifdef::stalenotes[]
 [NOTE]
@@ -406,24 +405,6 @@ help ...`.
 	linkgit:git-replace[1] for more information.
 
 
-FURTHER DOCUMENTATION
----------------------
-
-See the references above to get started using git.  The following is
-probably more detail than necessary for a first-time user.
-
-The link:user-manual.html#git-concepts[git concepts chapter of the
-user-manual] and linkgit:gitcore-tutorial[7] both provide
-introductions to the underlying git architecture.
-
-See linkgit:gitworkflows[7] for an overview of recommended workflows.
-
-See also the link:howto-index.html[howto] documents for some useful
-examples.
-
-The internals are documented in the
-link:technical/api-index.html[GIT API documentation].
-
 GIT COMMANDS
 ------------
 
@@ -843,6 +824,29 @@ The index is also capable of storing multiple entries (called "stages")
 for a given pathname.  These stages are used to hold the various
 unmerged version of a file when a merge is in progress.
 
+FURTHER DOCUMENTATION
+---------------------
+
+See the references in the "description" section to get started
+using git.  The following is probably more detail than necessary
+for a first-time user.
+
+The link:user-manual.html#git-concepts[git concepts chapter of the
+user-manual] and linkgit:gitcore-tutorial[7] both provide
+introductions to the underlying git architecture.
+
+See linkgit:gitworkflows[7] for an overview of recommended workflows.
+
+See also the link:howto-index.html[howto] documents for some useful
+examples.
+
+The internals are documented in the
+link:technical/api-index.html[GIT API documentation].
+
+Users migrating from CVS may also want to
+read linkgit:gitcvs-migration[7].
+
+
 Authors
 -------
 Git was started by Linus Torvalds, and is currently maintained by Junio
-- 
1.7.12.rc3.71.ge297db8
