From: Kovacs Levente <leventelist@gmail.com>
Subject: Re: remotes
Date: Wed, 4 May 2016 01:36:24 +0200
Organization: logonex.eu
Message-ID: <20160504013624.4c51ce42@wind.levalinux.org>
References: <20160503181624.1504eb0a@laborpc>
	<xmqqshxylvwh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/H/_gi7GpFaF5cxYJhlPZxgw"; protocol="application/pgp-signature"
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 01:36:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axjry-0001eS-C6
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 01:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835AbcECXgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 19:36:42 -0400
Received: from mail1.kabelnet.hu ([79.121.0.7]:52717 "EHLO mail.kabelnet.hu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756345AbcECXgl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 19:36:41 -0400
Received: from 5e1be956.mobile.pool.telekom.hu ([94.27.233.86] helo=chacha.levafreebsd.org)
	by mail.kabelnet.hu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <leventelist@gmail.com>)
	id 1axjrl-0001Xp-UK; Wed, 04 May 2016 01:36:35 +0200
Received: from wind.levalinux.org (unknown [192.168.1.174])
	by chacha.levafreebsd.org (Postfix) with ESMTPS id 660FEE9F1B6;
	Wed,  4 May 2016 01:36:32 +0200 (CEST)
In-Reply-To: <xmqqshxylvwh.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.13.0 (GTK+ 2.24.25; i586-pc-linux-gnu)
X-Spam-Score: 1.7 (+)
X-Spam-Report: Spam detection software, running on the system "spamd2.kabelnet.hu",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Tue, 03 May 2016 13:38:22 -0700 Junio C Hamano wrote: >
    Lev writes: > > > I accidentally added a remote of another repository to
   my config > > file. And so I merged two different repositories together. Is
    there > > any real user case for this? > > Using multiple remotes is a perfectly
    normal way in which you are > expected to interact with a single project
   with other participants. > Perhaps there is one single authoritative and canonical
    repository > where everybody initially clones from, and it is likely that
    that > repository is your "origin". Often there are cases where another >
    participant has a topic that is not yet ready for the mainline but > is worth
    considering for early adopters and/or is solid enough for > other project
    participants to build their work on. In such cases, > you can add the repository
    of that other participant as the second > remote and fetch from her. [...]
 Content analysis details:   (1.7 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 FREEMAIL_FROM          Sender email is commonly abused enduser mail provider
                             (leventelist[at]gmail.com)
  0.0 DKIM_ADSP_CUSTOM_MED   No valid author signature, adsp_override is
                             CUSTOM_MED
  0.8 RDNS_NONE              Delivered to internal network by a host with no rDNS
  0.9 NML_ADSP_CUSTOM_MED    ADSP custom_med hit, and not from a mailing list
X-Scan-Signature: 77adb6a45160ca56415dadedbb73ff5b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293479>

--Sig_/H/_gi7GpFaF5cxYJhlPZxgw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 03 May 2016 13:38:22 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Lev <leventelist@gmail.com> writes:
>=20
> > I accidentally added a remote of another repository to my config
> > file. And so I merged two different repositories together. Is there
> > any real user case for this? =20
>=20
> Using multiple remotes is a perfectly normal way in which you are
> expected to interact with a single project with other participants.
> Perhaps there is one single authoritative and canonical repository
> where everybody initially clones from, and it is likely that that
> repository is your "origin".  Often there are cases where another
> participant has a topic that is not yet ready for the mainline but
> is worth considering for early adopters and/or is solid enough for
> other project participants to build their work on.  In such cases,
> you can add the repository of that other participant as the second
> remote and fetch from her.

Yes, I use that feature.
=20
> It makes no sense if the two repositories hold histories of totally
> unrelated projects, of course.

Would it make sense to implement some protection against these kind of
accidents? At least a question "are you sure you want to merge two
independent repositories/branches?"

Thanks,
Lev


--=20
73 de HA5OGL
Op.: Levente

--Sig_/H/_gi7GpFaF5cxYJhlPZxgw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXKTX/AAoJECHeg32hsZ8o3jkH/2Z2I4Gmvw0OYbMZz+52bXiM
8+0dJhRXU+3Ghm1xkp3kq7GlnywaeXs7e2aeW6wmZB0aa/KlOb98GENiiDCdrLuQ
upWXErT5rRw+mzBZ6SRK3MvWWxZ54jauj/XuafEAXTCwQxWdko1i/wK1B+Uq5v2y
ow4224YPUg6m1Sjav2qaQyZpB/KI3jQk4y7VWFbOTV5/+5FpZu78yLP5PpiH1CnW
ckJUctkZVwcdL+W5W8v8iUBH4H6W2ReYOs0i0MeNdHsPtAuAl3487F82OsDPez+5
DWLROVaFlgh+ZH8yuGqunnLVl7k/tHc8xm1GDcRweIiDGnflYAQJZ82onDF9EVA=
=JTII
-----END PGP SIGNATURE-----

--Sig_/H/_gi7GpFaF5cxYJhlPZxgw--
