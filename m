From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Question about 'branch -d' safety
Date: Tue, 13 Jul 2010 09:13:17 +0200
Message-ID: <20100713071317.GA26348@localhost>
References: <20091230065442.6117@nanako3.lavabit.com>
 <m3lj9jknlr.fsf@localhost.localdomain>
 <20100711065505.GA19606@localhost>
 <201007110916.29567.jnareb@gmail.com>
 <20100711133730.GA10338@localhost>
 <7v1vb9hnd9.fsf@alter.siamese.dyndns.org>
 <20100712184754.GA18429@localhost>
 <7v39vo8dkn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 09:13:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYZgL-0000UW-Gd
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 09:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab0GMHN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 03:13:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38999 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab0GMHN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 03:13:26 -0400
Received: by bwz1 with SMTP id 1so12687bwz.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 00:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=kVyoAs5cDBSEOU6nA4xEFeHqpzyCv5p/8qKZdydZ+B0=;
        b=xiDtmWS/71ULn20PagVobNenJ4Fm5mg2uheP1dOY+0VOVYg9iakIO/yCeONxWudrZg
         a8OW4nhChU9QWrjmRV/FnVsw/QTPbC9ShxAkqAUgC8cZcIpo7T4FoIHQazWdvL/S+5zv
         tODeNiqOMRQvM9T2xD7VEnPgsHvQHTdmdeYb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=eJjQGpywN/wTW6PEr8p+UEgT4aUTZXyq8bahwcDo8aF+dVgydiCiznAeFk0p8wBKXn
         Wld8CDXNrbFVL2lZU15HxFtdeU/hRF2y9vwguX2jyZkE1Tx7qQKcABgHJ1hxqlbqNNId
         N4lGFOWpRglTC7OkXiIO3sKs6dz4NlomvD49U=
Received: by 10.204.58.206 with SMTP id i14mr9473266bkh.31.1279005205567;
        Tue, 13 Jul 2010 00:13:25 -0700 (PDT)
Received: from darc.lan (p549A484C.dip.t-dialin.net [84.154.72.76])
        by mx.google.com with ESMTPS id s17sm22385187bkx.6.2010.07.13.00.13.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 00:13:23 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OYZg5-00071A-GW; Tue, 13 Jul 2010 09:13:17 +0200
Content-Disposition: inline
In-Reply-To: <7v39vo8dkn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150884>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 12, 2010 at 04:50:32PM -0700, Junio C Hamano wrote:
>=20
> I am not entirely unsympathetic to add "git branch --undelete frotz" to o=
ur
> vocabulary, but then we should leave users an easy way to really remove
> things, and it shouldn't be "git branch -d --i-really-mean-it frotz".
>=20
> It would probably be more like "git branch -d frotz" followed by "git
> branch --purge frotz" or "git branch --purge \*" (if we name the operation
> to remove cruft for undelete "purge", that is).

Why would we need that? Even now, it is not enough to do "git
branch -D frotz; git gc --prune". You need to expire the reflog,
since HEAD may still have a reference to it. So instead you would
need

 git branch -D frotz
 git reflog expire --expire=3Dnow HEAD frotz
 git gc --prune

Purging a branch becomes just a special case of purging anything
=66rom history.

Clemens

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMPBIAAAoJELKdZexG8uqMMOkIAIoOw4lUEE/MwPqppIWJcK2s
AJTFMHVbJXMw1v69w+opP16KLC68c+g5HnUbm3t1qCUhTPyHdNpEwpVtX431EHks
PDc7awHyNfOkTv1m+s3uPJr6uZCX5+k7Z9tlTes64H3ItOOLVjmV5GgFaH3g56Ut
F8xqFTVkFgavwSbHcu8eF4KSyBs5lK/BK8oLe742M0ucjdWmQiMsi34+jLbjkJj2
qFzWvQvIySDnKtN2udTmzvzWcsr/LDyM13lidpj+67NK6muAcDVaIvpskgUyO0ZO
3CQr9qCKSVXcSLHY3OqotAPIlqXhK7L9PzsQwecbADZMTHKjXWkQAcLHsW/KNHE=
=72/5
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
