From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] topgit tg push feature
Date: Thu, 7 May 2009 07:45:21 +0200
Message-ID: <36ca99e90905062245w1ec78828ice5ed18161b6ec43@mail.gmail.com>
References: <20090425161300.GD19142@gmx.de> <20090425163447.GE19142@gmx.de>
	 <20090505093448.GC16524@gmx.de> <20090507045904.GA2068@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org,
	u.kleine-koenig@pengutronix.de
X-From: git-owner@vger.kernel.org Thu May 07 07:45:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1wQG-0004Yh-Gj
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 07:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbZEGFpY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2009 01:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbZEGFpX
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 01:45:23 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:60858 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbZEGFpX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 01:45:23 -0400
Received: by fk-out-0910.google.com with SMTP id 18so304364fkq.5
        for <git@vger.kernel.org>; Wed, 06 May 2009 22:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=bQp8VTRsaN+eSZj5aET5w2tm+c4DLcBwV7IkQrvEMzQ=;
        b=a0Zs8qIskqigl9mXLmroESqKDeQY15aGtRXYTNzS9zW+BXpFqzE3W2UXgdTAmbqI9H
         uZOXIXncBrbc68dzqIYBrRVCCF3+7pu6Pm7aTeIj7W5M47FQ7DSMIWMI0TiDjENsMyNI
         UL3dWPyS0i/dqjes/NHtxFRGVjU6JsAUKJpck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=sn/u+DBIxaRnNrHW0xKc9CXegJ8eO00gLWirdSHekAD3iUCHkbBzZYejVOcNnViwzz
         DbE/57iYBdMZB418wEJqkqXt4fu/y/BZA9qOfmHAmmtQol+uqygeTg/tOoyPjUhPl327
         1n7n0jp+7tpTb+KQF4z+MYIKpTIewvgrBBSgY=
Received: by 10.223.119.198 with SMTP id a6mr1330487far.42.1241675122329; Wed, 
	06 May 2009 22:45:22 -0700 (PDT)
In-Reply-To: <20090507045904.GA2068@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118426>

On Thu, May 7, 2009 at 06:59, Marc Weber <marco-oweber@gmx.de> wrote:
> Uwe K,
>
> what do you think. Is there still much to change to include this patc=
h into
> upstream?
I think its a usefull tool, but I haven't tested it yet.

>
> new patch version. adding small comment saying that the two options
> --ne-deps and --tgish-only will seldomly used..
>
> Sincerly
> Marc Weber
>
> commit c1cff518e3f70e9bd6cb4f2119b86e506ab43776
> Author: Marc Weber <marco-oweber@gmx.de>
> Date: =C2=A0 Thu May 7 06:46:28 2009 +0200
>
> =C2=A0 =C2=A0t/tg-push
>
> =C2=A0 =C2=A0add tg-push =C2=A0pushing the branch, its deps and their=
 bases
>
> =C2=A0 =C2=A0Usage: tg push [(--no-deps | --tgish-only)] remote*
>
> =C2=A0 =C2=A0Signed-off-by: Marc Weber <marco-oweber@gmx.de>
>
> diff --git a/README b/README
> index d2f095d..6f2b2bc 100644
> --- a/README
> +++ b/README
> @@ -480,6 +480,19 @@ tg update
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0TODO: tg update -a for updating all topic =
branches
>
> +tg push
> + =C2=A0 =C2=A0 =C2=A0 Usage: tg push [(--no-deps | --tgish-only)] re=
mote*
no need to repeat yourself. 'tg help push' will print the usage from
tg-push first. And where is the --dry-run option?

> +
> + =C2=A0 =C2=A0 =C2=A0 $git push remote branch # this doesn't push th=
e base.
> + =C2=A0 =C2=A0 =C2=A0 $git push remote =C2=A0 =C2=A0 =C2=A0 =C2=A0# =
pushes all branches (and bases)
> + =C2=A0 =C2=A0 =C2=A0 You use
> +
> + =C2=A0 =C2=A0 =C2=A0 $tg push remote
> + =C2=A0 =C2=A0 =C2=A0 to push the current branch,
> its deps and their both tgish and non-tgish deps.
This phrase needs rewording, what about: "its deps, both their tgish
and non-tgish ones."

> You may add --no-deps and or --tgish-only
> + =C2=A0 =C2=A0 =C2=A0 to change this default behaviour. Probably you=
n never want
> + =C2=A0 =C2=A0 =C2=A0 to do this
I think a "use these only if you know what you are doing" is better.

> +
> =C2=A0TODO: tg rename
>
>
> diff --git a/tg-push.sh b/tg-push.sh
> new file mode 100644
> index 0000000..49124e6
> --- /dev/null
> +++ b/tg-push.sh
> @@ -0,0 +1,69 @@
> +#!/bin/sh
> +# TopGit - A different patch queue manager
> +# GPLv2
> +
> +remotes=3D
> +
> +## Parse options see README
> +
> +recurse_deps=3D1
> +tgish_deps_only=3D
> +
> +while [ -n "$1" ]; do
> + =C2=A0 =C2=A0 =C2=A0 arg=3D"$1"; shift
> + =C2=A0 =C2=A0 =C2=A0 case "$arg" in
> + =C2=A0 =C2=A0 =C2=A0 --no-deps)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 recurse_deps=3D;;
> + =C2=A0 =C2=A0 =C2=A0 --dry-run)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dry_run=3D1;;
> + =C2=A0 =C2=A0 =C2=A0 --tgish-only)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tgish_deps_only=3D=
1;;
> + =C2=A0 =C2=A0 =C2=A0 *)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remotes=3D"$remote=
s $arg";;
> + =C2=A0 =C2=A0 =C2=A0 esac
> +done
now i see why you have the Usage: in the README. common practice is to
print the usage if an unknown option was given. see all the other
tg-*.sh scripts.

> +
> +if [ -z "$remotes" ]; then
> + =C2=A0 =C2=A0 =C2=A0 remotes=3D"$(git config topgit.remote 2>/dev/n=
ull)"
> +fi
How effetcts the tg -r REMOTE option this command. Or more exactly why
doesn't have this option an effect here?

> +
> +if [ -z "$remotes" ]; then
> + =C2=A0 =C2=A0 =C2=A0 die "no remote location given. Either add a re=
mote as additional argument or set topgit.remote"
> +fi
> +
> +name=3D"$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
> +ref_exists "$name" || die "detached HEAD? Can't push that"
the common error message is: "not a TopGit-controlled branch".

> +
> +push_branch(){
> + =C2=A0 =C2=A0 =C2=A0 # don't push remotes
> + =C2=A0 =C2=A0 =C2=A0 [ -z "${_dep##refs/remotes/*}" ] && return 0
> + =C2=A0 =C2=A0 =C2=A0 # if so desired omit non tgish deps
> + =C2=A0 =C2=A0 =C2=A0 [ -z "$tgish_deps_only" ] || [ -n "$_dep_is_tg=
ish" ] || return 0
> +
> + =C2=A0 =C2=A0 =C2=A0 echo "$_dep"
> + =C2=A0 =C2=A0 =C2=A0 local base=3D"top-bases/$_dep"
> + =C2=A0 =C2=A0 =C2=A0 if ref_exists "$base"; then
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "top-bases/$_=
dep"
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "warning, no =
base found $base" 1>&2
> + =C2=A0 =C2=A0 =C2=A0 fi
> +}
> +
> +for remote in $remotes; do
> + =C2=A0 =C2=A0 =C2=A0 list=3D"$(
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # deps
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ -n "$recurse_=
deps" ]; then
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 recurse_deps push_branch "$name"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # current branch
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _dep=3D"$name"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _dep_is_tgish=3D1
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 push_branch "$name=
"
> + =C2=A0 =C2=A0 =C2=A0 )"
> + =C2=A0 =C2=A0 =C2=A0 echo "pushing:"; echo $list
> + =C2=A0 =C2=A0 =C2=A0 if [ -n "$dry_run" ]; then
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo git push $rem=
ote $list
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git push $remote $=
list
> + =C2=A0 =C2=A0 =C2=A0 fi
why not pass the --dry-run option to git remote?

> +done

Bert
