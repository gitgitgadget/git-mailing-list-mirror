From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] glossary: remove definition of refspec and
 pathspec
Date: Sun, 07 Apr 2013 10:25:08 -0700
Message-ID: <7va9pa45jf.fsf@alter.siamese.dyndns.org>
References: <1613609657.1719438.1365347197409.JavaMail.ngmail@webmail09.arcor-online.net>
 <1013848876.1719712.1365347486383.JavaMail.ngmail@webmail09.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Apr 07 19:25:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOtLD-0004cp-0V
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934134Ab3DGRZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:25:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41624 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934124Ab3DGRZK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:25:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F2A01326E;
	Sun,  7 Apr 2013 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=eNds14iPI0LE1RpSsxLXwVGVUEU=; b=UZrSoqWme7XX2OOE+RuL
	3Lp/gUolAf/heq4pVief993V+MC7Nx+0IumPFkxgLKTECCB/COQGRBCjGSf8ptcL
	/8T4JPBdV0TEo9LvH/JmGmAjjtNYX7B9m/Kpn9joPqwunt24KuVBhgaDV0AmJ6hc
	vtJAjC74zixx8y2S2pmXxqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=PcXSCAyWsj7678/R/+7z0wRczohzdL0IVoNr+IsCYzIDdo
	3YXDL/jn/PMal5uPFGBliF3U4aNH71PmlWE6dBk3POvdBteAinHTtF9+SRblWTSV
	NtP6hbxZvjJyc3EnrGAswAl5Bk3wPURDUuub5KvNRwNxrQeWJcJccEsdF8Ilw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63B021326D;
	Sun,  7 Apr 2013 17:25:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8EEE1326A; Sun,  7 Apr
 2013 17:25:09 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19056744-9FA8-11E2-A2C6-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220337>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>

It looks, at least to me, that the patch is about "give only
definitions for refspec and pathspec" removing other excessive
information that are better left to the real manual pages.

	Subject: glossary: just define refspec and pathspec

	In the glossary, just describe what it is and what it is for
	to define these terms.  How to formulate and use refspec and
	pathspec are already described in the documentation for X
	and Y, respectively.

or something, perhaps?  By the way, what are the values of X and Y?
If there is none, some of the text lost by this patch need to be
moved to and massaged to match the flow of some documentation pages
that currently lack these information.

> ---
>  Documentation/glossary-content.txt | 64 ++------------------------------------
>  1 file changed, 2 insertions(+), 62 deletions(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 4dd0a52..f21678d 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -268,59 +268,7 @@ This commit is referred to as a "merge commit", or sometimes just a
>  	pack.
>  
>  [[def_pathspec]]pathspec::
> -       Pattern used to specify paths.
> -+
> -Pathspecs are used on the command line of "git ls-files", "git
> -ls-tree", "git add", "git grep", "git diff", "git checkout",
> -and many other commands to
> -limit the scope of operations to some subset of the tree or
> -worktree.  See the documentation of each command for whether
> -paths are relative to the current directory or toplevel.  The
> -pathspec syntax is as follows:
> -
> -* any path matches itself
> -* the pathspec up to the last slash represents a
> -  directory prefix.  The scope of that pathspec is
> -  limited to that subtree.
> -* the rest of the pathspec is a pattern for the remainder
> -  of the pathname.  Paths relative to the directory
> -  prefix will be matched against that pattern using fnmatch(3);
> -  in particular, '*' and '?' _can_ match directory separators.
> -+
> -For example, Documentation/*.jpg will match all .jpg files
> -in the Documentation subtree,
> -including Documentation/chapter_1/figure_1.jpg.
> -
> -+
> -A pathspec that begins with a colon `:` has special meaning.  In the
> -short form, the leading colon `:` is followed by zero or more "magic
> -signature" letters (which optionally is terminated by another colon `:`),
> -and the remainder is the pattern to match against the path. The optional
> -colon that terminates the "magic signature" can be omitted if the pattern
> -begins with a character that cannot be a "magic signature" and is not a
> -colon.
> -+
> -In the long form, the leading colon `:` is followed by a open
> -parenthesis `(`, a comma-separated list of zero or more "magic words",
> -and a close parentheses `)`, and the remainder is the pattern to match
> -against the path.
> -+
> -The "magic signature" consists of an ASCII symbol that is not
> -alphanumeric.
> -+
> ---
> -top `/`;;
> -	The magic word `top` (mnemonic: `/`) makes the pattern match
> -	from the root of the working tree, even when you are running
> -	the command from inside a subdirectory.
> ---
> -+
> -Currently only the slash `/` is recognized as the "magic signature",
> -but it is envisioned that we will support more types of magic in later
> -versions of Git.
> -+
> -A pathspec with only a colon means "there is no pathspec". This form
> -should not be combined with other pathspec.
> +       Pattern used to limit paths in Git commands.
>  
>  [[def_parent]]parent::
>  	A <<def_commit_object,commit object>> contains a (possibly empty) list
> @@ -389,15 +337,7 @@ should not be combined with other pathspec.
>  [[def_refspec]]refspec::
>  	A "refspec" is used by <<def_fetch,fetch>> and
>  	<<def_push,push>> to describe the mapping between remote
> -	<<def_ref,ref>> and local ref. They are combined with a colon in
> -	the format <src>:<dst>, preceded by an optional plus sign, +.
> -	For example: `git fetch $URL
> -	refs/heads/master:refs/heads/origin` means "grab the master
> -	<<def_branch,branch>> <<def_head,head>> from the $URL and store
> -	it as my origin branch head". And `git push
> -	$URL refs/heads/master:refs/heads/to-upstream` means "publish my
> -	master branch head as to-upstream branch at $URL". See also
> -	linkgit:git-push[1].
> +	<<def_ref,ref>> and local ref. 
>  
>  [[def_remote_tracking_branch]]remote-tracking branch::
>  	A regular Git <<def_branch,branch>> that is used to follow changes from
