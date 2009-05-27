From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [TopGit PATCH] tg-push: prevent multiple occurences of branches
Date: Wed, 27 May 2009 09:21:00 +0200
Message-ID: <20090527072100.GA13559@pengutronix.de>
References: <1243373820-13442-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Marc Weber <marco-oweber@gmx.de>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 27 09:26:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9DXJ-0007LY-TY
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 09:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761563AbZE0HVE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2009 03:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760792AbZE0HVE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 03:21:04 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37094 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761555AbZE0HVB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 03:21:01 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1M9DRe-0006bL-CR; Wed, 27 May 2009 09:21:02 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1M9DRc-0003XF-IA; Wed, 27 May 2009 09:21:00 +0200
Content-Disposition: inline
In-Reply-To: <1243373820-13442-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120043>

Hi Bert,

On Tue, May 26, 2009 at 11:37:00PM +0200, Bert Wesarg wrote:
> So, I finally tried tg-push and got a lot of warnings and errors:
>=20
> warning, no base found top-bases/master
> warning, no base found top-bases/master
> warning, no base found top-bases/master
> warning, no base found top-bases/master
> warning, no base found top-bases/master
> warning, no base found top-bases/master
> warning, no base found top-bases/master
> warning, no base found top-bases/master
> warning, no base found top-bases/master
> warning, no base found top-bases/master
> warning, no base found top-bases/master
>=20
>=20
> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61=
ccbd94 but expected 0000000000000000000000000000000000000000
> error: failed to lock refs/heads/master
> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61=
ccbd94 but expected 0000000000000000000000000000000000000000
> error: failed to lock refs/heads/master
> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61=
ccbd94 but expected 0000000000000000000000000000000000000000
> error: failed to lock refs/heads/master
> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61=
ccbd94 but expected 0000000000000000000000000000000000000000
> error: failed to lock refs/heads/master
> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61=
ccbd94 but expected 0000000000000000000000000000000000000000
> error: failed to lock refs/heads/master
> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61=
ccbd94 but expected 0000000000000000000000000000000000000000
> error: failed to lock refs/heads/master
> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61=
ccbd94 but expected 0000000000000000000000000000000000000000
> error: failed to lock refs/heads/master
> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61=
ccbd94 but expected 0000000000000000000000000000000000000000
> error: failed to lock refs/heads/master
> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61=
ccbd94 but expected 0000000000000000000000000000000000000000
> error: failed to lock refs/heads/master
> error: Ref refs/heads/master is at b725fc951a37854fc65945ac5bcab3bc61=
ccbd94 but expected 0000000000000000000000000000000000000000
> error: failed to lock refs/heads/master
> error: Ref refs/heads/bw/log is at a16df35cc7009b36f6f71717ae3d9a3dc2=
9987da but expected 0000000000000000000000000000000000000000
> error: failed to lock refs/heads/bw/log
> error: Ref refs/top-bases/bw/log is at b725fc951a37854fc65945ac5bcab3=
bc61ccbd94 but expected 0000000000000000000000000000000000000000
> error: failed to lock refs/top-bases/bw/log
>=20
>  ! [remote rejected] master -> master (failed to lock)
>  ! [remote rejected] master -> master (failed to lock)
>  ! [remote rejected] master -> master (failed to lock)
>  ! [remote rejected] master -> master (failed to lock)
>  ! [remote rejected] master -> master (failed to lock)
>  ! [remote rejected] master -> master (failed to lock)
>  ! [remote rejected] master -> master (failed to lock)
>  ! [remote rejected] master -> master (failed to lock)
>  ! [remote rejected] master -> master (failed to lock)
>  ! [remote rejected] master -> master (failed to lock)
>  ! [remote rejected] bw/log -> bw/log (failed to lock)
>  ! [remote rejected] refs/top-bases/bw/log -> refs/top-bases/bw/log (=
failed to lock)
hhm, does this happen because

	git push $remote master master master master

tries to lock master four times?  I'd think this is something that need=
s
fixing in git-core.
=20
> Also the result was ok this output is defintive not ok.
>=20
> To prevent multiple occurences of the same branchname we maintain the=
se in a
> file.
>=20
> In push_branch ref_exists was called, which is redundant because _dep=
_is_tgish
> tells us exactly this.
=2E.. what about breaking this out?

> ---
>  tg-push.sh |   48 +++++++++++++++++++++++++++++-------------------
>  1 files changed, 29 insertions(+), 19 deletions(-)
>=20
> diff --git a/tg-push.sh b/tg-push.sh
> index 8d09a02..c813927 100644
> --- a/tg-push.sh
> +++ b/tg-push.sh
> @@ -45,31 +45,41 @@ for name in $branches; do
>  	ref_exists "$name" || die "detached HEAD? Can't push $name"
>  done
> =20
> +_listfile=3D"$(mktemp -t tg-push-listfile.XXXXXX)"
> +trap "rm -f \"$_listfile\"" 0
> +
> +# prevent multiple occurrences of the same branch
> +add_to_list()
> +{
> +	fgrep -qx "$1" "$_listfile" ||
> +		echo "$1" >> "$_listfile"
> +}
This has complexity O(n**2) for n calls (I think).  Just writing then t=
o
the list and doing sort -u afterwards only has O(n log n) (for a
reasonable implementation of sort).

>  push_branch()
>  {
>  	# if so desired omit non tgish deps
>  	$tgish_deps_only && [ -z "$_dep_is_tgish" ] && return 0
> =20
> -	echo "$_dep"
what about $tgish_deps_only?
> -	local base=3D"top-bases/$_dep"
> -	if ref_exists "$base"; then
> -		echo "top-bases/$_dep"
> -	else
> -		echo "warning, no base found $base" 1>&2
> -	fi
> +	add_to_list "$_dep"
> +	[ -z "$_dep_is_tgish" ] ||
> +		add_to_list "top-bases/$_dep"

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
