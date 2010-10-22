From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: pulling the root commit overwrites untracked files without
 warning (1.7.2.3)
Date: Fri, 22 Oct 2010 23:14:00 +0200
Message-ID: <20101022211400.GA1774@localhost>
References: <AANLkTimDnyzyV1FEEwEuxLfG1nSOcNa7Hzwt7DDssjba@mail.gmail.com>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Cc: git@vger.kernel.org
To: Gert Palok <gert@planc.ee>
X-From: git-owner@vger.kernel.org Fri Oct 22 23:13:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Ovo-0005YG-SR
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 23:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759604Ab0JVVNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 17:13:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43301 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755783Ab0JVVNa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 17:13:30 -0400
Received: by bwz11 with SMTP id 11so959048bwz.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 14:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=D3CBJNlVWYnt7Y0jLsugUZdqYEJPTQgQNVw81CyfEI8=;
        b=JEonzsLEJtSbkRtZGM/fJK7DUQ73NrvIc5jGcvGxKqsVYfjvfWBorPZnkii+fftMRM
         g9BXjQarjrmetku0yFPHH58fuLsYfDyU4lRPFDiHYm7SA+t0odqflwXan9TTLBpw1gaO
         b3UU7CR047O+0HkxCGGrL7js5+zRpX14ukb+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=GfC8KAJjFIiAJj6yIxlAI5msHn9efI6YfhmET27P5YrLZElP5MTZGHDVV2u49Wd1pz
         2hB87rlwKMYa2i3bq3EZoaDVkYh0MZuG69W1iChv9+efBNiJeWdXNnVtWuanzdFB1jgQ
         BrzzVdZVTAYXGDr1RKBdUhmufkUo34uat7gzQ=
Received: by 10.204.112.78 with SMTP id v14mr2645944bkp.119.1287782006884;
        Fri, 22 Oct 2010 14:13:26 -0700 (PDT)
Received: from darc.lan (p549A6958.dip.t-dialin.net [84.154.105.88])
        by mx.google.com with ESMTPS id p34sm2448113bkf.15.2010.10.22.14.13.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 14:13:26 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1P9Ow4-0000TS-C3; Fri, 22 Oct 2010 23:14:00 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTimDnyzyV1FEEwEuxLfG1nSOcNa7Hzwt7DDssjba@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159750>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 21, 2010 at 04:18:19PM +0300, Gert Palok wrote:
>=20
> On 1.7.2.3, pulling the root commit overwrites untracked files

Thanks. This is probably fixed by the following series.

 http://mid.gmane.org/1286632380-7002-1-git-send-email-drizzd@aon.at

I hope to finish it this weekend.

Clemens

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMwf6YAAoJELKdZexG8uqMheUIAJzRPCHKarG3dVjk4sR35Xzp
QZ9TaamDEu1X3DuGnkApbGhMTi8H6a5WpwsD/6CvpX4CYaPTay3iSwVBWD9YrV7E
j7eE2x9u8nl6FIRzOopLcnQbHsYnBmfxETf8v6Ob453ktRjVka676SMCJsO+84Re
4I24BiF02oxM56gYznVpsfGUpe6X0x0tmKfJkF1fshhWFz8f42WSSsaZRQXJbdkU
nzU6GQaZTb/dhSNFLdjwo9PrxthPPQxILlEAPCeZ+4QJQAD53S6KeWJATPe4/O4g
Sc2ExWI/OU2g2Sg4OBsyH56yMITWknxbQ3lcHd3NFz4VaZcTytO3SNAyd3m//W0=
=3nJY
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
