From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 14 Jan 2014 08:57:09 -0800
Message-ID: <20140114165709.GH7078@odin.tremily.us>
References: <CALas-iheQ4Rfxvty5guEieVwa8SffRnhRdHkNXUKwmuHRXD2Xg@mail.gmail.com>
 <20140109000338.GM29954@odin.tremily.us>
 <CALas-igFQtG1qa2+grMAtZ9mDE-xGuXkDGwGvSXL8_FzPfXBLQ@mail.gmail.com>
 <52CE5E51.4060507@web.de>
 <20140109173218.GA8042@odin.tremily.us>
 <52CEF71B.5010201@web.de>
 <20140109195522.GT29954@odin.tremily.us>
 <52CF1764.40604@web.de>
 <20140109221840.GW29954@odin.tremily.us>
 <20140114102445.GA27915@sandbox-ub>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7SAgGoIHugoKhRwh"
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jan 14 17:57:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W37J0-0000Jl-NH
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 17:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbaANQ5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 11:57:22 -0500
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:49874
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751660AbaANQ5N (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jan 2014 11:57:13 -0500
Received: from omta12.westchester.pa.mail.comcast.net ([76.96.62.44])
	by qmta01.westchester.pa.mail.comcast.net with comcast
	id Doqn1n0020xGWP851sxCQT; Tue, 14 Jan 2014 16:57:12 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta12.westchester.pa.mail.comcast.net with comcast
	id DsxA1n00P152l3L3YsxAY3; Tue, 14 Jan 2014 16:57:12 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 6BAF6ED1543; Tue, 14 Jan 2014 08:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389718629; bh=gZSzavTB2Uo9gx8ECFEq/1oIk0xDtA3oXFx9DQf0nnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O67AzwFU6HvWMkNhQlb/qfeEiqZ6CTmTwRvlcJg1j46jlHBNWVx/PDUG2NIAhYOxx
	 2TsDINw2xFs3d6ZJsNJVtB/vN5uFoAsnf3tWcs9NaArlQz8UVX6Z5vL5qbZKXE/MU/
	 PzmAX9pyGCKZGdNqK/FU6/GMx7PY2nJlVgZ08M44=
Content-Disposition: inline
In-Reply-To: <20140114102445.GA27915@sandbox-ub>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389718632;
	bh=KZngRayXZrQGzr32k0JuCvJOnqBMHCURjdNcMBdKoEo=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=sPpTNXhfks00B39+aMGiU1PutAQZqLnDNjnY9c2N6xCGYK90vO1t00SnJdWrPv5KE
	 szLqc0D9GzHogUJx9w96zkCuCIMJcm3sOqvMCS+m1ioT2bMbdwnLymCJt8+O6GoW1w
	 adotWulb+OUcJfHVz4N7BiBWQNvIgwFR7eJvKQAIhigc47upJc8kIT2Aq2n+zzV83z
	 dcxykbIwlqemOE3p0cwOxAiSSCrvDzRmJ/AgyFE+eD9hKmW/Er6fn8ysuYQbDlxNHU
	 FJZt+gQMiOHjV81J7UWtR4RcG+ts3n0C+wHyH8uqKY3RJ2S1nWzyYW4Cf5JMwerSCK
	 XRTsoEbquhLEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240401>


--7SAgGoIHugoKhRwh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2014 at 11:24:45AM +0100, Heiko Voigt wrote:
> On Thu, Jan 09, 2014 at 02:18:40PM -0800, W. Trevor King wrote:
> > Users who are worried about loosing local updates should not be
> > using a checkout-style updates.  If they are using a
> > checkout-style update, and they ask for an update, they're
> > specifically requesting that we blow away their local work and
> > checkout/reset to the new sha1.  Solving update conflicts is the
> > whole point of the non-checkout update modes.
>=20
> But checkout is different from reset --hard in that it does not blow
> away local uncommitted changes. Please see below.

Ah, good point.  We should definately die if there are local
uncommitted changes.

> > On Thu, Jan 09, 2014 at 10:40:52PM +0100, Jens Lehmann wrote:
> > > Am 09.01.2014 20:55, schrieb W. Trevor King:
> > > > Maybe you meant "for checkout I can easily overwrite the local
> > > > changes with the upstream branch", which is what I understand
> > > > checkout to do.
> > >=20
> > > But which I find really unfriendly and would not like to see in
> > > a new feature. We should protect the user from loosing any local
> > > changes, not simply throw them away. Recursive update makes sure
> > > it won't overwrite any local modification before it checks out
> > > anything and will abort before doing so (unless forced of
> > > course).
> >=20
> > If you want to get rid of checkout-mode updates, I'm fine with
> > that.  However, I don't think it supports use-cases like Heiko's
> > (implied) =E2=80=9CI don't care what's happening upstream, I never touch
> > that submodule, just checkout what the superproject maintainer
> > says should be checked out for this branch.  Even if they have
> > been rebasing or whatever=E2=80=9D [3].
>=20
> I never stated that in that post.

Sorry for misunderstanding.  I think I'm just unclear on your
workflow?

> The recursive checkout Jens is working on is simply implementing the
> current checkout-mode to the places where the superproject checks
> out its files. That way submodules get checked out when the
> superproject is checked out. If the submodule does not match the
> sha1 registered in the superproject it either stays there (if the
> checkout would not need to update the submodule) or (if checkout
> would need to update) git will not do the checkout and bail out with
> "you have local modifications to ... .

Sounds good to me as far as it goes.  I think it misses the =E2=80=9Cwhat
should we do if the gitlinked hashes are different=E2=80=9D case, because t=
he
checkout will always leave you with a detached HEAD.

> > > or be asked to resolve the conflict manually when "checkout" is
> > > configured and the branches diverged.
> >=20
> > I still think that checkout-mode updates should be destructive.
> > See my paraphrased-version of Heiko's use case above.  How are
> > they going to resolve this manually?  Merge or rebase?  Why
> > weren't they using that update mode in the first place?
>=20
> I strongly disagree. They should only be destructive in the sense
> that another commit get checked out but never loose local
> modifications.

I think the key I'm missing is an example workflow where a developer
wants to make local submodule changes, but also wants to use
checkout-mode updates instead of merge/rebase updates.  Can you sketch
one out for me?

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--7SAgGoIHugoKhRwh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1WxkAAoJEKKfehoaNkbtTacP/iB4YdaRu6V0vPOdMMYYkCMR
6d/47RywXa8RRLG5clWwiKb8/Xiwb/mynLVPPGoxlT9nOwW/i1IMYJ2h+cxNHCFW
nMMIUlyfEF2O0nqYVlNPkbitHddCRMSOpXA4290ASRXjrNArUkjyvKZz+/T7a3S+
n3lhDw2VZ6tX62dvX++bt5ltFxMSlEdWNv1d8BWcnAZ4gCuuxefgfWg+krmai3Qr
Clsye1U+1emTS2prpll5u1WsIQP4ZnaZlVUF4L/DMWsKmNUeOIf4DoUpzz4+pLvM
uxnbYZulIqG1FKb7fc0LcKKZZWNHrZUo8YPpeogcTx6aDhFMKAlhvN+uJVJ8oMhp
i2b/9zwESyWhTj+m1TEB/8gR5Eek/PbNKJ/2BZRcvLyx+zZtMAl2tQEOjgs5bcJh
KDVg2aTHR8yRsr8WPWcrC+pMaKSM5gkCWgRT/szTJAclHd4B8vq+rjPZ8lqkYR3Q
TFBeMxFh8Gm0roVTOfL20QS2iBeIqsxJtDhOeXMrZJCpd/looBZJTIAwR14Mm90a
8cVDRPpGCLMmMUz1TZz9Nsk8zxL7ddwks4w1MiaTCxPgJs7zn6rEvN6pCJIGc9+V
if2M5coD/f8RO2QetzU0CY2hi4/R8Zi3MgkAu3l9NKneA/S9Frm11JWxLOXxe5KI
zfYHazJZjKQtE0qft+fn
=FgDM
-----END PGP SIGNATURE-----

--7SAgGoIHugoKhRwh--
