From: Andrey Utkin <andrey.od.utkin@gmail.com>
Subject: Re: Don't use PGP/GPG signatures in mail that contains patches
Date: Tue, 19 Jan 2016 13:52:56 +0200
Message-ID: <569E2398.2050206@gmail.com>
References: <569C3F73.3090805@pb.com>
 <20160118214857.GA24136@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kSpfgql7wkjBQNnObJRtg0bncJnsIu6r7"
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 19 12:53:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLUqW-0004DL-Hw
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 12:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbcASLxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 06:53:06 -0500
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34727 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbcASLxB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 06:53:01 -0500
Received: by mail-qg0-f53.google.com with SMTP id 6so498231649qgy.1;
        Tue, 19 Jan 2016 03:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-type;
        bh=YSXFcM2G3YKsP8LpyebbKcjXSQPcXmaZU3ONJVBXG8w=;
        b=G4DrFF7TWn0t2ZKTigq2AJBizYM1CINJA1QxRb2DwhtbJRYrhjodX41WZoFykMtYnW
         Tz61K0UR9yIpx0t47QfpAlVsV0CWdESyMjGRHCxj+3BHt3ZryEqk9jjZaykESX25cJVL
         jWtN2gm/HG4lRbyEWa+vxUckQ2/lQBZWMmFJatj1YkQVBwlbB11S5OL5JyEVelSLYT5j
         rWUZy7bIym6mmr2CSchGMRFSykeWCZ/hCQ7rmGiaX5sLoV/F0wfFZrfiHgDDBph5Sm4y
         X+rSME1YS37gqaNYOACJGh6kdxq8Havtsk9LYsoSLGKCSXZVi7WtydpfzGQd1HOOviI7
         Z4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-type;
        bh=YSXFcM2G3YKsP8LpyebbKcjXSQPcXmaZU3ONJVBXG8w=;
        b=Bf+j4usCbSvTYEuMKEklBYBlA1QE3njIuXlzJYlo/bs/AyKc/EP06OLrHHKPL79lUH
         S+2w55vX9yWFSASK1beWcJ2L3iVlVJRGbRxJb2xnjFz2DS6ArIg/pmagxq6lyYO0+lSH
         rRokKyra+K3QBwuPsqT1MFyTJ5Kp8iPMrjZkvEeWa/aA7+QycYWTMsnvJGr8NGqt038q
         ELydqi54IVWNuUFamutMslyvQmcdP4wEKn+Jr15WhaOyUw5AMMhJRYSbF7Uz8vPxJKNA
         vCpUIcDI3JAjI9CxcfmVllqfoRNqTJ8J1IrhmaGLBCNDjhXOWb6q7/pVWdnaj3pgkHrd
         MeaQ==
X-Gm-Message-State: ALoCoQlubrH5VlkY4jA4kNJPepgJzLqRWmFiwNUt/CJ7D/zf/UutSRSOCQ455iSNc2IG6XkidgLXnQyxJzcVPye6pWiiQZWX1A==
X-Received: by 10.140.134.197 with SMTP id 188mr40652746qhg.58.1453204380959;
        Tue, 19 Jan 2016 03:53:00 -0800 (PST)
Received: from [192.168.0.10] ([91.198.4.228])
        by smtp.gmail.com with ESMTPSA id q6sm11931162qhq.21.2016.01.19.03.52.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jan 2016 03:52:59 -0800 (PST)
Openpgp: url=https://pgp.mit.edu/pks/lookup?op=get&search=0xD56A7CD0C6FCDB11
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <20160118214857.GA24136@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284355>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kSpfgql7wkjBQNnObJRtg0bncJnsIu6r7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.01.2016 23:48, Jeff King wrote:
> I don't know about other receiving scripts, but "git am" will handle
> signed PGP-MIME out of the box (I didn't try it with inline signatures,=

> but I imagine it would stick the "BEGIN PGP MESSAGE" cruft into the
> commit message).
>=20
> However, there's an open question of what to _do_ with such a signature=
=2E
> The email signature does not function as a valid git commit signature.
> So you are left with one of:
>=20
>   1. The receiver can verify the origin of the email before applying th=
e
>      patch.
>=20
>   2. The receiver can keep a copy of the email "somewhere", so people
>      can later re-verify it, and then hand-verify that it matches what
>      got applied.
>=20
>      That "somewhere" may just be a mailing list archive, but you could=

>      get fancy with scripts and associate it with the applied commit
>      (e.g., using "git notes").
>=20
> But those are really questions for the project. If you are mailing your=

> patches to Linus, does he actually care about (1)? My general impressio=
n
> of his past opinion is that it's more important to read the patch text
> than the "From" line. Of course subsystem maintainers and other project=
s
> may have different opinions.
>=20
> I think (2) is more compelling, if only to create a better record in th=
e
> mailing list archive. Assuming the receivers of your patches don't mind=

> (and I know some people really _don't_ like things like PGP-MIME,
> because their mail readers are not good at replying in-line to the
> patches then), I don't it would be a bad thing to teach git-send-email
> an option to send it.

Thank you for thoughtful reply!
Surely email submission signature cannot be used as git commit
signature. And surely there are issues of usability. And surely people
are used not to care.
But still, if we encourage signing maillist correspondence, we would
avoid impersonation attacks. Imagine that somebody sends stupid
submissions from your name, maintainers shout at you, and your
reputataion is... changed. Of course, you will be able to sort things
out after you read the replies and reply that it's not you. But, given
to openness of maillists, the attacker is able to follow your replies
and insert his ones. Or to reply to your valid submissions that they are
not from you.
Still it seems that making fun of that is not much harder than
masquerading on GitHub
(https://github.com/amoffat/masquerade/commit/9b0562595cc479ac8696110cb0a=
2d33f8f2b7d29)
Sure there are anti-spoofing measures like DKIM. Honestly I am not aware
if vger.kernel.org is so restrictive that it accepts only letters from
super-safe email servers, but I guess it is not, because not everybody
has this stuff configured on their email servers.


--kSpfgql7wkjBQNnObJRtg0bncJnsIu6r7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWniOZAAoJENVqfNDG/NsRB8MP/iMJYMZicFvFl5ldJ+EizbUW
bezNR28TnKT4J4/RlifpzOtv860L1+CL2vaBXiFlLmLA0qqNylrvXl2gsWiYV1Zx
BqK3FYsg1R8jp7GfUmNYY7mBzUX4hnN7oIpPlI23/QKWi9WcULohuBTosT9x0GIm
Ah0KNHwjL3oj6fKkIAXO4v+8aFBKx25Y3oKTTzUd1qzD3kJgkaLORxDAxikyyJtj
9Yi7AD1l9oSTWhWHLM6D9mVSW/BRoU0eA0slyIuULplyj04vpUUa1a+INenvUpvy
Bb69nw8oQhCrMEjF4rWNn3aftI+yWKpHVFH5bRBF54rsxovQwXVriZpK4uEJHr/g
8k56vOwhjNkrAUPmh7JFDOitsZ0ZfmVIbjWcGFUj1XQWE3gLK6BI8I8VFiDp/Kh9
T+n3utPuPrll0WYMjDsEheHfrdGaOeBI6jHJdoYtU8hcZVS5FGNCNb5eF1WePDa2
yeIuBZueZI84ABtg3loZTdh8AMxwdqjnwuJK3pmg7uApxff0uOlL7ZMbHvakAiS4
NM/fYI4BBndC132pCn6fGyZbIvn2LgLKPDBY9NQcsmE5PpUqOD442yXw+OZ099lq
BYq9dph9ESkTQfWmYNoRgQCQk18xCKwyU4ksSmKuhrYbH7g0DlJXKWzsJ0TFaUTH
RTdlbBRvKX3arD66/RJq
=K7uy
-----END PGP SIGNATURE-----

--kSpfgql7wkjBQNnObJRtg0bncJnsIu6r7--
