From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Feedback on submitting patches / here submodule
Date: Sun, 09 Nov 2014 17:24:58 +0100
Message-ID: <545F955A.1050700@web.de>
References: <D08510BB.15149%th.freudenberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Tom Freudenberg <th.freudenberg@googlemail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 17:25:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnVIq-0002yl-Ma
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 17:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbaKIQZK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2014 11:25:10 -0500
Received: from mout.web.de ([212.227.17.11]:49992 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbaKIQZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 11:25:09 -0500
Received: from [192.168.178.41] ([79.211.122.101]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LtFUV-1YAqwg1PEh-012l82; Sun, 09 Nov 2014 17:25:01
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <D08510BB.15149%th.freudenberg@gmail.com>
X-Provags-ID: V03:K0:yi1fmz/fs6Rr2k9M32C2k96a0px2jWM+ACIsTgFotHHzl1DQEka
 /ph0AIW4cwhNUibmw7KkR1diJgqhHORNXtcw475RyXKU03ETw5uyYBsVFzk4T4VoY0cbrLR
 vAa8YVC3vT+2SCw/JDps/PcwPjSqsDjnrwuL2ihOfxpIOr5YTOrs1Mueo2n9ljSiQfZRctr
 N+akGaoL7za4zFxqqJeIA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.11.2014 um 12:39 schrieb Tom Freudenberg:
> Hi, a few weeks ago I send out attached message and patch to
> gitster-at-pobox.com tried to follow the guidelines.
>
> Have not get any feedback until now, neither acceptance nor decline =E2=
=80=A6 just
> no feedback.
>
> I am not sure if the message was received or this is some kind of int=
ended
> procedure.
>  From my personal point of view it would be nice and polite to get an
> answer for postings.
>
> Hopefully I got some feedback from this list to whom I should send th=
e
> patch for review or denial.

A patch should go to: gitster@pobox.com /and/ cc: git@vger.kernel.org
(and optinally any people relevant to the area you are touching). Just
sending it to Junio will most probably result in it being overlooked
in his overflowing inbox (please see Documentation/SubmittingPatches
for a more detailed description).

> Thanks
> Tom
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> =3D
>
> Subject: FEATURE: submodule: checkout and update from remote stay tra=
cked
> to upstream
>
>
> Hi, hopefully I added everything that you will check this feature
> if it could be merged to git-submodule.sh
>
> If have not yet added tests nor documentation. If you agree on
> this feature in general, I will make the additional work for
> tests and documentation.

The same goal was pursued by Trevor some time ago in 23d25e48f
("submodule: explicit local branch creation in module_clone"),
and was considered a worthwhile change. You can find the whole
discussion here:

   http://thread.gmane.org/gmane.comp.version-control.git/239799

But it had to be reverted shortly after because it broke detached
HEAD checkouts quite badly, details under:

   http://thread.gmane.org/gmane.comp.version-control.git/245283

You're welcome to revive this topic.

> Patch is for working on maint as well as on master.
>
> Diff is available also on my git fork on github at:
>
> https://github.com/TomFreudenberg/git/compare/git:master...TomFreuden=
berg:m
> aster-added-feature-submodule-track
>
>
> Thanks for some feedback.
> Tom
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> submodule: checkout and update from remote stay tracked to upstream
>
> With this change, cloning submodules for the first time or running
> updates afterwards via:
>
> $ git submodule update =E2=80=B9remote =E2=80=B9track ...
>
> will get a local branch instead of a detached HEAD. Following updates
> check track to upstream branch and merge if matching. Checkout to
> detached head can be forced afterwards. Checkout will test and warn
> if checkout modes are not compatible.
>
> The motivation for the change is that developers doing local work
> inside the submodule are likely to select a non-checkout-mode for
> updates so their local work is integrated with upstream work.
> Developers who are not doing local submodule work stick with
> checkout-mode updates so any apparently local work is blown away
> during updates.  For example, if upstream rolls back the remote branc=
h
> or gitlinked commit to an earlier version, the checkout-mode develope=
r
> wants their old submodule checkout to be rolled back as well, instead
> of getting a no-op merge/rebase with the rolled-back reference.
>
> By using the update mode to distinguish submodule developers from
> black-box submodule consumers, we can setup local branches for the
> developers who will want local branches, and stick with detached HEAD=
s
> for the developers that don't care.
>
>
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> Not yet updated
>
>
>
> Documentation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Not yet updated
>
>
>
> Signed-off-by: Tom Freudenberg <tom.freudenberg@4commerce.de>
>
>
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 9245abf..60a2145 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -9,7 +9,7 @@ USAGE=3D"[--quiet] add [-b <branch>] [-f|--force] [--=
name
> <name>] [--reference <re
>      or: $dashless [--quiet] status [--cached] [--recursive] [--]
> [<path>...]
>      or: $dashless [--quiet] init [--] [<path>...]
>      or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
> -   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch=
]
> [-f|--force] [--checkout|--merge|--rebase] [--reference <repository>]
> [--recursive] [--] [<path>...]
> +   or: $dashless [--quiet] update [--init] [--remote [--track]]
> [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--referen=
ce
> <repository>] [--recursive] [--] [<path>...]
>      or: $dashless [--quiet] summary [--cached|--files] [--summary-li=
mit
> <n>] [commit] [--] [<path>...]
>      or: $dashless [--quiet] foreach [--recursive] <command>
>      or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
> @@ -31,6 +31,7 @@ recursive=3D
> init=3D
> files=3D
> remote=3D
> +track=3D
> nofetch=3D
> update=3D
> prefix=3D
> @@ -736,6 +737,9 @@ cmd_update()
> 		--remote)
> 			remote=3D1
> 			;;
> +		--track)
> +			test -n "$remote" && track=3D"--track" || usage
> +			;;
> 		-N|--no-fetch)
> 			nofetch=3D1
> 			;;
> @@ -837,10 +841,14 @@ Maybe you want to use 'update --init'?")"
> 			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || ex=
it
> 			cloned_modules=3D"$cloned_modules;$name"
> 			subsha1=3D
> +			subupstream=3D
> 		else
> 			subsha1=3D$(clear_local_git_env; cd "$sm_path" &&
> 				git rev-parse --verify HEAD) ||
> 			die "$(eval_gettext "Unable to find current revision in submodule =
path
> '\$displaypath'")"
> +			# get optional upstream info
> +			subupstream=3D$(clear_local_git_env; cd "$sm_path" &&
> +				git rev-parse --symbolic-full-name --abbrev-ref '@{u}' 2>/dev/nu=
ll)
> 		fi
> 		if test -n "$remote"
> @@ -855,6 +863,21 @@ Maybe you want to use 'update --init'?")"
> 			sha1=3D$(clear_local_git_env; cd "$sm_path" &&
> 				git rev-parse --verify "${remote_name}/${branch}") ||
> 			die "$(eval_gettext "Unable to find current ${remote_name}/${branc=
h}
> revision in submodule path '\$sm_path'")"
> +			# track upsteam
> +			if test -n "$track"
> +			then
> +				if test -z "$subsha1"
> +				then
> +					# first time checkout use symbol name to track
> +					sha1=3D"${remote_name}/${branch}"
> +				else
> +					# test that already on the same upstream
> +					test "${remote_name}/${branch}" =3D "$subupstream" ||
> +					die "$(eval_gettext "Unable to merge. Current does not track
> upstream ${remote_name}/${branch} in submodule path '\$sm_path'")"
> +					# just merge with upstream
> +					update_module=3D"merge"
> +				fi
> +			fi
> 		fi
> 		if test "$subsha1" !=3D "$sha1" || test -n "$force"
> @@ -883,10 +906,17 @@ Maybe you want to use 'update --init'?")"
> 				update_module=3Dcheckout ;;
> 			esac
> +			if test "$update_module" =3D "checkout"
> +			then
> +				# warn and abort if on upstream and not forced
> +				test -n "$subupstream" -a -z "$subforce" &&
> +					die "$(eval_gettext "Use --force to checkout detached HEAD.
> Currently on upstream ${remote_name}/${branch} in submodule path
> '\$sm_path'")"
> +			fi
> +
> 			must_die_on_failure=3D
> 			case "$update_module" in
> 			checkout)
> -				command=3D"git checkout $subforce -q"
> +				command=3D"git checkout $subforce $track -q"
> 				die_msg=3D"$(eval_gettext "Unable to checkout '\$sha1' in submodu=
le
> path '\$displaypath'")"
> 				say_msg=3D"$(eval_gettext "Submodule path '\$displaypath': checke=
d out
> '\$sha1'")"
> 				;;
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
