From: Carl Worth <cworth@cworth.org>
Subject: Re: Make "git am" properly unescape lines matching ">>*From "
Date: Tue, 08 Jun 2010 14:30:25 -0700
Message-ID: <87wru9i55a.fsf@yoom.home.cworth.org>
References: <87hbldjo0s.fsf@yoom.home.cworth.org> <87d3w1jlp0.fsf@yoom.home.cworth.org> <4C0EAE08.60904@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 23:30:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM6Ne-0000ge-Om
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 23:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631Ab0FHVai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 17:30:38 -0400
Received: from u15218177.onlinehome-server.com ([74.208.220.233]:52840 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab0FHVah (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 17:30:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id D19B44196F2;
	Tue,  8 Jun 2010 14:30:36 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dr65KvDXYiWn; Tue,  8 Jun 2010 14:30:26 -0700 (PDT)
Received: from yoom.home.cworth.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 687DC431FC1;
	Tue,  8 Jun 2010 14:30:26 -0700 (PDT)
Received: by yoom.home.cworth.org (Postfix, from userid 1000)
	id 15DDF568FB6; Tue,  8 Jun 2010 14:30:26 -0700 (PDT)
In-Reply-To: <4C0EAE08.60904@zytor.com>
User-Agent: Notmuch/0.3.1-53-gd64d0cc (http://notmuchmail.org) Emacs/23.1.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148720>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Jun 2010 13:54:32 -0700, "H. Peter Anvin" <hpa@zytor.com> wrote:
> On 06/08/2010 01:47 PM, Carl Worth wrote:
> > I've also noticed that format-patch is generating bogus mbox files
> > without any escaping. (The only way it gets away with this is that
> > mailsplit only treats "From " lines as separators if they end with
> > something that looks quite a bit like the output of asctime.)
>=20
> At the same time, it would be a fairly major lose to not be able to
> generate individual messages easily.  I have personally considered the
> fact that git format-patch produces something-vaguely-like mboxes rather
> than individual plain RFC 2822 messages to be a bug; fixable by "tail"
> but annoying.

I totally agree. I said as much later on in the message. We should fix
format-patch to not emit the "From " line when generating files for
individual messages, (and we should fix send-email to accept such a bare
file).

That much is easy to agree on since it involves using mbox less, so the
whole "which mbox format to use?" question goes away, (for these uses at
least).

=2DCarl

=2D-=20
carl.d.worth@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFMDrZx6JDdNq8qSWgRAh9sAKCgX+kFrxQdEYRKtFB+A9ovl+igOgCcD65b
lZzznNR04vB5B17HcvoYucA=
=RP05
-----END PGP SIGNATURE-----
--=-=-=--
