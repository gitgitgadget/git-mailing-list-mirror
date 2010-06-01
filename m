From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/8] Documentation/cherry-pick: describe passing more
 than one commit
Date: Tue, 1 Jun 2010 04:51:24 -0500
Message-ID: <20100601095124.GA1033@progeny.tock>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
 <20100531194240.28729.50475.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 11:51:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJO8G-00076f-Az
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 11:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab0FAJvb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 05:51:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47606 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539Ab0FAJva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 05:51:30 -0400
Received: by iwn6 with SMTP id 6so722763iwn.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=a9EfRC94qsI4ycta2BxXLjuGOoOcQOZIQyrW2Xc6OYU=;
        b=plaB7cNGY7a1g/o+alB27Cr97aXG/qzyO+dzDtrS/6nIkiKVzgJs350YmcKFjPDJdb
         f+cac1yPpImWjBknF5Qu7KHeHmUGC0WclZnAxFzRFWpkfSxj8RPVI8RgF8wClKZRSAtm
         0XtY8ysAxjFoNFPe3nkgOn04ijkrJPPOCYK9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VrZvbbppXeXsGp4xwULbAGd+4s1sWUmqAd4P6Ig0VjiBZ1TD6y3e+utRoxyyN5Yk0N
         U5VjEu/EqOqwMc4RqsSH6hycsrJrv9hfeMvT0q1zm/2qW4vSWvdqcm23aNM+YYcqjN0x
         qV+WcjlcVtaRNwPS/B6orqwi8+BDu+zwlii9Y=
Received: by 10.231.156.1 with SMTP id u1mr7491992ibw.46.1275385889881;
        Tue, 01 Jun 2010 02:51:29 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id t28sm30605273ibg.0.2010.06.01.02.51.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 02:51:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100531194240.28729.50475.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148105>

Christian Couder wrote:

> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -3,24 +3,29 @@ git-cherry-pick(1)
> =20
>  NAME
>  ----
> -git-cherry-pick - Apply the change introduced by an existing commit
> +git-cherry-pick - Apply the change introduced by some existing commi=
ts

Maybe s/change/changes/.

>  DESCRIPTION
>  -----------
> -Given one existing commit, apply the change the patch introduces, an=
d record a
> -new commit that records it.  This requires your working tree to be c=
lean (no
> -modifications from the HEAD commit).
> +
> +Given one or more existing commits, apply the changes that the relat=
ed
> +patches introduce, and record some new commits that record them.  Th=
is
> +requires your working tree to be clean (no modifications from the HE=
AD
> +commit).

"Related" made me think "related how"?  "Record some new commits"
sounds oddly vague.

Maybe:

	Given one or more existing commits, apply the change each one
	introduces, recording a new commit for each.  This requires
	your working tree to be clean (no modifications from the HEAD
	commit).

>  OPTIONS
>  -------
> -<commit>::
> -	Commit to cherry-pick.
> +<commit>...::
> +	Commits to cherry-pick.
>  	For a more complete list of ways to spell commits, see the
>  	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
> +	Sets of commits can also be given but no traversal is done
> +	by default, see linkgit:git-rev-list[1] and its '--no-walk'
> +	option.

--no-walk can be a bit confusing.  I think we should try to avoid
relying on the reader understanding it.

 <commit>...::
	Commits to cherry-pick.
	For a more complete list of ways to spell commits, see the
	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
	Revision ranges are interpreted as though specified with
	the `--no-walk` option; see the "Examples" section below.

>  -e::
>  --edit::
> @@ -55,13 +60,12 @@ OPTIONS
> =20
>  -n::
>  --no-commit::
> -	Usually the command automatically creates a commit.
> -	This flag applies the change necessary to cherry-pick
> -	the named commit to your working tree and the index,
> -	but does not make the commit.  In addition, when this
> -	option is used, your index does not have to match the
> -	HEAD commit.  The cherry-pick is done against the
> -	beginning state of your index.
> +	Usually the command automatically creates some commits.  This
> +	flag applies the change necessary to cherry-pick the named
> +	commits to your working tree and the index, but does not make
> +	the commits.  In addition, when this option is used, your
> +	index does not have to match the HEAD commit.  The cherry-pick
> +	is done against the beginning state of your index.

This switches between singular and plural.

 -n::
 --no-commit::
	Usually 'git cherry-pick' automatically creates a sequence
	of commits.  This option can be used to apply the changes
	necessary to cherry-pick each named commit to your working
	tree and index without making any commits.  In addition,
	when this option is used, your index does not have to match
	the HEAD commit: the cherry-pick is done against the
	beginning state of the index.

>  +
>  This is useful when cherry-picking more than one commits'
>  effect to your index in a row.

	This is useful for cherry-picking multiple commits
	to produce a single new commit.

> @@ -75,6 +79,38 @@ effect to your index in a row.
>  	cherry-pick'ed commit, then a fast forward to this commit will
>  	be performed.
> =20
> +Examples
> +--------

These are a little repetitive.

> +git cherry-pick master::
> +
> +	Apply the changes specified by the commit pointed to by master
> +	and create a new commit with these changes.

git cherry-pick master::

	Apply the change introduced by the commit at the tip of the
	master branch and create a new commit.

> +
> +git cherry-pick master~3..master::
> +git cherry-pick ^master~3 master::
> +
> +	Apply the changes specified by the last 3 commits pointed to
> +	by master and create 3 new commits with these changes.

git cherry-pick ..master::
git cherry-pick ^HEAD master::

	Apply the changes introduced by all commits that are ancestors
	of master but not HEAD to produce new commits on the current
	branch.

> +git cherry-pick master\~3 master~2::
> +
> +	Apply the changes specified by the fourth and third last
> +	commits pointed to by master and create 2 new commits with
> +	these changes.

git cherry-pick master~5 master~2::

	Apply the changes introduced by the fifth- and second-generation
	grandparents of master to HEAD as new commits.

> +
> +git cherry-pick -n master~1 next::
> +
> +	Apply to the working tree and the index the changes specified
> +	by the second last commit pointed to by master and by the last
> +	commit pointed to by next, but do not create any commit with
> +	these changes.

git rev-list master -- README | git cherry-pick -n --stdin::

	Apply the changes introduced by all commits on the master
	branch that touched README to the working tree and index,
	so the result can be inspected and made into a single new
	commit if suitable.

> +
> +git cherry-pick --ff ..next::
> +
> +	If possible fast forward to the existing commits already in
> +	next but not in HEAD, otherwise apply the changes specified by
> +	these commits and create new commits with these changes.

git cherry-pick --ff ..next::

	If history is linear and HEAD is an ancestor of next, update
	the working tree and advance the HEAD pointer to match next.
	Otherwise, apply the changes introduced by those commits that
	are in next but not HEAD to the current branch, creating a new
	commit for each new change.

(This is not precisely right, since it doesn=E2=80=99t describe the beh=
avior
in some cases of nonlinear history:

   . --- . --- . --- . ---. next
  /                      /
 . HEAD             .---.

In this case, assuming time flows left-to-right, the HEAD would
fast-forward three commits, then cherry-pick the other three.  Not
sure how to word this nicely.)

Hope that helps,
Jonathan
