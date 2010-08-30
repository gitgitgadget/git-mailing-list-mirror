From: AlexanderS <alexander@sulfrian.net>
Subject: Re: [PATCHv4 1/2] daemon: add helper function named_sock_setup
Date: Mon, 30 Aug 2010 14:46:31 +0200
Message-ID: <20100830144631.23d1a164@laptop.localhost>
References: <7vwrr8ftjj.fsf@alter.siamese.dyndns.org>
	<1283167851-18331-2-git-send-email-alexander@sulfrian.net>
	<AANLkTindaa-wDkOMW=BgtNJ+Wmi3xaBo1o_CF7NFH=Qm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/lpp3WL95MRpdqSqVwoAKHEU"; protocol="application/pgp-signature"
Cc: gitster@pobox.com, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 30 14:46:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq3l4-00007l-MQ
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 14:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772Ab0H3Mqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 08:46:37 -0400
Received: from animux.de ([78.46.93.45]:47941 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab0H3Mqg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 08:46:36 -0400
Received: from laptop.localhost (gast220.spline.inf.fu-berlin.de [130.133.110.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id 00C1380D4AF5;
	Mon, 30 Aug 2010 14:46:49 +0200 (CEST)
In-Reply-To: <AANLkTindaa-wDkOMW=BgtNJ+Wmi3xaBo1o_CF7NFH=Qm@mail.gmail.com>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154794>

--Sig_/lpp3WL95MRpdqSqVwoAKHEU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Aug 2010 14:12:52 +0200
Erik Faye-Lund <kusmabite@gmail.com> wrote:

> Since serve() isn't a library function, wouldn't it reduce needless
> code churn to just make socklist a set of global variables (or just a
> global struct)? That way you don't have to pass it around, changing
> all those function prototypes.

I don't understand: Even if I make socklist a global structure or
something like that, I also have to change all this function prototypes
to remove at least the old unused parameters.

> I'm a bit intimidated by this change since I have a rather big
> patch-set on top of daemon.c, and I really don't want to resolve a lot
> of conflicts. But I guess that's my problem :P

--Sig_/lpp3WL95MRpdqSqVwoAKHEU
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkx7qCoACgkQ1SSUxvEq73xGQQCeIc1y4L/LIItHL8MpQgWwDkcz
w9QAnjtFYKSfqNIatddACBJ84Ft/0ULr
=dKG+
-----END PGP SIGNATURE-----

--Sig_/lpp3WL95MRpdqSqVwoAKHEU--
