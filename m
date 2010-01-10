From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/4] Documentation: format full commands in
 typewriter font
Date: Sat, 9 Jan 2010 21:31:33 -0600
Message-ID: <20100110033133.GE1083@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <9d10ee6a8526dc9f9c220cc6bb4b509c8cc73b0a.1263081032.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 10 04:33:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NToYS-00033e-U5
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 04:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520Ab0AJDb2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jan 2010 22:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179Ab0AJDb2
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 22:31:28 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:51499 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab0AJDb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 22:31:28 -0500
Received: by iwn32 with SMTP id 32so3966108iwn.33
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 19:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=I3qUqrFeje8szZMPMcfH/H2wez/en5pvjMDIoFoPTZg=;
        b=ndy0wW/TqJWLT02thOpG7t440hrKd8+addAIhh6HzRoHwJjZncl9t1HpvsowDW/+5w
         LzrPPFOE06wO+MjH0Vn+47C3cJLP4i4t1BhPXspv6jsCnBYq0NrxWCDPpKGWyTU+FmMB
         ICNVRVlQV+qkKzRwsSxn+xDPjTmoCoiCICAHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EsI+d3dRlDrMYokyGKRcOMmBnEvV8QEp6JavXBsjMGclEWunX2bmhDQCGi0zBWUyzv
         51c5qeRLZwubWW6A4P1+YR+ldV6Q/PfHWS43PlIDnU0W0FCaACqEYbE6tlOAEbaIxPi5
         5+UBSIIdKmsX2UcywdLQ+2odCFtl0+ZfZISxM=
Received: by 10.231.123.216 with SMTP id q24mr4117486ibr.43.1263094287262;
        Sat, 09 Jan 2010 19:31:27 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3016091iwn.15.2010.01.09.19.31.26
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Jan 2010 19:31:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9d10ee6a8526dc9f9c220cc6bb4b509c8cc73b0a.1263081032.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136550>

Thomas Rast wrote:
> * If the intent is that the user type the command exactly as given, i=
t
>   is `code`.
>   If the user is only loosely referred to a command and/or option, it
>   remains 'emphasised'.

Okay.  I think I was guilty of pushing this convention (in commits
like 2fd02c92).  If the distinction is too hazy to be useful, I think
it would be fine to always use `code`, though that would be a bigger
patch.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 23a965e..6bfd9e1 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -741,15 +741,15 @@ diff.mnemonicprefix::
>  	standard "a/" and "b/" depending on what is being compared.  When
>  	this configuration is in effect, reverse diff output also swaps
>  	the order of the prefixes:
> -'git-diff';;
> +`git diff`;;
>  	compares the (i)ndex and the (w)ork tree;
> -'git-diff HEAD';;
> +`git diff HEAD`;;
>  	 compares a (c)ommit and the (w)ork tree;
> -'git diff --cached';;
> +`git diff --cached`;;
>  	compares a (c)ommit and the (i)ndex;
> -'git-diff HEAD:file1 file2';;
> +`git-diff HEAD:file1 file2`;;

Shouldn't this use =E2=80=98git diff=E2=80=99 (no hyphen)?  Alternative=
ly, if you are
leaving this for the next commit, should the other 'git-diff' lines
keep their dash until then, too?

> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.=
txt
> index c39d957..f91c7ac 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -26,7 +26,7 @@ on the subcommand:
>   git bisect log
>   git bisect run <cmd>...
> =20
> -This command uses 'git rev-list --bisect' to help drive the
> +This command uses `git rev-list --bisect` to help drive the

Does rev-list --bisect take more arguments (i.e., isn=E2=80=99t the com=
mand
being only loosely referred to here)?

> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-=
filter-branch.txt
> index 394a77a..544836a 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -129,8 +129,8 @@ convenience functions, too.  For example, calling=
 'skip_commit "$@"'
>  will leave out the current commit (but not its changes! If you want
>  that, use 'git-rebase' instead).
>  +
> -You can also use the 'git_commit_non_empty_tree "$@"' instead of
> -'git commit-tree "$@"' if you don't wish to keep commits with a sing=
le parent
> +You can also use the `git_commit_non_empty_tree "$@"` instead of
> +`git commit-tree "$@"` if you don't wish to keep commits with a sing=
le parent
>  and that makes no change to the tree.

Not this commit=E2=80=99s topic, but perhaps =E2=80=98use the ...=E2=80=
=99 should be =E2=80=98use ...=E2=80=99
or =E2=80=98use the ... idiom=E2=80=99...

>  --tag-name-filter <command>::
> @@ -179,7 +179,7 @@ the nearest ancestor that was not excluded.
>  	and only one parent, it will hence keep merges points. Also, this
>  	option is not compatible with the use of '--commit-filter'. Though =
you
>  	just need to use the function 'git_commit_non_empty_tree "$@"' inst=
ead
> -	of the 'git commit-tree "$@"' idiom in your commit filter to make t=
hat
> +	of the `git commit-tree "$@"` idiom in your commit filter to make t=
hat
>  	happen.

=2E.. to match this.

> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.tx=
t
> index 3277f4e..04c21d3 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -193,7 +193,7 @@ After seeing a conflict, you can do two things:
> =20
>   * Decide not to merge.  The only clean-ups you need are to reset
>     the index file to the `HEAD` commit to reverse 2. and to clean
> -   up working tree changes made by 2. and 3.; 'git-reset --hard' can
> +   up working tree changes made by 2. and 3.; `git-reset --hard` can

Probably `git reset --hard` (I won=E2=80=99t mention any more of these)=
=2E

Except for the bisect-change above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

The rest looks good, and really does seem clearer in some places.

Thanks,
Jonathan
