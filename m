From: Grant Limberg <glimberg@gmail.com>
Subject: Re: [git-p4] Trouble importing all perforce branches into git repository
Date: Mon, 23 May 2011 13:06:15 -0700
Message-ID: <0AC6DD14-3042-4A18-91AC-1CE77D8B4CD2@gmail.com>
References: <20110522114917.GA19927@arf.padd.com> <398FA881-E4A1-49AC-80F2-2D46E9F2ABB9@gmail.com> <BANLkTi=TCyyS7Q=3BnLcG=yhL_boH=w1XA@mail.gmail.com> <34E33A18-B9C4-4CA9-B96C-79B0E2BDCD44@gmail.com> <BANLkTik+Zp1Fvi_zABCtAZH0RKA68n5Svw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-8--691022654"
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 22:06:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QObOV-00077W-7Z
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 22:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933880Ab1EWUGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 16:06:22 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64451 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932909Ab1EWUGV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 16:06:21 -0400
Received: by gyd10 with SMTP id 10so2272397gyd.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 13:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:mime-version:content-type:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to:x-pgp-agent:x-mailer;
        bh=9HrgB+Uymyx+93tcLhbV8aNV6xF/UEtD1MlRUDizpUQ=;
        b=m5eEYjSqMIhLgwr1XfUbCcKReXxPMCJozwuIEZyTPqRe/KDVy4e4ywvj5YYlSkKwQ8
         +xxxolhLu8BU4D1FdAJmUC1wQ7TxpfWTKcNhJ2dkp+H++jK6YAfqPnC1e7XmPMZrn5II
         dvu4nFUPGAaqWWOJ9xKfKBUZK46hZ8ym2kRFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-pgp-agent
         :x-mailer;
        b=hetZ04D5ntU2Vv0DG0F8Sawk19tfiPj24nBZf5KDZbGJeopa96sFNnXF3t2feBVYSx
         qguqBUVoBZTDKQvZugqgCb/HplCRh/Z7uPzbAf9htIvz4RNeasDQtPDa7EJxTGFETPyP
         Z1Zgl8UtpdwVeEg+O+9c00PB5iok3xFyAAaog=
Received: by 10.236.76.197 with SMTP id b45mr3710733yhe.147.1306181180591;
        Mon, 23 May 2011 13:06:20 -0700 (PDT)
Received: from [192.168.169.66] ([12.186.225.162])
        by mx.google.com with ESMTPS id 44sm2865383yhl.53.2011.05.23.13.06.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 May 2011 13:06:19 -0700 (PDT)
In-Reply-To: <BANLkTik+Zp1Fvi_zABCtAZH0RKA68n5Svw@mail.gmail.com>
X-Pgp-Agent: GPGMail 1.3.3
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174264>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-8--691022654
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=us-ascii

On May 23, 2011, at 10:38 AM, Vitor Antunes wrote:

> Hi Grant,
>=20
>> The "Branch-foo" that git-p4 is crashing on does have a branchspec in
>> Perforce.  I cannot, however guarantee that branchspecs were
>> correctly created and used for all integrates in the repository.  It
>> was created long before I started working here.
>=20
> You can create the branch specs now. There is no requirement for them =
to
> have been created at the time of the integration.
>=20
> I've sent a patch to this mailing list [1] that adds the possibility =
of
> creating these branches in a gitconfig file. If you feel brave enough,
> please give it a try. The patch is missing a test case, which I still
> did not have time to review and send
>=20
>> Is there a way to limit --detect-branches to only certain branches
>> that I can ensure do have branchspecs?
>=20
> If you have an incremental structure you could limit the cloning to a
> subset of the directories. I am not aware of any other way. Maybe
> someone else in the mailing list can shed some light...? :)
>=20
> Vitor
>=20
> [1] =
http://thread.gmane.org/gmane.comp.version-control.git/167998/focus=3D1680=
00

I think I just figured out the problem.  The branch mapping between =
//project/MAIN/... and //project/Branch-foo/... was done backwards, thus =
git-p4 was expecting Branch-foo to be a parent of MAIN when the inverse =
was actually true.  MAIN's first changelist number was 771.  =
Branch-foo's first changelist number was 7652.  That's why git-p4 was =
getting confused.  I fixed the branch mapping in Perforce and the clone =
with --detect-branches seems to be working fine now.=20

Grant Limberg
glimberg@gmail.com





--Apple-Mail-8--691022654
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.17 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJN2r44AAoJEH+RGVrhASuPKpwQAJZ7Zte4sgJRBHWQRUN80Sli
Uyou6thf97021LahdMX98S8YTfk7SdNqHncxe7VdTlXMbxjLLfKanaVaysRv1OPg
b0K9t1thQW35JhaNMQmp2A7MVGStWBEA/ntzsKgkvvEg4Aq0JcqfqbavXyDHa1u1
2EOza/9Kq3hhfwBETOM9B2zKJSRclBIdvvOINQcTAp5wFOkpY9w4u1ukXLyy3TZd
+3zXihZ1uNSo5FgteqyZi/l7rn7YpFD+XuT5vG4CUJimXFeTvJOhAvexsy2hRWzQ
fVYFs8103iMdgfR49cwAAlGYy2DYPtuXE7re8GjsMdr4S/xOpnxDV9OxAZy7aG5X
6sfOHvQrvDSJdmcBtipu8V4ewwnrjxJ433If4wptPWvQZipxIqX+5r4k9CZPF5gH
9Ol2Gvoh2gq0rjNxdpD3EZN29VvNPNWA1s8sgKfyuT2kvQbsH3lgPWSXYrLhlKwR
4ufRnUWEPdlNfvJtDsENdGM+5z9Pr3ue3Of0zKJzgOZahZkDDeJWq0Jp+EZS1DzQ
nawuE7o/rfTAO+Ug5ZY1lT+8otGDi3WFPQ08sM+YgPlRr38GO1/FxOXE0MzDTxdr
kzlzsGYpf+oQP/6G94D+wo3j2BLurPLzSllJk7rxb3ETdEexpsNln+urSoRFC43t
7zLTl7xTfAUGsbBThc4H
=TlBH
-----END PGP SIGNATURE-----

--Apple-Mail-8--691022654--
