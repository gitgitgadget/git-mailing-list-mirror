From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] disallow branch names that start with a hyphen
Date: Mon, 23 Aug 2010 06:37:01 +0200
Message-ID: <20100823043701.GA11822@localhost>
References: <20100822140801.GA6574@localhost>
 <7vsk262vla.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 06:37:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnOmN-0008L4-6S
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 06:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab0HWEgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 00:36:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50441 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869Ab0HWEgy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 00:36:54 -0400
Received: by fxm13 with SMTP id 13so2674897fxm.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 21:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=iq+WIKwyh74B/FO3JHUwC9+/adF/2xYVcaOtAK08ORA=;
        b=gYma5ocz8UhEBEXf6ajFbXvnigeAKtXrBoCUA1hsxkcVJEo2eoMymlwQmC63LXzOUM
         BMtvnpe0XIpCUkzlZhAo3nOFie1vRGECZpzp/1pM1g/xU4cocb5wx9Az+sRvFZyWJv3d
         h29JNfAbP5vU+3i5WWUVkvIcBjY3TSwjj8e/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=WWyKEjX9dVUfvEgARUSHzUfQIMwXe6a46IcZ5ELbSpTu6gGfSbOwN6aySHcy/uCGsN
         pRs5umI4kUR0GL5RJFZ0nOMKzcPP3MYgBSsLUHMm48IYH3Lpcu/z6L6Ekga/s2gNZCcL
         LZzFdmZKi2U/w7OZTTokRkNaQy2868zPHKkXo=
Received: by 10.223.103.134 with SMTP id k6mr3673635fao.5.1282538212740;
        Sun, 22 Aug 2010 21:36:52 -0700 (PDT)
Received: from darc.lan (p549A60D7.dip.t-dialin.net [84.154.96.215])
        by mx.google.com with ESMTPS id q17sm2278376faa.45.2010.08.22.21.36.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Aug 2010 21:36:51 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OnOmL-00035q-8D; Mon, 23 Aug 2010 06:37:01 +0200
Content-Disposition: inline
In-Reply-To: <7vsk262vla.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154203>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 22, 2010 at 02:20:17PM -0700, Junio C Hamano wrote:
>=20
> forbid "checkout -b" and "branch" from creating such a branch.

Sounds good to me. I will have limited access to email this week.
I'll revisit this when I am back.

Clemens

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMcfrtAAoJELKdZexG8uqMIOQH/AtIWcGlSBbrA+38lmCUIx4H
3ZQ6lpDlbF8nBIOwixtmkovOEXRPJ701cnTwBnKpBc/t2/Y62ot4JFg302oVtuVS
iLr16HkIKrMwS5FyTrUwh5kSFjLOX12Pa0/jUJK9mQIIftXYoTofxRm/ee2XysNi
cUGgPjrTO4Mgpmdv+o5v0yl4k22wVj83MijP1yd4Fn5BOb128syKcYnt8d/zk3vr
HvYG78OPEJ9dTrUnlCou77+BXGQ9KJvO2KBjPcfOw5uX+N1IPLSH4xJgQk+QdubE
aJh/RPkT46tSWOm4kvJTjdvEY13f+qEdZ2dTjV3rihtpZr2nAe8uG7x5cAMcCYU=
=VZKG
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
