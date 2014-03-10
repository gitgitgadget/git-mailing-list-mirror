From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH/RFC] rebase: new convenient option to edit/reword/delete
 a single commit
Date: Mon, 10 Mar 2014 09:30:24 +0100
Message-ID: <531D7820.1090403@alum.mit.edu>
References: <53159601.8020702@alum.mit.edu> <1394333354-16257-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, philipoakley@iee.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 09:30:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMvbg-0001cV-1M
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 09:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbaCJIac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2014 04:30:32 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:48788 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751675AbaCJIaa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 04:30:30 -0400
X-AuditID: 12074411-f79ab6d000002f0e-3c-531d782555d1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 6F.35.12046.5287D135; Mon, 10 Mar 2014 04:30:29 -0400 (EDT)
Received: from [192.168.69.148] (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2A8UP1k015109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 04:30:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1394333354-16257-1-git-send-email-pclouds@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsUixO6iqKtaIRts0DNf1KLrSjeTxaXP61kt
	uqe8ZbT40dLDbNE5VdbizJtGRgc2j52z7rJ7TPxynNVj+dJ1jB7Pevcweix+4OXxeZNcAFsU
	t01SYklZcGZ6nr5dAnfGkekfmQumG1d0NNxia2Ds1uhi5OSQEDCRWHPtHROELSZx4d56ti5G
	Lg4hgcuMEld2PWOHcM4zSbxo7WcBqeIV0Ja4tOEUO4jNIqAq8f7jSjYQm01AV2JRTzPYJFGB
	YInVlx9A1QtKnJz5BMwWEfCQ+LFzMyvIUGaBDYwSH39/Yu5i5OAQFoiTmNycClIjJJAocfX6
	dGYQm1PASeLw/43sICUSAuISPY1BICazgLrE+nlCIBXMAvISzVtnM09gFJyFZNkshKpZSKoW
	MDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI11cvNLNFLTSndxAiJBMEdjDNOyh1iFOBgVOLh
	PfhWJliINbGsuDL3EKMkB5OSKO+RMtlgIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8GXFAOd6U
	xMqq1KJ8mJQ0B4uSOC/fEnU/IYH0xJLU7NTUgtQimKwMB4eSBG93OVCjYFFqempFWmZOCUKa
	iYMTZDiXlEhxal5KalFiaUlGPCh644uB8QuS4gHaGwrSzltckJgLFIVoPcWoy3G77dcnRiGW
	vPy8VClx3jyQIgGQoozSPLgVsLT3ilEc6GNh3kyQKh5gyoSb9ApoCRPQkubjUiBLShIRUlIN
	jGvvTtaqYrxndXDPOff9M19ts5pWwP94NZcU932Hc0nzJPPm5c+xcT6iyCi/en79 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243712>

On 03/09/2014 03:49 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
> Prepare the todo list for you to edit/reword/delete the given commit.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Allowing multiple actions is a bit too much for my shell skills. I
>  don't really need it so I won't push it, but if somebody gives me a
>  sketch, I'll try to polish it.
>=20
>  --squash and --fixup would require two commits, making it a bit
>  awkward in option handling. Or is the fixup/squash always HEAD?

These commands always squash/fixup the indicated commit with the
previous one.  I think the same approach that you use below should work
for these commands, too.

>  Documentation/git-rebase.txt | 11 +++++++++++
>  git-rebase--interactive.sh   | 17 ++++++++++++++---
>  git-rebase.sh                | 22 +++++++++++++++++++++-
>  3 files changed, 46 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.=
txt
> index 2a93c64..becb749 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -13,6 +13,7 @@ SYNOPSIS
>  'git rebase' [-i | --interactive] [options] [--exec <cmd>] [--onto <=
newbase>]
>  	--root [<branch>]
>  'git rebase' --continue | --skip | --abort | --edit-todo
> +'git rebase' [--edit | -E | --reword | -R | --delete | -D ] <commit-=
ish>
> =20
>  DESCRIPTION
>  -----------
> @@ -356,6 +357,16 @@ unless the `--fork-point` option is specified.
>  	user edit that list before rebasing.  This mode can also be used to
>  	split commits (see SPLITTING COMMITS below).
> =20
> +-E=3D<commit>::
> +--edit=3D<commit>::
> +-R=3D<commit>::
> +--reword=3D<commit>::
> +-D=3D<commit>::
> +--delete=3D<commit>::
> +	Prepare the todo list to edit or reword or delete the
> +	specified commit. Configuration variable `rebase.autostash` is
> +	ignored.

If I understand correctly, when one of these options is used, the edito=
r
is not presented to the user at all.  If so, then it is probably
confusing to emphasize "the todo list", because the user will never see
it.  How about

    Edit, reword, or delete the specified commit, replaying subsequent
    commits on top of it (like running `git rebase --interactive
    commit^` and then changing the command on the line containing
    commit). If conflicts arise when replaying the later commits,
    resolve them and run "git rebase --continue", as usual. The
    configuration variable `rebase.autosquash` is ignored when these
    options are used.

> +
>  -p::
>  --preserve-merges::
>  	Instead of ignoring merges, try to recreate them.
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index a1adae8..3ded4c7 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1040,9 +1040,20 @@ fi
>  has_action "$todo" ||
>  	die_abort "Nothing to do"
> =20
> -cp "$todo" "$todo".backup
> -git_sequence_editor "$todo" ||
> -	die_abort "Could not execute editor"
> +if test -n "$one_action"
> +then
> +	commit=3D"`git rev-parse --short $one_commit`"
> +	sed "1s/pick $commit /$one_action $commit /" "$todo" > "$todo.new" =
||

It wouldn't hurt to anchor this pattern at the beginning of the line.  =
I
understand that it wouldn't help, either (assuming everything else is
working right), but it makes the intention clearer.

> +		die_abort "failed to update todo list"
> +	grep "^$one_action $commit " "$todo.new" >/dev/null ||
> +		die_abort "expected to find '$one_action $commit' line but did not=
"

The die_aborts above is really an internal consistency check, right?  I=
f
so, maybe it should start with "internal error:" so that the user
doesn't think that he has done something wrong.

> +	mv "$todo.new" "$todo" ||
> +		die_abort "failed to update todo list"
> +else
> +	cp "$todo" "$todo".backup
> +	git_sequence_editor "$todo" ||
> +		die_abort "Could not execute editor"
> +fi
> =20
>  has_action "$todo" ||
>  	die_abort "Nothing to do"
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 5f6732b..2acffb4 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -32,6 +32,9 @@ verify             allow pre-rebase hook to run
>  rerere-autoupdate  allow rerere to update index with resolved confli=
cts
>  root!              rebase all reachable commits up to the root(s)
>  autosquash         move commits that begin with squash!/fixup! under=
 -i
> +E,edit=3D!           generate todo list to edit this commit
> +R,reword=3D!         generate todo list to reword this commit's mess=
age
> +D,delete=3D!         generate todo list to delete this commit
>  committer-date-is-author-date! passed to 'git am'
>  ignore-date!       passed to 'git am'
>  whitespace=3D!       passed to 'git apply'
> @@ -228,6 +231,7 @@ then
>  fi
>  test -n "$type" && in_progress=3Dt
> =20
> +one_action=3D
>  total_argc=3D$#
>  while test $# !=3D 0
>  do
> @@ -290,6 +294,7 @@ do
>  		;;
>  	--autostash)
>  		autostash=3Dtrue
> +		explicit_autosquash=3Dt

Should that be "explicit_autostash"?

>  		;;
>  	--verbose)
>  		verbose=3Dt
> @@ -335,6 +340,13 @@ do
>  	--gpg-sign=3D*)
>  		gpg_sign_opt=3D"-S${1#--gpg-sign=3D}"
>  		;;
> +	--edit=3D*|--reword=3D*|--delete=3D*)
> +		test -n "$one_action" && die "$(gettext "--edit, --reword or --del=
ete cannot be used multiple times")"
> +		interactive_rebase=3Dexplicit
> +		one_action=3D"${1%=3D*}"
> +		one_action=3D"${one_action#--}"
> +		one_commit=3D"${1#--*=3D}"
> +		;;

Is "delete" a valid todo-list command?  I would have thought that you
would change the command to "#pick" in the case of "--delete".

>  	--)
>  		shift
>  		break
> @@ -342,6 +354,7 @@ do
>  	esac
>  	shift
>  done
> +test -n "$one_action" && test $# -gt 0 && usage
>  test $# -gt 2 && usage
> =20
>  if test -n "$cmd" &&
> @@ -438,7 +451,14 @@ else
>  	state_dir=3D"$apply_dir"
>  fi
> =20
> -if test -z "$rebase_root"
> +if test -n "$one_action"
> +then
> +	upstream_name=3D"$one_commit^"
> +	upstream=3D$(peel_committish "${upstream_name}") ||
> +	die "$(eval_gettext "invalid upstream \$upstream_name")"
> +	upstream_arg=3D"$upstream_name"
> +	test -n "$explicit_autosquash" || autosquash=3D
> +elif test -z "$rebase_root"

It would be nice if these options (though not --squash and --fixup)
would support editing the root commit.  The logic would be similar to
the code in the "else" branch of this "if" chain.

>  then
>  	case "$#" in
>  	0)
>=20

Cheers,
Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
