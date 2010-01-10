From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/4] Documentation: spell 'git cmd' without dash
 throughout
Date: Sat, 9 Jan 2010 20:56:41 -0600
Message-ID: <20100110025641.GB1083@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <9516c897017ec420403bb7f687fb8962de42cb7c.1263081032.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 10 03:56:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTnyx-0004cm-7h
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 03:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529Ab0AJC4k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Jan 2010 21:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440Ab0AJC4k
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 21:56:40 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:63574 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab0AJC4j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 21:56:39 -0500
Received: by yxe17 with SMTP id 17so19520148yxe.33
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 18:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bcxJzjy6+ryBWuXMn9hRuhWI2vhGiV5YluEGQ8wz3JI=;
        b=LPNwNcUlAlbYXdSwsPRWISYgQ1T3Kq+8Gm/ths8VTxv10KrwX+AOc2JQoSVXWqqBtU
         GDBFvtvcumkPkP+VN2JFd824OU3O1+azZt3T7uGqVvKTqr3gDRiLzBZ82HACmne82ynj
         +V5KA/4jbJ3V9HUCgTU6jxTKxhA/6YjND1LvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EfswDjO32JysKYDIpDhI01PSot9xyvI3MH5hgYb9aErXiuEhdZFNKBH885+cvTCL75
         v1vFe3V+/bsnZF+ie0xXCafalk7WNugnTKSs9Vyxj6/KHwT1MIpzn3JOo90RManv9MK4
         LqXbKg1AYiZkskGHiBeSiq2zkNqoTjlrTnVIg=
Received: by 10.101.133.24 with SMTP id k24mr4279027ann.116.1263092198799;
        Sat, 09 Jan 2010 18:56:38 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm422279iwn.11.2010.01.09.18.56.37
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Jan 2010 18:56:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9516c897017ec420403bb7f687fb8962de42cb7c.1263081032.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136547>

Thomas Rast wrote:

> Replace 'git-cmd' with 'git cmd' throughout, except where git-shell,
> git-cvsserver, git-upload-pack, git-receive-pack, and
> git-upload-archive are concerned, because those really live in the
> $PATH.

Agreed.  Some forms of 'man' even support 'man git am', so the "it's
what you pass to 'man'" excuse does not even apply any more.

>  110 files changed, 584 insertions(+), 584 deletions(-)

But yikes!  Did you do this by hand or by some automated process?

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6bfd9e1..db28408 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -64,7 +64,7 @@ The values following the equals sign in variable as=
sign are all either
>  a string, an integer, or a boolean.  Boolean values may be given as =
yes/no,
>  0/1, true/false or on/off.  Case is not significant in boolean value=
s, when
>  converting value to the canonical form using '--bool' type specifier=
;
> -'git-config' will ensure that the output is "true" or "false".
> +'git config' will ensure that the output is "true" or "false".
> =20
>  String values may be entirely or partially enclosed in double quotes=
=2E
>  You need to enclose variable values in double quotes if you want to
> @@ -442,7 +442,7 @@ core.pager::
> =20
>  core.whitespace::
>  	A comma separated list of common whitespace problems to
> -	notice.  'git-diff' will use `color.diff.whitespace` to
> +	notice.  'git diff' will use `color.diff.whitespace` to
>  	highlight them, and 'git-apply --whitespace=3Derror' will

A 'git-apply' snuck in. ;-)

> @@ -563,24 +563,24 @@ branch.autosetuprebase::
[...]
>  	Specify multiple values to get an octopus merge.
> -	If you wish to setup 'git-pull' so that it merges into <name> from
> +	If you wish to setup 'git pull' so that it merges into <name> from

Not relevant to this patch, but shouldn't =E2=80=98setup=E2=80=99 be =E2=
=80=98set up=E2=80=99?

> @@ -718,14 +718,14 @@ commit.template::
>  	specified user's home directory.
> =20
>  diff.autorefreshindex::
> -	When using 'git-diff' to compare with work tree
> +	When using 'git diff' to compare with work tree
>  	files, do not consider stat-only change as changed.
>  	Instead, silently run `git update-index --refresh` to
>  	update the cached stat information for paths whose
>  	contents in the work tree match the contents in the
>  	index.  This option defaults to true.  Note that this
> -	affects only 'git-diff' Porcelain, and not lower level
> -	'diff' commands, such as 'git-diff-files'.
> +	affects only 'git diff' Porcelain, and not lower level
> +	'diff' commands, such as 'git diff-files'.

This sounds better to me without the comma before =E2=80=98such as=E2=80=
=99.

> @@ -840,7 +840,7 @@ format.pretty::
>  	linkgit:git-whatchanged[1].
> =20
>  format.thread::
> -	The default threading style for 'git-format-patch'.  Can be
> +	The default threading style for 'git format-patch'.  Can be
>  	either a boolean value, `shallow` or `deep`.  `shallow`
>  	threading makes every mail a reply to the head of the series,
>  	where the head is chosen from the cover letter, the

The =E2=80=98either=E2=80=99 here sounds awkward, because there are thr=
ee options.
Also it is not completely clear that =E2=80=98shallow=E2=80=99 and =E2=80=
=98deep=E2=80=99 are not
boolean values here.  So maybe =E2=80=98Can be a boolean value, or shal=
low or
deep=E2=80=99, despite the awkward nested =E2=80=98or=E2=80=99 expressi=
on.

> @@ -875,18 +875,18 @@ gc.autopacklimit::
>  	default	value is 50.  Setting this to 0 disables it.
> =20
>  gc.packrefs::
> -	'git-gc' does not run `git pack-refs` in a bare repository by
> +	'git gc' does not run `git pack-refs` in a bare repository by
>  	default so that older dumb-transport clients can still fetch
> -	from the repository.  Setting this to `true` lets 'git-gc'
> +	from the repository.  Setting this to `true` lets 'git gc'
>  	to run `git pack-refs`.  Setting this to `false` tells

Should be =E2=80=98lets git gc run=E2=80=99 or =E2=80=98tells git gc to=
 run=E2=80=99.  Not to mention
this is not true any more: 'git gc' has run pack-refs by default ever
since commit 56752391 (Make "git gc" pack all refs by default,
2007-05-24).  As that commit message mentions, git versions before
v1.5.1.2 cannot clone repos with packed refs over http, and git
versions before v1.4.4 cannot handled packed refs period, but more
recent git should have no problems.

So to summarize, the changes to config.txt look good, except a
=E2=80=98git-apply=E2=80=99 snuck past.

The other changes mentioned above follow.

  Documentation: config: git gc packs refs by default now
  Documentation: tiny git config manual tweaks

 Documentation/config.txt |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)
