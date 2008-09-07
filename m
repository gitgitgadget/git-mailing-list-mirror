From: Marcus Griep <marcus@griep.us>
Subject: Re: git-svn and complex branch/tag layout
Date: Sun, 07 Sep 2008 12:45:47 -0400
Message-ID: <48C4053B.60704@griep.us>
References: <48C139EB.1000104@icyb.net.ua> <20080907025626.GB12392@untitled>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFE63A926B42BD45C319A133A"
Cc: Andriy Gapon <avg@icyb.net.ua>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Sep 07 18:47:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcNQ7-0001ye-3w
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 18:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbYIGQqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 12:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754236AbYIGQqV
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 12:46:21 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:26782 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbYIGQqS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 12:46:18 -0400
Received: by yx-out-2324.google.com with SMTP id 8so609275yxm.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:sender;
        bh=iYdRsD5Hsn4P/HqATTN3hLeAZrXO7lDG4Szdoa0oTfI=;
        b=ghcBCw7u8mTaW64sjZJwp0K6hRmYZQ+TvkiUJ6pmluQX5X2o78bnwC0Nx/CZpIq20U
         nUa/p3LX+j8CTnABoKRDB09ywblSGDIKWOL0kiig5AtIboJEj0Unx4Cbb4ywSTHpdFRR
         AsMjLJN45H37IsB6AxndISLC+Eumu4oxvVods=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type:sender;
        b=MS+IMXDn8jkD826Xe0o4MGV5dUBPRUEL+aqIOP1NqM3wbzE6pJ/zW1qne7nuOBLS9o
         ima0DqOTue6kuZvqA+rKE9MyH+2alhGgbvbBvLAlL0Z+9svdAObNTyx9cX4HhIY0JiCT
         FYC4krjjwR3xZj1p41pOc2rc23mUL4alSrpXE=
Received: by 10.151.112.19 with SMTP id p19mr19889334ybm.65.1220805976958;
        Sun, 07 Sep 2008 09:46:16 -0700 (PDT)
Received: from ?192.168.1.152? ( [71.174.65.37])
        by mx.google.com with ESMTPS id k41sm4367550rnd.6.2008.09.07.09.46.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Sep 2008 09:46:15 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080907025626.GB12392@untitled>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95147>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFE63A926B42BD45C319A133A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Eric Wong wrote:
> Double-globbing should work, (I thought Marcus got it to work a few
> months ago), but doesn't seem to at the moment:
>=20
>   git svn clone -b '*/*/etc'
>=20
> Marcus?

I'm not sure about starting with multi-globs, but I've been using the 'br=
anches/*/*' form
for a while now at work.  I can try to look into the '*/*' and '*/*/blah'=
 forms this week.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4


--------------enigFE63A926B42BD45C319A133A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIVAwUBSMQFRgPFruyc22R/AQLqxw//RzdnVQix/Yd8nahMWeENyZ5Mv5xitLtc
HibqlN6g+iy7Ia7BywNn1i8oxeNPpZmx6ocfIPvbZ2JnqDnOBiJAcJvDtAaf141O
bRPIhSV5T2AokIpY11cp9+55VFre6piwFYMFxIg0aj48fSQ2J33LJDI6/xiotQqk
qVZh/UT2RNEKuKE6u34sVtEdx30pXMEFZikzsqFjm3h8vD4p3RzOGnTLc3Z2K+8j
NEP6DAJlMQPi7COw6C7StPi6uacOfCLux3oH5frC5wtX/UIwfKajDuDJTphbjVf5
Bq0HGXk+SKSokapdVcy2nQObrVGyY2K6CU2rFjZHJGUJiu+W2RDAaDLkPvJzUYkn
gyT+FQusKWUC6zHxFPHkfeIOYIKa/T6MT7Lv0idlcsi2v6NalICBuzEB2+t6vJe3
/c2/AaAo1Dzeu0SaSe/wOPhaiOgRXOgrkg0g93gCFwD3+LmTBPnHQzkQveCJDhhi
wMdyWZ5v7XQyVBgUelHzlIROC5GRsT49CYj7QN1MkzXVCOf03yr+IETdkr3yUCxl
AIeKokEyjOPEKyvYxphoOTOCqwtsar6voIpZre1BCRyW3YwJE3qhlJ1aeW6u5iZ2
p/opJXx3qBRY9UCV5llu4KDSYRzXBF/qmNF+TwUnviyMVksz3zRXp0+F2gUxq5Xw
Loo3YXnelCY=
=YWf0
-----END PGP SIGNATURE-----

--------------enigFE63A926B42BD45C319A133A--
