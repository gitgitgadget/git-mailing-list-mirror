From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Find out on which branch a commit was originally made
Date: Sun, 19 Sep 2010 14:54:38 +0200
Message-ID: <20100919125438.GA4870@localhost>
References: <4C94EBBC.4080201@gmail.com>
 <1jp2d5s.1q4xl2w1f5ufljM%lists@haller-berlin.de>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Cc: Artur Skawina <art.08.09@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=3F?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sun Sep 19 14:54:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxJP9-0004EL-Qp
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 14:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651Ab0ISMx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 08:53:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33387 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374Ab0ISMx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 08:53:57 -0400
Received: by bwz11 with SMTP id 11so3736602bwz.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=1B0QQTIq6qtd01ZYaGZLIMcCUEBPUQttw2dtoVN54oc=;
        b=MG+/AYABIFT6+M5fnWzBXTRUq3ATuOzsSJsj5YDjNkHe//oGkw+D1IvGEKITxzCuEF
         5zhp0WgA0hErPtTiOhtvxGqt0PiB9lh/61pZa1CXzIIjMWW9B/U9H6LJ3ggsxgOkYEZ7
         EA6rLsYJPn/ebKiBdT+FmWznyCxNHEeH8vMo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=YPWRyuj9zfy3XyTx9l4NyuzNoF1lc91s0TBStDmUYniAA0h6tZZV1gIUY5pKoQ+PlV
         FaZaCO9H+01wp1VM38vtjkb6Jy5Mc3Sjav1H9FWEEJhFSsPPo9H1G2X55d4ds2hLgma6
         SgzBOwdOJLevUHhtsCWB1mgXBstD7bNZ4snA4=
Received: by 10.204.67.138 with SMTP id r10mr5805995bki.103.1284900835900;
        Sun, 19 Sep 2010 05:53:55 -0700 (PDT)
Received: from darc.lan (p549A467A.dip.t-dialin.net [84.154.70.122])
        by mx.google.com with ESMTPS id x19sm5554734bkv.21.2010.09.19.05.53.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 05:53:55 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OxJPi-0001Hs-CS; Sun, 19 Sep 2010 14:54:38 +0200
Content-Disposition: inline
In-Reply-To: <1jp2d5s.1q4xl2w1f5ufljM%lists@haller-berlin.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156494>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 19, 2010 at 11:45:25AM +0200, Stefan Haller wrote:
>=20
> Your command also shows M, which is not interesting at all in this
> context.  Ideally it should stop at the first command that's common to
> topic and master.  Is there an easy way to achieve that?

head -1?

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMlggOAAoJELKdZexG8uqMhdIH/1Acn9u0BaCO5ud4GgyxhZZ8
wTZ8xMJoqvbmYgnvMEn3XW8I0deikvv76aQqNEOm07v/Oy8BW0YRX27VbrOXthTB
sidz0WoPDJk+66RZF3CB4mKTXVxdfPXz9E9ESfOq91KhNiMUR6BVQWBFM/xTS41p
92vlGFrgbyWigKtVQD37DaaSBZ/g0WPraXlbALcQf9GUJQSBFxp1pRw8MNh3WCCg
fEJ7uMZhJbmQnmTJE7YhlXTv3iYt/MOkQ/QnrKXQg3l/nC5FocqMmG4SWda5WYly
/fWnjsqpsGle8lLk0iKwvXVWHeHDDTRthVrbSY3WDpPIeHwv3aEexHUjiLa+FHA=
=A0yk
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
