From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: How to diff between a file on a branch and a master.
Date: Thu, 9 Sep 2010 10:16:26 -0700
Message-ID: <20100909171626.GD8466@vfa-6z.perlninja.com>
References: <1284051890085-5515312.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Cc: git@vger.kernel.org
To: hogsolo <greg@localdirt.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 19:16:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otkjk-0001fb-AK
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 19:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab0IIRQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 13:16:31 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51981 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab0IIRQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 13:16:29 -0400
Received: by pwi3 with SMTP id 3so615872pwi.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:x-pgp-key:user-agent;
        bh=sfC+dQgNaLfgFHWvZK2IlLwOjo8W4He4ATvm/Td/o7I=;
        b=a374CnZpQ1+sh4iSBBeJod1/HZExf9zfz3+1Gx8Ty3CC20AQdIEzh0ESvm5Uyj/7bi
         /PFmp4nO11gYqAfey12q8eECoPl/LzSlE7MJwf3WLJlSTIXTVbhN7YptaiCariifUxa1
         yXLkLFrL7RIpA6enJjjXtWRQTT1QMZ9SBNCPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:x-pgp-key:user-agent;
        b=h0eK5UBauIPjzMcLVe8cMJ1NFlinBZ1hOB22YotDmLhcXMGX8leeJUwYBhXgR7ZsYD
         JoBTgEnTDAD+PHm1LyvJWsKGI/Ll5//2LIfZO0pojOeC8hCPKQwVMQimxyFuAQrH4O4c
         Qlg0kZzIJB34Rqy6JDnFn1NzJgOj0AQIS7TT4=
Received: by 10.142.104.10 with SMTP id b10mr100185wfc.197.1284052589184;
        Thu, 09 Sep 2010 10:16:29 -0700 (PDT)
Received: from localhost (66.239.37.190.ptr.us.xo.net [66.239.37.190])
        by mx.google.com with ESMTPS id s34sm1758230wfc.8.2010.09.09.10.16.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Sep 2010 10:16:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1284051890085-5515312.post@n2.nabble.com>
X-PGP-Key: http://technosorcery.net/pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155866>


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 09 Sep 2010 10:04:50 -0700, hogsolo wrote:
>=20
> I've got a working file in my master, but I want to see what's different
> about it on the branch.
> I've seen how to diff the WHOLE branch and master, but not target a speci=
fic
> file.
> What's the syntax for that?
>=20
> thanks

You should just be able to tack " -- path/to/file" on the end of the git
diff invocation you're using to get the diff for the entire branch.

--=20
Jacob Helwig

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQGcBAEBAgAGBQJMiRZpAAoJEHJabXWGiqEBMcUL/2DcMKLQPdtAF70/jhrzZvG+
SKqKRvguN5cDObY5LjjOjJIcrUlMBHxfbbOae1wE/iJPBGawOo5K/LN+vRVnk7F+
43yw1gDG0ltcYDVA27LvkRrJ8PGIYh9aGcqkHThTXEuvrwHJ3P3q+hzep+fz22Bt
SCZvcw2IFqO+9l56Ei+2rHrFR3AWl5c/BcFZYBCIVhQRvq/cr7r22GnohhFZm5bA
uACTs8D7PP+/Xzoe7173bTzuu9tYG1H/uzcHWorF3KFIQcFD1fvUX62/3vq+Qqfp
brYNX3Ow2f0qvEcAiiZNu+iJFs544fY4v4eEl2YhJbU48ZG5UJt6kGNwUVZ9hJSJ
W8qa9m+f2WboHUrdsXuJx0T42P7Ng0XrTPgMoHipkSehb0iz9uUM06GXYGy7dbJJ
S1XSv0GVjj7BCmnCvzpCk0vs7KLE0/A/1NCreGtsJ3rUmZz70E6IR+SK853VDOh+
vwqqILUfsygD1pkkFz6fBK2mTJJEpt7gaTx3UjR0zA==
=nwQt
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
