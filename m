Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F2AC2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 12:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BD02063A
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 12:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="JT/RlTSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfLWMTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 07:19:03 -0500
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:52407 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726257AbfLWMTD (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Dec 2019 07:19:03 -0500
Received: from pc09.procura.nl ([37.74.132.97])
        by smtp-cloud8.xs4all.net with ESMTPSA
        id jMfri4wu0TsDejMfsiW3tJ; Mon, 23 Dec 2019 13:19:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1577103540; bh=aMJ8tbUXRKmtgMjhFE7fzk8QrNFSI8+W+yMBvm8TolE=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From:
         Subject;
        b=JT/RlTSAxLDWsqvEYTN/JchaW0Br2csdg69udi0xuRVpZzVTh+3YlPDAtNLZBZ3ar
         SA4AX2k3L+mjkGjx+GaxcaAxJQf81LlSpPNyHazR9n48u40LmEmtl04P28oFX2bruB
         Gvok+LndOV3CvZ8hBZ0PaSVc2Sie/lBV5GUZ96f79kVcQ/oZAqUCh2i+huPamvzxRQ
         nUdX+CN/H5crXUUz6JLzyZFci0S3AqeqVxF76nCHa94cnPsPb6JBaRcpOUigu8h7KS
         YIzcW9iOh0rYVfrZl7mVB0+4Fv5w5MGHAa7lIfKue8CjuSZlxV5AFxsavmu5j5mkul
         /t+TulXC/+rmA==
Date:   Mon, 23 Dec 2019 13:18:49 +0100
From:   "H.Merijn Brand" <h.m.brand@xs4all.nl>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Subject: Re: Low prio: feature requests for git-gui
Message-ID: <20191223131849.13fc572e@pc09.procura.nl>
In-Reply-To: <20191222174718.nb3noztxo64g7jl3@yadavpratyush.com>
References: <20191220104258.1110d00e@pc09.procura.nl>
        <20191222174718.nb3noztxo64g7jl3@yadavpratyush.com>
X-Mailer: Claws Mail 3.17.4git65 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Q7Z8z5._MWyhExffzquFk0g"; protocol="application/pgp-signature"
X-CMAE-Envelope: MS4wfPkvjtLZ2x04NJNX/vNEwtGAvW6A0rPoZ5yWKZSaMz5Dpiki3J8MtK+Y/vYICAsS0oXT8rJJ8O5987Ved1P1s+QgUqAefb1fjjqn3wdI0j/s9einAR1x
 DuOe4k9Z6iaAZLl884D3Zzfp+5B7nwNUYtDnjOtsKRCqUTFobRHeuE2/hoxklqNfADbSprZO8OGveSNfKeyY45f+MpuCkJ9M33U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--Sig_/Q7Z8z5._MWyhExffzquFk0g
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Dec 2019 23:17:18 +0530, Pratyush Yadav
<me@yadavpratyush.com> wrote:

> Hi Merijn,
>=20
> On 20/12/19 10:42AM, H.Merijn Brand wrote:
> > =E2=80=A2 Right click context menu on file-entry in Unstaged Changes li=
st =20
>=20
> It is something on my TODO list.

\o/

> >   - Reset changes =E2=86=92 git checkout this file
> >     I see the current changes need to be reversed, are bogus or
> >     invalid =20
>=20
> I'm not sure what this means. When you hit Ctrl-J or choose it from
> the menu bar, current changes can be reverted by checking the file
> out from the index.

I always interpreted Ctrl-J as to mean revert *all* changes. Now I know
better. Thanks.

If you add it to a context menu, I'd like to have an option in setting
not to get a dialog, as choosing it for a single file is (at least to
me) obvious enough not to need a dialog to confirm my choice.

> >   - Restore this file =E2=86=92 git checkout this file
> >     it was accidentally removed. Like the first option =20
>=20
> What constitutes as "accidentally removed", and where do we restore
> the file from? If it needs to be restored from the index, then Ctrl-J
> should do the trick. If it needs to be restored from an older
> revision, well as of now git-gui doesn't have many features that deal
> with things like this. But maybe something like this can be added.

In my mind there is a difference between a changed file and a deleted
file. Ctrl-J restores the previous state, which in effect is the same
for both options.

> >   - Remove this file from disk
> >     Somehow an invalid restore, a misplaced output or other reason
> >     (core dump, debug output from other tools) made this file appear
> >     and I don't want to add it to .gitignore =20
>=20
> This feature was recently added in fa38ab6 (git-gui: revert untracked=20
> files by deleting them, 2019-12-01). You can hit Ctrl-J on the
> untracked file to delete it.

Yeah!

> >   - Add to .gitignore
> >     Like above, but this file will re-appear more often =20
>=20
> A naive implementation of this shouldn't be too difficult. I'll see
> if I can find some time to do it.

Yeah! (again :)

> > Does this sound reasonable enough to make it a ticket/issue? =20

Thanks for the feedback

--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.31      porting perl5 on HP-UX, AIX, and Linux
https://useplaintext.email  https://tux.nl  http://www.test-smoke.org
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/

--Sig_/Q7Z8z5._MWyhExffzquFk0g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEGolmczWuFi3lJEbAA6FHoT5dwJgFAl4AsKkACgkQA6FHoT5d
wJjqPgf/RIQqlUaA1mQOXrvN/Tmlih3zaERXyyZ3enimXjRgTjSnMn9KkC/otY+/
qIjNvewAmkd58KvsCxnktZT3PYCXxvT7EVuZONIIOQeSqaDlLtKIgNJXK3t06l06
qSWYi5W4klfTfX1bIUo0f6tSBYWHSrG8LTWvzHJOiu3CIHxtpPGbDY3La4Yz1qVg
m3mBOnXvlzmbMCG88h8U2wxTDlj9g9xzdrcnfY+CLcqFAy9kgcVZgoyI12WHFe/R
MvOtnzDOfpu//v2pF9LF9gdBqvygZnmdAT+36SwA9yxEO9PNIk5xGTkvKlihqAsI
CEqvGnGRTUZ9eh8+5hTPvNJ4JMBM5g==
=53cF
-----END PGP SIGNATURE-----

--Sig_/Q7Z8z5._MWyhExffzquFk0g--
