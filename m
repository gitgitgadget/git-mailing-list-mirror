From: Grant Olson <kgo@grant-olson.net>
Subject: Re: PATCH:  Less fragile lookup of gpg key
Date: Mon, 03 May 2010 22:23:31 -0400
Message-ID: <4BDF8523.1030202@grant-olson.net>
References: <4BDC45EB.8090305@grant-olson.net> <4BDC561B.4030307@gmail.com> <7vhbmr5ym4.fsf@alter.siamese.dyndns.org> <4BDC63FB.7060202@grant-olson.net> <7v7hnn4cun.fsf@alter.siamese.dyndns.org> <m1O8k0Z-000kndC@most.weird.com> <BA24F2BF-018D-403B-A23B-0F2E57A7C00A@mit.edu> <m1O93yz-000kndC@most.weird.com> <20100504021937.GY14986@thunk.org>
Reply-To: kgo@grant-olson.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8722990E1500AC119B022C40"
Cc: The Git Mailing List <git@vger.kernel.org>
To: tytso@mit.edu
X-From: git-owner@vger.kernel.org Tue May 04 04:23:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O97nc-0001qU-UI
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 04:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756873Ab0EDCXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 22:23:47 -0400
Received: from mail-qy0-f189.google.com ([209.85.221.189]:39620 "EHLO
	mail-qy0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755682Ab0EDCXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 22:23:46 -0400
Received: by qyk27 with SMTP id 27so7163220qyk.23
        for <git@vger.kernel.org>; Mon, 03 May 2010 19:23:44 -0700 (PDT)
Received: by 10.224.28.36 with SMTP id k36mr4637812qac.47.1272939824105;
        Mon, 03 May 2010 19:23:44 -0700 (PDT)
Received: from [192.168.1.182] (pool-72-95-232-67.pitbpa.east.verizon.net [72.95.232.67])
        by mx.google.com with ESMTPS id 4sm10435609qwe.7.2010.05.03.19.23.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 19:23:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100504021937.GY14986@thunk.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146280>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8722990E1500AC119B022C40
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 5/3/2010 10:19 PM, tytso@mit.edu wrote:
> On Mon, May 03, 2010 at 06:19:17PM -0400, Greg A. Woods wrote:
>> Meanwhile the original problem here appears to me to be that Git
>> effectively encourages use of multiple valid keys that may have the sa=
me
>> e-mail address attached to multiple key-IDs.
>=20
> Yes, I think that *is* the problem.  If you want to optimize for the
> common case, that's fine, but it's also useful to have a way for users
> to specify in their gitconfig files that a specific KeyID should be
> used if they are signing with a particular e-mail ID.
>=20

That's already there:

git config user.signingkey 0xDEADBEEF

-Grant


--------------enig8722990E1500AC119B022C40
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJL34UtAAoJEP5F5V2hilTWA/wH/RokfCxnLdZpaxG4REZYBUm3
W0z7dlcdDy45WUqzv4ZBcjCbEksNK4FTGHfJMcMyJT0lcln5oxJ4yNOnQfiKrBcr
0+m3dfVcveni8n7KYsdfGKiql/8wpeG0ug3r/4n9Iti43znALOdSrAgOMcjTO8tb
1RVXE+tG++3PnFT2JAwVBB33n82vSSGhkligkRI9IARG/k8aYN+609JZWaayD7wP
az76yemZv/+fAJk3Ztp8q6jSMDP4fhguUZOP81UzeDaTU4tXvoyj2tw8JheZxcIB
XjWOr1tTfAAihH0+t96MXBKk4ITK+ypwP7JEU4O3ATzl4VZlyot/mUsoT8nYk+c=
=IBmO
-----END PGP SIGNATURE-----

--------------enig8722990E1500AC119B022C40--
