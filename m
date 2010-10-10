From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Useful tracking branches and auto merging
Date: Sun, 10 Oct 2010 19:15:05 +0200
Message-ID: <20101010171505.GA15495@localhost>
References: <AANLkTimq0sKUavKiXepDOz+DvrymuRAVUyAyV+FzbCBD@mail.gmail.com>
 <20101004204625.GH6466@burratino>
 <AANLkTikkXdDepdeOY4MZvgfCEgX69Tx6d0-QS-g3bWK-@mail.gmail.com>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 19:15:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4zUV-0003wG-KY
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 19:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879Ab0JJRPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 13:15:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61579 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab0JJRPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 13:15:09 -0400
Received: by fxm4 with SMTP id 4so122590fxm.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Jr3JRiXBbbCb39lhZFATbQiIF1keJ9YgOV9Wth6thBE=;
        b=jha96khREaUGvLcETsBbHGiCPDwEAhqysWANUEYn+IkUJQcTKOrH+ourJJSN0cNcnt
         Df14I+m+uJ4k3V2CLha2q0RX3lWs5NJmQrM8SsvIS8A7UCMJ6Y0XSsAcBMN17RhRfSji
         /We0/6JqXp1fOvWwLinhEVY0k9qXGfgQc2Ryo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=hK4Bl+C8taSB6BmRBXvwTE6fw98L9SYdqdjf/uzK29hrJaIarQLADPa8ICTAV+7NOl
         vEy+F3dItpYJvfYM6p1Y07j8as0H9nfZIiCcs2GXVYgYZh+BHKAcR/OgPXx562QbQ0YQ
         038e2aiLjFWvLp8l/d8pTpukj4u4cTx1PT8EY=
Received: by 10.223.121.132 with SMTP id h4mr1291397far.2.1286730907661;
        Sun, 10 Oct 2010 10:15:07 -0700 (PDT)
Received: from darc.lan (p549A35A6.dip.t-dialin.net [84.154.53.166])
        by mx.google.com with ESMTPS id k4sm1728140faa.8.2010.10.10.10.15.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 10:15:06 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P4zUH-000476-VC; Sun, 10 Oct 2010 19:15:05 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTikkXdDepdeOY4MZvgfCEgX69Tx6d0-QS-g3bWK-@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158677>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 04, 2010 at 11:56:02PM +0300, Felipe Contreras wrote:
>
> Moreover, wouldn't it make sense to make 'git merge' = 'git merge
> @{u}'?

Isn't that what 'git pull' does? Especially after using 'git
fetch'?

I prefer 'git merge' as one of the few git commands without magic
behavior and DWIMery.

Clemens

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMsfSZAAoJELKdZexG8uqMaU8H/1ywa1OjDUSFTnkIcIKiXU+2
IXkL+x39cM7MwGp2PeTL52bY65EtBmzK3PYBrpWSd1QNnbcXX3WzQsIcNco7E5ni
zi95h6FNBfQqdnOCYSWcsn7nlIq5wf+oaTvmDgk68BXWzNjn8eZb5+WJlu3ddU74
e7c9EVRJ24KLxXznreapPPZ44A4sqobG+JwhYeM9v3bLG2KiKzVxKw0L8Gm6ig0A
9JbfegFKuuYHxkE+HPhWRvfXh1AFCNGRv5Gekn1QJ5VoNjSamMy+vtQME3xjG24C
eqggGm0MEMZH4Z5natOUZej/wVx7Acg6olMNkeKopK6LygyTbAZWj0DqYRQyhiQ=
=AEoh
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
