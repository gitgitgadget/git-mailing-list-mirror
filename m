From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 7 Jan 2014 11:50:42 -0800
Message-ID: <20140107195042.GH11060@odin.tremily.us>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <xmqqlhyrek02.fsf@gitster.dls.corp.google.com>
 <20140107184659.GF11060@odin.tremily.us>
 <xmqqtxdfd2dj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKijDXBCEH69PxaN"
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 20:50:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0cfr-0002fw-4L
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 20:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbaAGTur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 14:50:47 -0500
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:54324
	"EHLO qmta10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750851AbaAGTup (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 14:50:45 -0500
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta10.westchester.pa.mail.comcast.net with comcast
	id B0zT1n00527AodY5A7qlfC; Tue, 07 Jan 2014 19:50:45 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id B7qj1n00j152l3L3f7qkk0; Tue, 07 Jan 2014 19:50:45 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id C0BA6EA9968; Tue,  7 Jan 2014 11:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389124242; bh=qqusmFzmlcgBKl8sgD9vZ1YqhnNrrhkHaZFEmJl+kec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dDxvhnnt+1YWwAq5//Zxd6JRJELZLvQ+WHZmGneGTVP8ejxAfzpu3XpqS/m1iLQvb
	 juYGbie8WLFdWT49BM4ZTbNUjvyl7a5sKfYdppD1p/2G9NsOxOOlSvinKTArjOqbd6
	 Axo4g85OwqQab8ilgA8VZm/ysiIcfJFwWo5uG94g=
Content-Disposition: inline
In-Reply-To: <xmqqtxdfd2dj.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389124245;
	bh=lZt49IetB2Pv89TKjOa4Spv6N5GTC8NbfubDxPz1OM8=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=h0mNwOBnOBEPwEB0Xi72ziq768ceBxuJftXFC84s54vMjzWnKo5gnt7wYhkDBT4Zt
	 E1+CYuSShEu0njPegcoRm2mNgAb0kxnc5XZ45oDbMgD02q1xMODIxlDVqEpBRX6Rex
	 IS72WBTpoiPWgFjrRjU3YSMonxqZdwj73AMc6wX9IbQlWxjfeX4spUpxXm5vmgs1nD
	 pVxJbjlnuMmgoBLv22TfH5akGAchj3puJLYm/H4rm3IcyIen6pr5TR8D2QjlhRMqbj
	 PSylKfpn1SHwhm0NIrmCA1ZEYAgHiihwuXqkO28Ng4Kd4D4yEjda5isNuoYxaiOxIT
	 d332yzt60J4Iw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240140>


--gKijDXBCEH69PxaN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 11:21:28AM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> > On Tue, Jan 07, 2014 at 10:15:25AM -0800, Junio C Hamano wrote:
> >> Having writing all the above and then looking at the patch again, it
> >> is not immediately obvious to me where you use "rebase" when doing
> >> the initial checkout, though.
> >
> > It's used to shift the local branch reference from from the
> > (arbitrary) cloned remote branch tip to the explicit submodule $sha1.
>=20
> The objective is not what I was questioning. In the patch I see
>=20
> 	git checkout -f -q -B "$branch" "origin/$branch"
>=20
> used in the module_clone (which I think makes sense), and then
> cmd_update uses "git reset --hard -q" to make sure that the working
> tree matches the commit $sha1 obtained from the superproject's
> gitlink (which may make $branch diverged from origin/$branch, but
> still I think it makes sense).
>=20
> But there is no 'rebase' I can see in the codepath, which was what I
> was puzzled about.

Ah, thanks.  s/rebase/reset/ in the commit message ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--gKijDXBCEH69PxaN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzFqRAAoJEKKfehoaNkbtjEsP/03zloLSf4paPzw1VWJBMp9D
rPHRLbDIdsjV8JXlpT2cez+AsnYlBBBCu3mhI8wJwz7uRiPvBEEiSFw0ALPAYtop
qLEO1B2VyMwoUrcrfa9uR6gs20x1GLqgTGvJD8u3INo8t8+FwV0Xx0XyyULM5hMX
GlUqmfJELGKdtOBIEt5sBSFgXZexP6lGBRvcNuH6rqAuJUpRl0iVtxSSxQyyochH
i4YePKr3QavJr2K02j7Ozp8BT4WtTl2O3Afnf3caV/otGhpYG/I1VmxJWgmxprC2
OUA4spF962FpkCT1VUw7HwLpTi1fVB0F9SUwd9flIFCW/SwYQtRXVQBDPS6d1BEj
+Jtim7eyuCbdp18taHhzTAHVXa2tHPxBMjvBFmmE7enaMk/crwQSxea3fa1wi9NF
k020JGVPvavB+A1knp9Jy2iClxOaRt4zJcwO4fABUQ8PtM/DWss4qh50NcBE+H6E
xC/mEsCOMgcwibHhJymraZBo96Az48PLnH2RNHeBMbexUMp+cLi4/KogIYbGBP2u
rytkHrF2AF8hDvWrKpp4xvSZ8ryXBFGVwpLGFCmcCBFNUZBD/cyOBlQ6p2m46kNe
cgNI+yXmo9Mjc/ixyXr/u5fawFtEbaxG0DN7d328XiAiisbvBr1Hb4A9kOqxZbYX
s3+dkH1+9vbXB6Fcw5eb
=0HJf
-----END PGP SIGNATURE-----

--gKijDXBCEH69PxaN--
