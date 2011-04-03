From: Robert David <robert.david.public@gmail.com>
Subject: Re: GSOC idea: build in scripts and cleanups
Date: Sun, 3 Apr 2011 23:17:20 +0200
Organization: DDM Praha
Message-ID: <201104032317.21573.robert.david.public@gmail.com>
References: <201103260141.20798.robert.david.public@gmail.com> <20110328142121.GB14763@sigill.intra.peff.net> <201103301739.12691.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1416335.eosQs74hxT";
  protocol="application/pgp-signature";
  micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 04 00:13:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6VXe-0008Ox-91
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 00:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab1DCWMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 18:12:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58485 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab1DCWMw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 18:12:52 -0400
Received: by fxm17 with SMTP id 17so3554894fxm.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 15:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:organization:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=oQx67TthYuaz+SEcxWieecIevwZI/mleMttpI3tkJpc=;
        b=QOqm8lq3CPC15D1LYmrYbW6iz/l0l3evOVdko1gAINlwc7gdM7QS3SIHCs7j+zaZYW
         wV70LKE8GQlqlC4iDBUVGaAQhzCfmsOofi2bunZXrzGEMpq/3WrXFdRkND5dTBZOOaxK
         RzniRuYIfZ0h8zx21BSFaFqSAJtV5CZywoJVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=es21pF/e9cWEqJRjP8ZBvhKsgtDef/b+CWzAFaVGe9MjmFWXH8LR50CQuyWNbJhnOQ
         paSNvqzXHBys1uIUKwdVl1fI1h7GJjw7ZiSDOs3thzSgJFHBp3Toj08Y8yVfGgXumVOZ
         WsRXHTK3VLhCIZNzcEm4/3gKKfKGMZYJ9RCr4=
Received: by 10.223.127.210 with SMTP id h18mr260524fas.67.1301868770702;
        Sun, 03 Apr 2011 15:12:50 -0700 (PDT)
Received: from robert-eee.localnet (gate.chabry.cz [80.92.246.13])
        by mx.google.com with ESMTPS id c24sm1478464fak.31.2011.04.03.15.12.49
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 15:12:50 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-5-686; KDE/4.4.5; i686; ; )
In-Reply-To: <201103301739.12691.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170782>

--nextPart1416335.eosQs74hxT
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Dne st=C5=99eda 30 b=C5=99ezna 2011 17:39:12 Thomas Rast napsal(a):
> Jeff King wrote:
> > On Mon, Mar 28, 2011 at 10:55:22AM +0200, Robert David wrote:
> > > > As far as cleanup versus features, I think Thomas would have to
> > > > comment on that. He is the one who did the most work on patch-mode,
> > > > and therefore the one who most thinks it needs cleaned up. :)
> > >=20
> > > Is Thomas going to be a mentor in this task?
> >=20
> > I hope so. I can also co-mentor if it helps.
>=20
> I'm certainly ready; I didn't propose any projects that I would not
> also mentor.  (However, I won't mentor more than one...)
>=20
> Note that while it's certainly a bonus, porting it to C probably makes
> the project more difficult and time-consuming.  We'll have to see in
> the proposal timelines however.
>=20
> As for cleanup, my gut feeling right now is that the Perl code can
> probably cope with incremental cleanups as required for each feature.
> On the other hand, the C port should start from a clean redesign so as
> to not rewrite it twice.

Hi,

I have submitted the proposal on gsoc official site. I would like to ask fo=
r=20
some comments on that. I don't know how you get access to student proposals=
 to=20
git. But I see that as proposal from "robertdavid" number 1.
I would like to focus myself only on this one proposal, so that is why I'm=
=20
asking for comments, to extend the proposal as needed.

Thanks,
Robert David.


--nextPart1416335.eosQs74hxT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iF4EABEIAAYFAk2Y4+EACgkQLSNWchw0XGxwkAD/SCyrOqvf67IjNwH8UJ/1fpn+
CLeIMyCDQsnqrGjWVSEA/RpRDwQH96HfLT0+Bl60reTUj0mqTN8EJfO6lZNF6sFZ
=D95P
-----END PGP SIGNATURE-----

--nextPart1416335.eosQs74hxT--
