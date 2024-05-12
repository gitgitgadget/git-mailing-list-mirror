Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F046B80
	for <git@vger.kernel.org>; Sun, 12 May 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715528106; cv=none; b=O5RKnAGC3kFoZJsFdEYBjJR+jgLRtst451+LuLogxVs2zFioEBSyMbNZ9FUgnZu+b2nuq6Ik9N6ZvGsm+rS1L/H3JfUbpSz9ihVNGJOFK70WIMnt/UxkopU+rfE8iBElm9L4ju42lcBe/UNQxG2DdkJ8VTBCYvscLU/6CBSZKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715528106; c=relaxed/simple;
	bh=5xF+FfhTVqV+oPz+OB4kjfCClI1gEuw0FZ4vJeXRRk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOCtiuAHleqK2rOJ+T1PkzXOdh0DvojrlGyqQChcUFMDil67Qfg4vO4AHBPvBwKUmWwsKHPCN5csNr82UN9fbfKH48Ww/YCNy4VFlBNrmocRlL3eQ2yU5bhqBi2Es8e3ZkRjoIfbyfSsmMqqFrMjds4GkGrAUV4Q8r7lGaVwKq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/AWudxM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/AWudxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06E4C116B1;
	Sun, 12 May 2024 15:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715528105;
	bh=5xF+FfhTVqV+oPz+OB4kjfCClI1gEuw0FZ4vJeXRRk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/AWudxMWMKfoVAxPI2ZIztOlj7QOaqenxb6d27XjSpuVv63vMJbs67hdWMiU16vs
	 LIu/bh088rfH2lEwjCPLyBOUXLKX/CmhrqNR0jXZQMSfCNhkuIkgnEQF0W51Kwf2Dt
	 jkKJF/tVqZLtNIpT0AqpSZszM8Dy8Nf0/3+rOYIwssFhUulFO2G52YRNAs+3jq0IP9
	 DawpOyTIS0TkG/w6X1MSv2M02/97/8gq9TQlviljHT5Mko+iJuLEMNhNv5k9tTJzSi
	 OuEqwFI27YuWlNIJwkbW5v/twRBK8Y+AvfQPpFya7bpPF6RkCXsP6wIHD6lV8S4/Ar
	 1ml50YyFj7MAQ==
Date: Sun, 12 May 2024 17:35:02 +0200
From: Alejandro Colomar <alx@kernel.org>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git-cherry-pick(1) -- path
Message-ID: <xnzks3eybwx5lj7vnf66pfacjvcn4anhgfe7fx3ljvtysxpsrv@tt2wvkwezh3l>
References: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
 <xmqqv83mqxg3.fsf@gitster.g>
 <kk244kap6lhuvtfot55u4yb5k5eddwlzl4izlzqhe4pdj52cx7@slghmpvdswkt>
 <9b42e684-32e0-4372-8da6-40f9b708b6ca@gmail.com>
 <xmqqcypt61lo.fsf@gitster.g>
 <bpjfsabhstkbuvo6ksj3owoxvutgquripmqmqi63ykaquhky2u@r7mfrwucgnye>
 <3a48b2fe-78c0-41f4-9e60-4146f15dfa97@gmail.com>
 <fz7tgtvp6qp7h3vcaviibn3rktkwg5q4qjeuvmciejqn2m7uow@3o5hi6hdbkt5>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jnu4z55zzw2dh42y"
Content-Disposition: inline
In-Reply-To: <fz7tgtvp6qp7h3vcaviibn3rktkwg5q4qjeuvmciejqn2m7uow@3o5hi6hdbkt5>


--jnu4z55zzw2dh42y
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git-cherry-pick(1) -- path
References: <e5pklmijfpbsnl2trj4n4czam7n7i37gx7w56med2pfaf6q3yx@wizseio2ickk>
 <xmqqv83mqxg3.fsf@gitster.g>
 <kk244kap6lhuvtfot55u4yb5k5eddwlzl4izlzqhe4pdj52cx7@slghmpvdswkt>
 <9b42e684-32e0-4372-8da6-40f9b708b6ca@gmail.com>
 <xmqqcypt61lo.fsf@gitster.g>
 <bpjfsabhstkbuvo6ksj3owoxvutgquripmqmqi63ykaquhky2u@r7mfrwucgnye>
 <3a48b2fe-78c0-41f4-9e60-4146f15dfa97@gmail.com>
 <fz7tgtvp6qp7h3vcaviibn3rktkwg5q4qjeuvmciejqn2m7uow@3o5hi6hdbkt5>
MIME-Version: 1.0
In-Reply-To: <fz7tgtvp6qp7h3vcaviibn3rktkwg5q4qjeuvmciejqn2m7uow@3o5hi6hdbkt5>

Hi,

On Sat, May 11, 2024 at 10:08:47PM GMT, Alejandro Colomar wrote:
> Hi Phillip,
>=20
> On Sat, May 11, 2024 at 04:01:18PM GMT, Phillip Wood wrote:
> > sequencer.c. If we go for the "write new trees and use those in the mer=
ge"
> > approach then we'd need to change do_pick_commit() to create the trees =
and
> > we'd probably want to change do_recursive_merge() to take trees rather =
than
> > commits. We'd also need to add a new pathspec member to struct replay_o=
pts
> > to pass the pathspec around.
>=20
> I've been thinking this evening that since
> `git format-patch ... | git am -3` works so well, and since the behavior
> of cherry-pick -- path isn't so obvious (we're discussing different
> strategies), maybe we should just not do it.  I fell in love with am -3.

In the end, I'm using the following:

$ git log --oneline 2024a..tz/main -- tzfile.5 tzselect.8 zic.8 zdump.8 \
| awk '{print $1}' \
| tac \
| while read c; do
	git format-patch --stdout -1 $c -- tzfile.5 tzselect.8 z*.8 \
	| sed '/^---$/s/^/\n/' \
	| sed "/^---$/i Cherry-picked-from: tz.git $( \
			git log -1 --oneline --abbrev=3D12 $c \
			| awk '{print $1}' \
		) (\"$( \
			git log -1 --oneline $c \
			| sed 's/[^ ]* //' \
		)\")";
done \
| git am -3 -s;


And it works like a charm.  If I had to spell that as a
git-cherry-pick(1) command, I'd say
`git cherry-pick -x -s 2024a..tz/main -- tzfile.5 tzselect.8 zic.8 zdump.8`

BTW, there's something I noticed when I had an accident (forgot to
tac(1) the commit list): the git-am(1) conflicts session isn't as good
as a cherry-pick one: it doesn't show which commits are being applied.
If you're in the middle of a 50-commit cherry-pick, it's hard to see
where it's going wrong.  So maybe adding this functionallity to
git-cherry-pick(1) could be a good thing.

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--jnu4z55zzw2dh42y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZA4aYACgkQnowa+77/
2zJKbRAAkLyp7DlGAqavKI+PC83JYLaDc7m/a5BknvhLNLDyl5MBXUzqKWL2fzMq
Zi4u8Z3M0p07ybBz5KtQ2qNlGoiISn4aUuZyvZ+xT1YRyR0k52Z9wJ1s7GLkzO2T
84quwCr5UMjMGDQ0bKK3E8Tow08XnNSqcMa9wYzeT6xKkoUmv9BKROvUDsnWGeXs
mcBWQ3hd8/8mMy8d02ztpv9vFj2sKBqw8dhz9xNE2RzBea5vgraE58Z3a0Y8BhaQ
DBkvBnUeI1+dRoiGntYhrLsy7b27IM0+lZJ0l6hI9faJrp9laHyi+sqH1l/MCTq4
3nffzAq7nQBl/aocJLGvIqLIgot78wQ3Q2QFGQ+/wBkgAAO7RyNkvH3uTjzO/j71
pLiOgAZiGq9BhRmuIRD+TmrvLjSFK0JdxeQPsNgf32FQXBEeC4lxN3imJfhuEI8u
S/S/l/IrHyVlew89QhpCYfYFPN7jYYjzphips+OHsAM/CwtOTmm/BBz26MNrFut4
P/7xc/6Mll1KkPnptpoEfhEjcNzcM463LC6BBbJe72Icvbb2j9MXs7c8cG7M6YWr
VEzaqphIRSdz7PeTyrwTSEyw4egDZ3eyLl5CaXOSO6RZtL8cK3N4H0GCjBL0if/D
wwYnFkY6EBqbkRihuyPEUpF72DVGKaQZAo21hJGebl2eJ+1Su3s=
=fjSg
-----END PGP SIGNATURE-----

--jnu4z55zzw2dh42y--
