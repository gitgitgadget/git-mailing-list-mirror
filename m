From: "W. Trevor King" <wking@tremily.us>
Subject: Re: pull.prompt or other way to slow/disable 'git pull'
Date: Sun, 4 May 2014 11:51:45 -0700
Message-ID: <20140504185145.GQ28634@odin.tremily.us>
References: <20140502190746.GJ28634@odin.tremily.us>
 <5363ee55ac2af_70ef0f30cf3@nysa.notmuch>
 <20140502194637.GL28634@odin.tremily.us>
 <5364015a94900_135215292ec28@nysa.notmuch>
 <20140502211305.GN28634@odin.tremily.us>
 <53640bc1ee6eb_135215292ec95@nysa.notmuch>
 <20140502220107.GO28634@odin.tremily.us>
 <53641a1be8d24_1c7bdcd2f049@nysa.notmuch>
 <20140503000530.GP28634@odin.tremily.us>
 <5364bbfc8c0a0_ac68dd308ce@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ngPZezdD7QsvFaqQ"
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 20:51:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wh1Vz-00058N-L1
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 20:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbaEDSvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 14:51:51 -0400
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:42918
	"EHLO qmta02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751085AbaEDSvu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2014 14:51:50 -0400
Received: from omta04.westchester.pa.mail.comcast.net ([76.96.62.35])
	by qmta02.westchester.pa.mail.comcast.net with comcast
	id xtbq1n0030ldTLk51urpv7; Sun, 04 May 2014 18:51:49 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta04.westchester.pa.mail.comcast.net with comcast
	id xurm1n00K152l3L01urnvt; Sun, 04 May 2014 18:51:49 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id DDEE4117570C; Sun,  4 May 2014 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1399229506; bh=m1RTlMlYcfZ6rd2YSjY7GN003Fv33X/q+trul6jk9+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XxHMXSJfS4JgyLk18p7dRf2AddjeerDApaC+zJqGgPu0d9v+fPG7cngHvYDbiBGgQ
	 yccr13DDw0pbKPUhqT0i7vkvGxQLYxWZK0pMl0VSwogJDvn33gMKDIQVcZiZ4zZcth
	 O8BGCk8tKwZ6l8Xubo6rEQLSvDVREuoGyqtfw03A=
Content-Disposition: inline
In-Reply-To: <5364bbfc8c0a0_ac68dd308ce@nysa.notmuch>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.23 (2014-03-12)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1399229509;
	bh=pMFWFVqPuZeZBj1tSkgaFYuAOxs0gEQWhLGfOg/95lg=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=wQ2GUgF09FaaEUDM4xZHJSM4PLbA2objeDFfwPvKkvzujEJvyQWM9ANJOX26x5zzQ
	 dcEqaSvkGNz9qsFcEsW7pQ2yrYi1wrI2RPuOk/624hIoG3fEgMapfGibAfU100J1rA
	 LQ219qHHs2VSB9uCHAP94djYrCozhx/f/Glq6aMjikVnC2vZZ5NhcfAeaMAJzAhOtY
	 +9QoZuM7eCD0U/oWqBZIQmSmoITepRzZSk4qlshqCWWyjEHv4mc+e062wdBvBRCsyY
	 TFdoJvZHMHESnykeS6fGpSxcs/VCgdhgAVMOSZwMwj1FEIDdQIRLW3Lff0hol+uE6K
	 T07GKVg7ZMh+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248105>


--ngPZezdD7QsvFaqQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 03, 2014 at 04:50:52AM -0500, Felipe Contreras wrote:
> Either way it would be impossible for Git to figre out what you want
> to do.

That's my point.  The details of my particular workflow are
unimportant.

> Anyway I don't see how is this possibly relevant to the topic at
> hand.

I'm trying to motivate a way to slow/disable 'git pull', which I see
as orthogonal to your push to change the default configuration.  I
thought describing my workflow in more detail would help clarify why=E2=80=
=A6

> W. Trevor King wrote:
> > On Fri, May 02, 2014 at 05:20:11PM -0500, Felipe Contreras wrote:
> > > W. Trevor King wrote:
> > > > > > The 'git pull' (with 'none' mode) explainer just helps retrain =
folks
> > > > > > that are already using the current 'git pull' incorrectly.
> > > > >=20
> > > > > If you are going to train them to use a configuration, it should =
be:
> > > > >=20
> > > > > % git config --global pull.ff false
> > > >=20
> > > > I don't want all pulls to be --no-ff, only pulls from topic branche=
s.

=E2=80=A6 this global pull.ff config was not a solution.

> > > Either way, since I think these two are different modes:
> > >=20
> > >   1) git pull
> > >   2) git pull origin topic
> > >=20
> > > Maybe it would actually make sense to have a configuration specific to
> > > 2): pull.topicmode.
> >=20
> > I think it makes more sense to just use merge/rebase explicitly,
>=20
> Fine, if you want the user to be explicit, he can be explicit with
> `git pull --no-ff origin topic`. Problem solved.

That's certainly explicit, but some folks are in the habit of just
running 'git pull' (regardless of which branch they happen to be on)
without thinking =E2=80=9CWhere am I, what am I integrating, and how should=
 I
integrate it?=E2=80=9D.  As I claimed earlier:

On Thu, May 01, 2014 at 06:10:04PM -0700, W. Trevor King wrote [1]:
> Folks who are setting any ff options don't need any of these
> training wheels.  My proposed --prompt behavior is for folks who
> think =E2=80=9CI often run this command without thinking it through all t=
he
> way.  I'm also not used to reading Git's output and using 'reset
> --hard' with the reflog to reverse changes.  Instead of trusting me
> to only say what I mean or leaving me to recover from mistakes,
> please tell me what's about to change and let me opt out if I've
> changed my mind.=E2=80=9D

In the messages following that, you seemed to agree that such folks
existed [2], and suggested I use pull.mode=3Dfetch-only [3] or
pull.ff=3Dfalse [4] or pull.topicargs=3D'--merge --no-ff' [5].  Now we
agree (I think?  Based on your =E2=80=9Cit would be impossible for Git=E2=
=80=A6=E2=80=9D
quoted above) that you can have a sane workflow for which no
pull-strategy default will always do the right thing.  We just
disagree (I think) on what to do about it.  I'm suggesting
pull.prompt, pull.mode=3Dnone, or some other way to slow/disable 'git
pull' while folks retrain themselves.  You're suggesting (I think?
Based on your 'git pull --no-ff origin topic' quoted above) that folks
just skip right to remembering which ff options to use in which
situations.  Do you feel folks won't need a way to slow/disable 'git
pull' while they build the ff options and their project's recommended
workflow into their own practice?  Or do you agree that they will need
some kind of helper for the transition, and just feel that git.prompt
is the wrong helper?

Cheers,
Trevor

[1]: http://article.gmane.org/gmane.comp.version-control.git/247917
[2]: http://article.gmane.org/gmane.comp.version-control.git/247919
     On Thu, May 01, 2014 at 08:14:29PM -0500, Felipe Contreras wrote:
     > W. Trevor King wrote:
     > > Folks who are setting any ff options don't need any of these
     > > training wheels.
     >
     > Indeed.
[3]: http://article.gmane.org/gmane.comp.version-control.git/247957
     On Fri, May 02, 2014 at 02:13:25PM -0500, Felipe Contreras wrote:
     > W. Trevor King wrote:
     > > On Fri, May 02, 2014 at 01:55:36PM -0500, Felipe Contreras wrote:
     > > > W. Trevor King wrote:
     > > > > But once such folks are identified, you just have to
     > > > > convince them (once) to set the pull.prompt config.
     > > > > That's a lot easier than convincing them (for every pull)
     > > > > to set the appropriate ff flag.
     > > >
     > > > It wouldn't matter if by the default non-fast-forward
     > > > merges are rejected.
     > >
     > > It would matter if you didn't want them making
     > > non-fast-forward merges (e.g. for explicitly-merged topic
     > > branches).
     >
     > It would matter almost exactly zero. And just as they can do
     > pull.promot =3D true, they can do pull.mode =3D fetch-only.
[4]: http://article.gmane.org/gmane.comp.version-control.git/247986
     On Fri, May 02, 2014 at 04:18:57PM -0500, Felipe Contreras wrote:
     > W. Trevor King wrote:
     > > Saying =E2=80=9Cthat's unlikely to happen=E2=80=9D doesn't solve t=
he problem
     > > that some newcomers have trouble matching their project's
     > > desired workflow.
     >
     > % git config --global pull.ff false
     >
     > Done.
[5]: http://article.gmane.org/gmane.comp.version-control.git/247998
     On Fri, May 02, 2014 at 05:20:11PM -0500, Felipe Contreras wrote:
     > W. Trevor King wrote:
     > > I don't want all pulls to be --no-ff, only pulls from topic
     > > branches.
     >
     > Pulling some branch to a topic branch, or pulling a topic
     > branch to another branch?
     >
     > Either way, since I think these two are different modes:
     >
     >   1) git pull
     >   2) git pull origin topic
     >
     > Maybe it would actually make sense to have a configuration
     > specific to 2): pull.topicmode.
     >
     > This way they could do "pull.topicmode =3D merge-no-ff". Or maybe
     > we need arguments: "pull.topicargs =3D --merge --no-ff".

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--ngPZezdD7QsvFaqQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZow+AAoJEKKfehoaNkbts7EQAJAqa7xXiUdSLqHpH5Py3Wq6
dLlgI1nCkvZ1zEdf9OsTe4QmdqC0nPU//y+qBtIb3df9eQ1YZ9fL57Lxlt1nFJi1
MRmvytbaV9ETHmggQPh3aUcd6C2/2430m1cywsafxgrDfkg2RB/ePoy6P+q6M28P
TzPBi/aPgbU7hqgfyRf5aEONH6L6i7y2Siy2Fg3lKhUAyatW//vZt2eLQasPtCRc
Sse+vdSi2tpIUwMsBi69PLbvEu/k/YRBzdi0YCL9qkPI/ggO4YKIKcnGnOwkZIm8
nfc9w1pNAX77FhFp14PaDo++W4FeDp1S0mvMNlG+Y1zXq6UL4auFi6njSJwkgf/9
ZaQ2nDMl51Ubv3ynYEM9rjpCloylxsJYFV7+o30RsxDp/rWyX58/zCp9U+zL+NG/
FSii/xGnjIK+6wo4/6bE9zq4txYPATToAj5EWW3LMYW6WWJSRd5rvb8n7Ys4khj3
3dHu48DN//oPXy98bz9ekdiit7GHEqAWv2AcSH0ycB3JIDnhCbBCT4zNUyP4Wjmg
lhYnDpv4y2tKv4i7EgQNDh00aw8vwKA53nAB7l62jg7u0nFBhziMCVe/UkrIK/Yz
9FzHqscLxBpdkxaFPuk4uiMQk4Y6MHwcCgzT1xbCcTSQNc1+QW2x/9+aOEOwLgtk
kdlw56r1H5pVB05axQMm
=FWON
-----END PGP SIGNATURE-----

--ngPZezdD7QsvFaqQ--
