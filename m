From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Question about 'branch -d' safety
Date: Mon, 19 Jul 2010 21:34:59 +0200
Message-ID: <20100719193459.GB21744@localhost>
References: <20091230065442.6117@nanako3.lavabit.com>
 <201007181355.36691.jnareb@gmail.com>
 <1279484847.8999.22.camel@dreddbeard>
 <201007190119.04873.jnareb@gmail.com>
 <1279523523.3077.8.camel@dreddbeard>
 <4C448879.4040202@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Cc: wmpalmer@gmail.com, Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 21:35:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oaw7W-0008RK-26
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 21:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966560Ab0GSTfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 15:35:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:32822 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966537Ab0GSTfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 15:35:08 -0400
Received: by ewy23 with SMTP id 23so1423533ewy.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 12:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=jb+DUVbu8Se55gRCY3tximCOa/pmvFl1t9ybpIYW/+k=;
        b=S3EDU2SES2IjZQcJ7jgrAG6h8/OhPQG4EgcIOsggyb0slhvXWJmhZFOUd60ksk00fc
         8JBhqPaEaLo3cbdZ+zjyUcRLehpRm6vDlkBWh5BRbYq0xxf7SrlFikg9PkXXMY3Tb9sl
         kn/W24buwl/2XPorQ/U3N6ZVSBx5ON/2Uqj5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=kpiGHMjF0fCYpY/l81EyffoTwmsPuEQ65SFVKE2u9nS1+Nrs67hrlfn5a+k64XezCy
         9JawZuk6gQZB3KMNjMD8NZSXLHn3J/9lTbquC7cCxYlskVKnJ5h1Zscnx/pIUcqmGUC0
         GVNdIjHC0VOxEL0kT/iIkLjGIWNN39zgZonkg=
Received: by 10.213.35.18 with SMTP id n18mr3459332ebd.85.1279568106260;
        Mon, 19 Jul 2010 12:35:06 -0700 (PDT)
Received: from darc.lan (p549A3118.dip.t-dialin.net [84.154.49.24])
        by mx.google.com with ESMTPS id z55sm50010195eeh.15.2010.07.19.12.35.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 12:35:05 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Oaw79-0005kf-QT; Mon, 19 Jul 2010 21:34:59 +0200
Content-Disposition: inline
In-Reply-To: <4C448879.4040202@workspacewhiz.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151271>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 19, 2010 at 11:16:41AM -0600, Joshua Jensen wrote:
>=20
> 0000001 HEAD@{0}: (fake)checkout: moving from integration to master
> (0000001)
> 8000000 HEAD@{1}: branch -d: Deleting integration
> 0000001 HEAD@{2}: (fake)checkout: moving from master to integration
> (8000000)

That does not fit very well with the current definition of the HEAD
reflog.

But I do like the idea. We could append branch deletions to
=2Egit/log/deleted, which otherwise behaves exactly like the HEAD
reflog.  And we simply do not keep the reflogs of deleted branches.

Clemens

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMRKjeAAoJELKdZexG8uqMmroH/3ZplUHPHek/6tH6iPEN3CEq
ZteEzuWB+yYsXy0yfssSOOcj67lbEASKYDqciJscwQjaw/5MpVSOCRiZKh1KZX+5
gZGI/6yl8dfqxOf3t+sS8QancKgsFFwWdg5l7VDlDcmHJ5eWDfLRM1+LOpu3SCsQ
UGf4PsYZXPWcVEp6+83DM2jUHKbrrF6VxA9iUibAF7U8fPQAgSA0J+LUdFMSWJ7C
1cTvcwMCJ1tGfEHpJWzM0m9wFnmIg92hJcGGJI3NLya2iVhfZ/MOxACf7/F0lQny
E0MO3q9rK/7gJeMk5xmw8JJR170zwYEuwliXf6ih94PUByYLLnqiho4z27KB4d8=
=sTEQ
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
