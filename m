From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] More typofixes.
Date: Mon, 29 Jul 2013 10:55:41 -0400
Message-ID: <51F6826D.2010606@xiplink.com>
References: <20130729081821.GA6758@domone.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Jul 29 16:55:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3or9-0007pB-M6
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 16:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757000Ab3G2OzX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jul 2013 10:55:23 -0400
Received: from smtp114.ord1c.emailsrvr.com ([108.166.43.114]:35773 "EHLO
	smtp114.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753755Ab3G2OzW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jul 2013 10:55:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp7.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 29ECC1B8131;
	Mon, 29 Jul 2013 10:55:22 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp7.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C39A01B8194;
	Mon, 29 Jul 2013 10:55:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130729081821.GA6758@domone.kolej.mff.cuni.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231284>

On 13-07-29 04:18 AM, Ond=C5=99ej B=C3=ADlka wrote:
> Hi,
>=20
> I improved my tool and it catched following additional typos.
>=20
> As with any big project best way to catch errors is to have automated
> checks that catch them ( Other possibility would be to read everythin=
g ten
> times to get error rate down but nobody wants to do it).
>=20
> If you want you could add a pre-commit hook=20
> stylepp-spellcheck --hook
> that checks comments for likely typos (misspells by aspell and not
> occurring in code). It uses aspell to identify them so you need to=20
> teach aspell which words are valid.=20
>=20
> I would like make possible to share dictionaries so teaching phase ca=
n
> be done only once instead for each person but I did not found suitabl=
e
> workflow yet.

Unfortunately no automated system is perfect (see some of my comments b=
elow).
 I'm all for an automated system that identifies potential misspellings=
, but
I'm wary of anything that attempts to automatically correct perceived e=
rrors,
or that can't be overruled.  In the end a human must make the final dec=
ision.

> Signed-off-by: Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz>
>=20
> diff --git a/pathspec.c b/pathspec.c
> index 6ea0867..27ffe77 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -40,7 +40,7 @@ void add_pathspec_matches_against_index(const char =
**pathspec,
>  /*
>   * Finds which of the given pathspecs match items in the index.
>   *
> - * This is a one-shot wrapper around add_pathspec_matches_against_in=
dex()
> + * This is an one-shot wrapper around add_pathspec_matches_against_i=
ndex()

As many others have already said, this is not a typo.

The use of "a" or "an" depends on whether or not the O's sound is hard =
or
soft.  So although we say "an orange" we also say "a one-in-a-million c=
hance".

>=20
>  [ ... snip ... ]
>=20

> diff --git a/Documentation/RelNotes/1.7.9.1.txt b/Documentation/RelNo=
tes/1.7.9.1.txt
> index 6957183..e8fddb8 100644
> --- a/Documentation/RelNotes/1.7.9.1.txt
> +++ b/Documentation/RelNotes/1.7.9.1.txt
> @@ -20,7 +20,7 @@ Fixes since v1.7.9
>     submodule that only has uncommitted local changes in the patch
>     prepared by for the user to edit.
> =20
> - * Typo in "git branch --edit-description my-tpoic" was not diagnose=
d.
> + * Typo in "git branch --edit-description my-topic" was not diagnose=
d.

Here "tpoic" is illustrating the typo that was being misdiagnosed.

>=20
>  [ ... snip ... ]
>=20

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e0b923f..8420aff 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -434,11 +434,11 @@ core.repositoryFormatVersion::
>  	version.
> =20
>  core.sharedRepository::
> -	When 'group' (or 'true'), the repository is made shareable between
> +	When 'group' (or 'true'), the repository is made sharable between
>  	several users in a group (making sure all the files and objects are
>  	group-writable). When 'all' (or 'world' or 'everybody'), the
>  	repository will be readable by all users, additionally to being
> -	group-shareable. When 'umask' (or 'false'), Git will use permission=
s
> +	group-sharable. When 'umask' (or 'false'), Git will use permissions

"Sharable" is the North American spelling.  AFAIK git doesn't specify w=
hat
kind of English the documentation source files should use.  Perhaps one=
 day
there'll be en_UK and en_US translations, and all the sources will be w=
ritten
in Klingon...

Until that day, or until the git project starts to care a lot more abou=
t
English style, I think patches that translate spellings between English
variants are a bit of a waste of time.

>=20
>  [ ... snip ... ]
>=20

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manua=
l.txt
> index fe723e4..1491d69 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3116,7 +3116,7 @@ Trust
>  If you receive the SHA-1 name of a blob from one source, and its con=
tents
>  from another (possibly untrusted) source, you can still trust that t=
hose
>  contents are correct as long as the SHA-1 name agrees.  This is beca=
use
> -the SHA-1 is designed so that it is infeasible to find different con=
tents
> +the SHA-1 is designed so that it is unfeasible to find different con=
tents
>  that produce the same hash.
> =20
>  Similarly, you need only trust the SHA-1 name of a top-level tree ob=
ject

Both "infeasible" and "unfeasible" are in common usage.  If you want to=
 avoid
future patches going back and forth on this, try "not feasible".

		M.
