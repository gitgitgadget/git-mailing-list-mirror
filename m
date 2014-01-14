From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Tight submodule bindings
Date: Mon, 13 Jan 2014 18:44:26 -0800
Message-ID: <20140114024426.GB23617@odin.tremily.us>
References: <cover.1389247320.git.wking@tremily.us>
 <20140112010847.GJ29954@odin.tremily.us>
 <xmqqk3e35y3p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 14 03:44:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2tzW-0002dV-IP
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 03:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbaANCob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 21:44:31 -0500
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:42955
	"EHLO qmta05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751362AbaANCo3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jan 2014 21:44:29 -0500
Received: from omta15.westchester.pa.mail.comcast.net ([76.96.62.87])
	by qmta05.westchester.pa.mail.comcast.net with comcast
	id DZb51n0041swQuc55ekUlx; Tue, 14 Jan 2014 02:44:28 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta15.westchester.pa.mail.comcast.net with comcast
	id DekS1n00y152l3L3bekThU; Tue, 14 Jan 2014 02:44:28 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 877CEED0C61; Mon, 13 Jan 2014 18:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389667466; bh=bnjDbPILidC/eIlTloJKp7jCDF+m6jOMAyEe2gycEIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nCfpHyqRwTExm0H/H0Z0j+bDeAyQ/jDvFluVqbYjd4DKL0FHILIj6v8GzNhTVjrKC
	 JiaXr9BZ/Il84kytCqiGB83a187HJw0VFEU/b4n88FvW6HfWxfeAQD7j4I5JJR8X2P
	 F067OlmwTgy7cv+8uHtNa4nXzMpVp2ZjzePBH3/0=
Content-Disposition: inline
In-Reply-To: <xmqqk3e35y3p.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389667468;
	bh=Gq4JPBbfrN0NcxgDFQ9yK9taEndA4gDHO3tGAH/96UE=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=sJrxlOJK7HYOQwanZFVowh2LYRnmgbbsMOgAlz1A4XyBLsEfFJjMEZb6nDPxe9eB6
	 7gNyxnsSsbKtCq9vIfJhC2O2rcxOuIG+1mQJG9IWM3nUWinrblLj4BqItpaVzpYBLm
	 kjBcn4j8vEqGrv8eNoZXhPGnAXyV2MbX/r9/8M8arL15xH0BDM1WZlhxx/TuqWpAGY
	 lNPYXgzgtLsXkhpyPqcvIy/Hat7N6txpKHG7qR02RAsgiflJJuRfsa1nzGGOefGVOh
	 Q9pBK+ibtJlR/XdTuw7jOhv8lXSVrzVALPSDcRR6fNausgIx0zlaT1pCphpKBeqCAe
	 MfeRjh+NFlYvw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240387>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2014 at 02:13:46PM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
>=20
> > Additional metadata, the initial checkout, and syncing down
> > -----------------------------------------------------------
> >
> > However, folks who do local submodule development will care about
> > which submodule commit is responsible for that tree, because
> > that's going to be the base of their local development.  They also
> > care about additional out-of-tree information, including the
> > branch that commit is on.
>=20
> Well, please step back a bit.
>=20
> They do not have to care about what local branch they use to build
> follow-up work based on that commit.

They do if they want to checkout the banch out again later, before
pushing it somewhere public.

> In fact, they would want to be able to develop more than one
> histories on top, which means more than one branches they can name
> themselves.

Agreed, bug for each superproject branch they will still have a single
submodule branch that should be checked out by default when they
checkout that superproject branch.

> The only thing they care about is where the result of their
> development _goes_, that is the URL and the branch of the remote
> they are pushing back to.

Maybe they're just doing local development?  I think the remote
branch(es) you pull from and push to are important, but not the only
thing you might care about.

> I have a feeling that this is not specific for submodules---if you
> did this:
>=20
> 	git init here
>         cd here
>         git fetch $there master
>         git reset --hard FETCH_HEAD
>=20
> and are given the resulting working tree to start hacking on, you
> would not know where the history came from, or where your result
> wants to go. =20
>=20
> So "the branch that commit is on" is a wrong thing to focus on.
> "The branch the history built on top of the commit wants to go" may
> be closer and these two are different.

That makes sense.  I don't think the former (as distinct from the
latter) is of any interest to anybody.  I don't care what the branch
name was when the past history was developed.  I don't even really
care about the new branch name.  I do care that checking out a
superproject branch gives me the same branch (with pull/push configs,
etc.) that I had the last time I was on that superproject branch.

> >  For already-initialized submodules, there are existing places
> > in the submodule config to store this configuration:
> >
> > 1. HEAD for the checked-out branch,
> > 2. branch.<name>.remote =E2=86=92 remote.<name>.url for the upstream
> >    subproject URL,
> > 4. branch.<name>.rebase (or pull.rebase) to prefer rebase over merge
> >    for integration,
> > 5. =E2=80=A6
>=20
> What happened to 3 ;-)?

I can't count? :p

> In any case, "local-branch" is wrong from two aspects:
>=20
>  1. (obvious) It does not follow our naming convention not to use
>     dashed-names for configuration variables.

I'll use localBranch in my mockup ;).  Although skimming through
config.txt shows a number of alllowercase settings as well as
camelCase.

>  2. You do not care about the names you use locally.  The only thing
>     you care about is where people meet at the central repository,
>     i.e. where your result is pushed to.

I also care about local-checkout consistency, as described above.

> > Syncing up
> > ----------
> >
> > In the previous section I explained how data should flow from
> > .gitmodules into out-of-tree configs.
>=20
> s/should/you think should/, I think, but another way may be not to
> copy and read from there, which may be a lot simpler.  Then upon
> switching branches of top-level superproject (which would update
> .gitmodules to the version on the new branch), you may get different
> settings automatically.

That only works for superproject-level commands that know about the
=2Egitmodules file.  If you cd into the submodule and work there
directly, your actions will be using the submodule's out-of-tree
config.  I think most of the time folks will want those out-of-tree
configs to match the settings in the superproject's .gitmodules, hence
the submodule.<name>.sync defaulting to true.

> > ...  Since you *will* want to share the upstream URL, I proposed
> > using an explicit submodule.<name>.active setting to store the =E2=80=
=9Cdo
> > I care=E2=80=9D information [2], instead of overloading
> > submodule.<name>.url (I'd auto-sync the .gitmodule's
> > submodule.<name>.url with the subproject's remote.origin.url
> > unless the user opted out of .gitmodules syncing).
>=20
> It may not be a good idea to blindly update to whatever happens to
> be in .gitmodules, especially once submodule.*.url is initialized.

Why not?  We're blindly updating it to the value that was previously
pulled out of the submodule's out-of-tree config.  If the user doesn't
like what's happening to .gitmodules upstream and doesn't want to keep
a patched version locally, they can always turn off
submodule.<name>.sync.

> Imagine that your embedded appliance project used to use a submodule
> from git://k.org/linux-2.6 as its kernel component and now the
> upstream of it is instead called just git://k.org/linux; the URL
> specified by submodule.kernel.url in .gitmodules for the entry
> submodule.kernel.path=3Dkernel would have changed from the former to
> the latter sometime in the superproject's history.  Switching back
> to an old version in the superproject to fix an old bug in the
> maintenance track of the superproject would still want to push
> associated fixes to the kernel to k.org/linux, not linux-2.6, the
> latter of which may now be defunct [*1*].

The checkout would work (because the old gitlinked commit is already
in the local repository), but the push would not.  I don't think it
would be difficult to recover from that manually (and just specify the
full URL when pushing).  You could also:

1. Commit your fix.
2. Checkout a more modern superproject branch (which will load the
   current URL into the submodule's config).
3. Push the fix.
4. Continue to work on the modern branch.

That doesn't sound much more difficult than the ideal:

1. Commit your fix.
2. Push the fix.
3. Checkout a more modern superproject branch (which will load the
   current URL into the submodule's config).
4. Continue to work on the modern branch.

If you expect to be back making more superproject/subproject joint
bugfixes in future, I think it makes sense to start a maintenance
branch of the superproject that updates the .gitmodules URL to point
at the modern location.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1KSIAAoJEKKfehoaNkbt9WcP/1dMQ1v9IxIQUH8Bq+PJdQyo
sTaI51OC5eBhakkEfoljDjr/kPOlXZWlaVTBsA8ZXTlLFDHcw0P3W2ZqYaE1m3Dh
jQxEeWkPs5SgaAJNDuRtIoLu+lH97fg/rantRmLRQiauROtMn62SBND407WektgD
gnFCsh2BFpZyfmETl98M/3txXKnGFulrSVmyr/oiuPij4J+NRFhKa6giOSUuiw0r
b/qYrOCUQo8FKXTjm7iGueeGVsM3TxvgclJoYKdvvXKSovUvG/9huwzVMFBSx5UW
rUH5IYXfyhocnuqB3Zqb16LNJ3RfD1KGp2HRhR7ecloZw7Us6tr9QP3wh3Sam/al
pQW+qP/xNqZgA2BW6SaYfB0J5AoYEJZN2AsGiNS6333uxLsedlZUXbgmFMsMuQPO
jx8C9IGf+Rh6YCB0T/VXhNr9PVBNXBNsUMUZfcvdHVCqc2M41LnJQ7qYYQADkbcn
Jz68lejTyyW/jmfS5J5E3Jm4WPCCvWzrDXao7SGnrJAq52WcmFcPk+iDQWsVmuUp
KCmUYWwqLab8LHBeS3LlR7JTIWrxKwXrr9p14jDztEukqgEGba+a+h48P4l6R4pF
YbTAxc/9DZdVZW6gnv0bPFQxhZU8RSsiifspe7ow7gmj33P47nM12H3qH5bI4EjM
Uo7somVNZ/Ib6UdVnvWs
=m+Sb
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
