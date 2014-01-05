From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Sun, 5 Jan 2014 13:24:58 -0800
Message-ID: <20140105212458.GG3156@odin.tremily.us>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <20140105194850.GA2994@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Jan 05 22:25:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzvC2-0005uB-H7
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 22:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbaAEVZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 16:25:03 -0500
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:57916
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751550AbaAEVZB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jan 2014 16:25:01 -0500
Received: from omta09.westchester.pa.mail.comcast.net ([76.96.62.20])
	by qmta08.westchester.pa.mail.comcast.net with comcast
	id AMQ01n0010SCNGk58MR0iF; Sun, 05 Jan 2014 21:25:00 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta09.westchester.pa.mail.comcast.net with comcast
	id AMQy1n018152l3L3VMQzat; Sun, 05 Jan 2014 21:25:00 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 82F4AE8AAB4; Sun,  5 Jan 2014 13:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1388957098; bh=IqO6Olk6aeXxBUTcYA/VYKa6nfaYEyq9PI6sqgyyT/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=frsm2B6z02msxPnERkaYjFyHE6YOxL7kCyFniJaQaWdnhz8Gl1u0mFtlfVTt3jKKD
	 ZCujxCnmuRZFsi6gRWwCUqjY9yAzhDc4KysYYVw5P4fuZrdA8VfMzuUhSm+8AWG6Ju
	 hOQvXOdLTpoUvLiAZrzL4/qza4GMb0i94gIo12uw=
Content-Disposition: inline
In-Reply-To: <20140105194850.GA2994@book.hvoigt.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1388957100;
	bh=kYcs1cG6g708kGvG8G53FgQiqMDvVtrVjuOpffZzT6c=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=JSvW18Y/0b3vVzWGhomRPRw/gCSy6KA+PRRMPV07T42AN+Gu4Jjx4RwxwfWNw/QM6
	 x/5ckqUZW3YT/t2VUa8wPXs3C/lPVTLnqqHkmAvNe094Fq+TIG7GbgQ3KGC+0yUgRx
	 PMEGq5hIrg3wz+gl9ZkZ7ZYOdwFJoXzb8ccH3GnOnvMakI8oMaHVtJgliRG/7NuVfM
	 sy0zCgmbFR3IB/51F0DfTg5YTjvsdnv/t83KAuoomsh6Tn/Uds75fgnDLKKE2UcVyH
	 rN7kNmknKU+oONFWd0FXNcp1ttSrXh2U1vww9Gwv70akZ1QspqspdiRTjGximD1qTj
	 rhOj5Xfz7Of3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239973>


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 05, 2014 at 08:48:50PM +0100, Heiko Voigt wrote:
> On Sun, Jan 05, 2014 at 08:17:00AM -0800, W. Trevor King wrote:
> > It's not clear if this refers to the initial-clone update, future
> > post-clone updates, or both.  Ideally, the behavior should be the
> > same, but in the initial-clone case we don't have an existing
> > checked-out branch to work with.
>=20
> I do not think that its actually important to end up with a detached
> HEAD. The documentation just states it because in most cases there
> is no other option. But I do not think anything will break if a
> branch points to the exact sha1 we would checkout and we checkout
> the branch instead.

There's no "if the remote-tracking branch points to the exact sha1"
logic in my patch.  If submodule.<name>.branch is set, it *always*
creates a new local branch of that name pointing to the exact sha1.
If submodule.<name>.branch is not set, we still create a detached-HEAD
checkout of the exact sha1.  Thinking through this more, perhaps the
logic should be:

* If submodule.<name>.update (defaulting to checkout) is checkout,
  create a detached HEAD.
* Otherwise, create a new branch submodule.<name>.branch (defaulting
  to master).

The motivation is that if submodule.<name>.update is checkout, the
user is unlikely to be developing locally in the submodule, as
subsequent updates would clobber their local commits.  Having a
detached HEAD is a helpful "don't develop here" reminder ;).  If
submodule.<name>.update is set, the user is likely to be developing
locally, and will probably want a local branch already checked out to
facilitate that.

> > -			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" || exit
> > +			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" "$conf=
ig_branch" || exit
>=20
> In the simple case (update=3Dcheckout, no branch specified) with the
> new checkout branch stuff in module_clone() this code here ends up
> calling checkout twice.  First for master and then here later with
> the sha1.  This feels a little bit double.

There is no guarantee that the remote master and the exact sha1 point
at the same commit.  Ideally we'd just clone the exact sha1 in this
case.

> I would prefer if we skip the checkout in module_clone() if its not
> necessary.

When I tried to drop the '' case here:

> > @@ -306,7 +307,15 @@ module_clone()
> >  	echo "gitdir: $rel/$a" >"$sm_path/.git"
> > =20
> >  	rel=3D$(echo $a | sed -e 's|[^/][^/]*|..|g')
> > -	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=3D. git config c=
ore.worktree "$rel/$b")
> > +	(
> > +		clear_local_git_env
> > +		cd "$sm_path" &&
> > +		GIT_WORK_TREE=3D. git config core.worktree "$rel/$b" &&
> > +		case "$branch" in
> > +		'') git checkout -f -q ;;
> > +		?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
> > +		esac
> > +	) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path=
'")"
> >  }

I got test-suite errors that I didn't get to the bottom of.  However=E2=80=
=A6

> How about we move the whole "what to checkout"-decision into one place
> instead of having it in update() and moving it from add() into
> module_clone() ?

=E2=80=A6this sounds like a good idea to me.  However, it would be a more
intrusive change, and there may be conflicts with Francesco's proposed
attach/detach functionality.  I'll wait until we have a clearer idea
of where that is headed before I attempt a more complete
consolidation.

> > -				update_module=3D ;;
> > +				if test -n "$config_branch"; then
> > +					update_module=3D"!git reset --hard -q"
>=20
> If we get here the checkout has already been done. Shouldn't this
> rather specify a noop. I.E. like
>=20
> 	update_module=3D"!true"

We are on a local branch at this point, but not neccessarily pointing
at the gitlinked sha1.  The reset here ensures that the new local
branch does indeed point at the gitlinked sha1.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyc2oAAoJEKKfehoaNkbtVCIP/0mIL/pE0TkGp8CyEGJ4nNpH
U4gdoy7pqZfjBGDejjxd7hsUJ624gP6KvxZXJFcFBWSDSrEpenBKZfLaxZroK5li
2WYYN6DpV6zHqx5aSe56X9T3lPLGcXh3J7x3BwviCUgf82TOumweguOf7K+cK9MV
VhX1zE7EKN0cRcZceABqvAjgu/ANH3isxXM3lbDN5S7FlbTLG9ytFzo5BtLqS7Oz
Fe+AdmtO6mGvVTBtujrRWfp8W2vpW3h0t7CuH7qFdOm6iMPmL850wk7P+OvS+/nB
YfLnYFjK5FstlSpJZqEB/Lx9VKldpJ3h4JhUmeQLCuUMEO2v4YS7yZ/F81rkPdNU
H6l+nqI1cZiUPnBSG8IbB1IhGOG9qZ4CjNItG+S/ohfp9pVxAM2zRolIQoqvUSzJ
DP5qHnqi5LJzdeVuW6P72aku9iaDIlsVj2opv3xHGg91seO2vAyKNc6SY36/Pzic
+jqtLyz8TjknlAdMTqlgcLKrcVoan/ZyBjZi/ljekbMsrlDto5+M76mID2yz2vZa
cFfwZLN8jLwePtTa0MnO0Xg5ghHmFpzJrTc4FWsKCveyrtYQyTSPuh0Qu32pI27t
vDuzKjj2fDwwf9RrL/DVekO58HjVys3mf7kyGJzal4NcyyQzs0Lqs9kPh+L7xtqM
0Ti7zrPvmHvq634i7Im1
=fD/s
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
