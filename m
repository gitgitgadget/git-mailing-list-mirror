From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Sun, 22 Aug 2010 10:20:56 +0200
Message-ID: <20100822082056.GA5156@localhost>
References: <4C6A1C5B.4030304@workspacewhiz.com>
 <7viq39avay.fsf@alter.siamese.dyndns.org>
 <20100818233900.GA27531@localhost>
 <7v4oepaup7.fsf@alter.siamese.dyndns.org>
 <20100821080512.GA30141@localhost>
 <7viq335ct0.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 22 10:21:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On5nk-0001z5-3h
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 10:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994Ab0HVIVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 04:21:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38392 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab0HVIU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 04:20:59 -0400
Received: by fxm13 with SMTP id 13so2467190fxm.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 01:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=/w6tGwUjSGqI2RmPhKOLOPOqB/GBZAYrxh5ffHLfnLU=;
        b=w5bX+u12USZYQJZWXvnSJuAndhpO1kscuGemkoQIeGcm44W4/6iRc/SBQTSosFAzGx
         BXi5/4gaK7mLbbBY/pmdd4B1AlIYdS6wBW0DWSzWNyl/9h7dmu/0xd2CL5+B+vaGxpWC
         4e+V/Gv6G9P/AalJQOWW6va2XM5umn9kyG2eU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Niv3BnW/JckjwHpT9Slxoax8hM+5AftKlPiIDRGaW43u6oK4v1EphnDKc+3m33CBe5
         VUDfOx69HITTblFC2XcfDpIqSi5tWy0TNbQn8Y1BGSJxrdEmpn0+QcP2HpyUQ9SVY5HP
         SFhWDsBD/B79WIPMKBaWdtBAd7GVm5dQKTQG8=
Received: by 10.223.110.83 with SMTP id m19mr2880518fap.26.1282465258586;
        Sun, 22 Aug 2010 01:20:58 -0700 (PDT)
Received: from darc.lan (p549A79A2.dip.t-dialin.net [84.154.121.162])
        by mx.google.com with ESMTPS id f28sm1937807faa.0.2010.08.22.01.20.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Aug 2010 01:20:58 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1On5nU-0001MX-SV; Sun, 22 Aug 2010 10:20:56 +0200
Content-Disposition: inline
In-Reply-To: <7viq335ct0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154178>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 22, 2010 at 12:25:31AM -0700, Junio C Hamano wrote:
>=20
> Traditionally (think "git status" output without "-s") the way to remind
> oneself that some day these paths need to be added when they are ready has
> been to keep them untracked but _not_ ignored, so that they will be listed
> in the output.

But they do not have to be added. I may never want to add them. So
I do not want git status to keep reminding me. That's why I add
them to .git/info/exclude. And with the current behavior, I do not
see anything wrong with that, because git does not consider them
trashable.

> Quite contrary to what you earlier said in another message, adding
> such a path that is not trashable does defeat the point of the "ignore"
> mechanism.

If I understand correctly, the reason for considering ignored paths
trashable is because they are likely to have been tracked in other
versions of the project, and would therefore frequently get in the
way of commands like checkout or merge.

But the same is not true for private ignores in .git/info/exclude.
Such paths most likely never were tracked and never will be. And in
the rare case that an ignored path turns out to be a nuisance, it's
easy enough to remove it from .git/info/exclude.

So I see only advantages if such a path is not considered
trashable.

Clemens

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMcN3oAAoJELKdZexG8uqM8ZIH/0hCX9UAxvhvQGwy6aM5OzGZ
HElD+x+9Kv58LgKYg2yfNaCM1tCxE2KNGOMH3EudGep7vq2hWVyTb4mnVx/F82pB
KlC02WFZ2BH5kf4+fI20HUZB2ZHM3PqMcreZeGJR/Qi4ASaHYMn4rUlum1E48EA+
F6OqVOENVRaE3Dgr8AQalhEBG7fW2pvExXcxO3iYGcBI6MVb6uXw10i0pDaCt5VV
MJg0q8QeaGpyOruJQR13QEilr7PURDQH+SXAu9antVWA9kuSCTRnojv+HTsoBOGd
O1wFT5oGj8UURBcMVRF8Y0Y4MlYrxivYbMyEFIbuJUAT771sP6FuIPhN2vGI5ZQ=
=2bwJ
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
