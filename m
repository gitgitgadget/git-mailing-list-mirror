From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/4] Documentation/git-merge: reword references to
 "remote" and "pull"
Date: Sat, 9 Jan 2010 22:13:57 -0600
Message-ID: <20100110041357.GF1083@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <57bddb115331a23816af772172531fb56fceace4.1263081032.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 10 05:13:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTpBf-0004I8-5a
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 05:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449Ab0AJENx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jan 2010 23:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442Ab0AJENx
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 23:13:53 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:50053 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab0AJENx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 23:13:53 -0500
Received: by gxk3 with SMTP id 3so9591956gxk.1
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 20:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LaPXIUcmSsbfAGYRx9QpMqcVStNm9Ec+xJRwMMEnbQU=;
        b=ZQKf/1kcpS2LuHSMWCPE6w11dWo1XIKVpjObc8SHpus9cowUTFhQvOe29T7M+nZfAL
         l+XiSvzQwSTNztoNHAeJfIAj7322fym0NX1gG+cjAtEfUum+zj+mqawvIgXFLj+/wM5d
         ub4jtfmbWXY1nfvVBrTDzropnzk5lDZVSLfcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vgxBZv1uloH1yG3yX7QowaQQ2vspgHk2AEFAicwMnX4T/W1F6iLbrkmKsPXVVQa+c0
         br5zAcKxUcj5eAd3ON+aVB3yP5h2UDGMQKyOS46Mq9qX7jG70h8+jGLhTh0PAmNEx14R
         NzOWaLCYqzw4S/DmajlrUMKlp5Tncc649xAWE=
Received: by 10.150.9.5 with SMTP id 5mr15917833ybi.31.1263096832248;
        Sat, 09 Jan 2010 20:13:52 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm106725iwn.5.2010.01.09.20.13.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Jan 2010 20:13:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <57bddb115331a23816af772172531fb56fceace4.1263081032.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136555>

Thomas Rast wrote:
> The git-merge manpage was written in terms of merging a "remote",
> which is no longer the case: you merge local or remote-tracking
> branches; pull is for actual remotes.
=20
Right.

> Adjust the manpage accordingly.  We refer to the arguments as
> "commits", and change instances of "remote" to "other" (where branche=
s
> are concerned) or "theirs" (where conflict sides are concerned).

Makes sense.  It might be nice to emphasize the metaphor of merging
another branch=E2=80=99s history into the current branch, but <commit>
really does seem clearer than =E2=80=98{ <branch> | <commit> }=E2=80=99=
 or any other
alternative I can come up with.

> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.tx=
t
> index e886c2e..4896587 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -10,17 +10,17 @@ SYNOPSIS
>  --------
>  [verse]
>  'git merge' [-n] [--stat] [--no-commit] [--squash] [-s <strategy>]..=
=2E
> -	[-m <msg>] <remote>...
> -'git merge' <msg> HEAD <remote>...
> +	[-m <msg>] <commit>...
> +'git merge' <msg> HEAD <commit>...
> =20
>  DESCRIPTION
>  -----------
> -This is the top-level interface to the merge machinery
> -which drives multiple merge strategy scripts.
> +Merges the history specified by <commit> into HEAD, optionally using=
 a
> +specific merge strategy.

Perhaps just

| Rejoins two or more diverging branches of development.

would be simpler.  The ability to choose a merge strategy seems more
like a detail for later.

> -The second syntax (<msg> `HEAD` <remote>) is supported for
> +The second syntax (<msg> `HEAD` <commit>...) is supported for
>  historical reasons.  Do not use it from the command line or in
> -new scripts.  It is the same as `git merge -m <msg> <remote>`.
> +new scripts.  It is the same as `git merge -m <msg> <commit>...`.

Technically, they are not entirely the same: =E2=80=98merge -m <msg>=E2=
=80=99 will
warn that the log message is ignored when the merge results in a
fast-forward, whereas =E2=80=98merge <msg> HEAD=E2=80=99 will not.  See=
 commit
77c29b4a (Revert recent "git merge <msg> HEAD <commit>..."
deprecation, 2009-12-08).  So should this say

| Use `git merge -m <msg> <commit>...` instead.

to side-step the issue?  Not sure.

> @@ -33,10 +33,10 @@ include::merge-options.txt[]
>  	used to give a good default for automated 'git merge'
>  	invocations.
> =20
> -<remote>...::
> -	Other branch heads to merge into our branch.  You need at
> -	least one <remote>.  Specifying more than one <remote>
> -	obviously means you are trying an Octopus.
> +<commit>...::
> +	Commits, usually other branch heads, to merge into our branch.
> +	You need at least one <commit>.  Specifying more than one
> +	<commit> obviously means you are trying an Octopus.

Nice.

> @@ -96,8 +96,8 @@ file matches exactly the current `HEAD` commit; oth=
erwise we
>  will write out your local changes already registered in your
>  index file along with the merge result, which is not good.
>  Because 1. involves only those paths differing between your
> -branch and the remote branch you are pulling from during the
> -merge (which is typically a fraction of the whole tree), you can
> +branch and the branch you are merging
> +(which is typically a fraction of the whole tree), you can

Hmm.  The old wording distinguishes nicely between the HEAD and
MERGE_HEAD that will be parents for the new HEAD.  From some points
of view, the new wording does not: both are branches you are
merging (though only one is an argument to 'git merge').

Sadly, I have not come up with a good expression for =E2=80=9Cthe other
commit whose history is to be incorporated into the current
branch=E2=80=9D.

Maybe we should punt and just say =E2=80=9Cthe other branch=E2=80=9D?

> @@ -202,15 +202,15 @@ You can work through the conflict with a number=
 of tools:
>     mergetool which will work you through the merge.
> =20
>   * Look at the diffs.  'git diff' will show a three-way diff,
> -   highlighting changes from both the HEAD and remote versions.
> +   highlighting changes from both the HEAD and their versions.
> =20
>   * Look at the diffs on their own. 'git log --merge -p <path>'

This is a bit awkward, since 'they' is playing two roles.  Also,
the context does not make it obvious what 'our' and 'their'
versions are.

Maybe:

|   * Look at the diffs.  'git diff' will show a three-way diff,
|     highlighting changes from both the HEAD and MERGE_HEAD
|     versions.
|
|   * Look at the diffs from each branch.  'git log --merge -p
|     <path>' will show diffs first for the HEAD version and
|     then the MERGE_HEAD version.
|
|   * Look at the originals.  'git show :1:filename' shows the
|     common ancestor, 'git show :2:filename' shows the HEAD
|     version, and 'git show :3:filename' shows the MERGE_HEAD
|     version.

Thanks for looking into this,
Jonathan
