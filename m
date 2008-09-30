From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 4/4 v2] cygwin: Use native Win32 API for stat
Date: Tue, 30 Sep 2008 10:57:31 -0400
Message-ID: <48E23E5B.7020404@griep.us>
References: <20080927084349.GC21650@dpotapov.dyndns.org> <200809272035.03833.johannes.sixt@telecom.at> <20080927215406.GG21650@dpotapov.dyndns.org> <200809281124.08364.johannes.sixt@telecom.at> <20080929153400.GJ17584@spearce.org> <20080930135347.GK21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDA3F217FC679BA1A05CDC90F"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 17:01:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkggq-00050a-HB
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 16:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbYI3O5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 10:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbYI3O5s
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 10:57:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:58474 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbYI3O5r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 10:57:47 -0400
Received: by rv-out-0506.google.com with SMTP id k40so59351rvb.1
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:sender;
        bh=vqMwMwull6ZDSyA83WfQLa3k+0FqNjIiGwrCIv5V5n8=;
        b=v79XhBBgOZu+PzTR+m/jnCbjuj4b8Ct9kJDAlOL1C4qeXzuMUbMn6pOJ4R9rAGYhkR
         aKlSzTophhaxrHB86wJVxE3AS0AOazUU1fVFWNIXPTE9H/DrHMOooLEzOOAlWjtqmVDn
         Maocpfs4f2AbhdTn0axLIYXvjczVO1bnvCMog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type:sender;
        b=ppoLr8eTpuBULppXA0TTTU+bLaODA0l85JMq7XcNEVqFFLOsDcOmqGiPSt6kXJd9eT
         HEOMYNB8y8uoKAsnKPQmdbTiTLygklKMdUggrV+2IaVZgM0TsH/DdZziHvcQIWZDhFfa
         uscr9WLV7dIQyL0wYHUl9gzstbJN3dJfgpa/g=
Received: by 10.141.3.17 with SMTP id f17mr3412480rvi.180.1222786666510;
        Tue, 30 Sep 2008 07:57:46 -0700 (PDT)
Received: from ?10.95.16.56? ([4.79.245.132])
        by mx.google.com with ESMTPS id 7sm1634455ywo.7.2008.09.30.07.57.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 07:57:44 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <20080930135347.GK21650@dpotapov.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97123>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDA3F217FC679BA1A05CDC90F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dmitry Potapov wrote:
> lstat/stat functions in Cygwin are very slow, because they try to emula=
te
> some *nix things that Git does not actually need. This patch adds Win32=

> specific implementation of these functions for Cygwin.

Can't wait to see this patch in next or master!  If you recall my benchma=
rks
from earlier, the speed-up is pretty good for cygwin users working with
large repositories.

> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>

Thanks for the work, Dmitry!

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4


--------------enigDA3F217FC679BA1A05CDC90F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIVAwUBSOI+ZgPFruyc22R/AQL7Ag/9F7CG9ata+M6PM6253jQtbrzLS4ddZRU/
iDmL3W5X7GfjfTLUcq1bOfR6FNICa8ycaZCCtVwJiiJ3aCBj+3Ox2vIWPmDVN3+9
oVWtXhVC9OGxPkwPr9I4EqM/QsT3d86urcaNeB97YPUcdZEyCpZ4Ki0FTMj9xoz5
xSG80S7NE8dfm38CwKnq3GgtSlj4oOnYl4vttjQc2C7jefM7EEO3iTMIwIdunGqE
KDYjrVbkBsyC/yhW+IrWtVz78N6bceq+lS2MVRdYOLZh69Zl8rCCioxBOhZNPkCl
FDhwgpkl245Ev5oJwDWmnDbstNDowf22ctLWz96tPdw1GJl7j4V23OXkhmZNKZxD
7p7NXAmVztUACViWlSX6zqMk5NUwSUSSqolOv77Yq7V4Mp/Zx15PPA3+d98Qv0qA
+Gc9Jpf8SEpD2dHx0ECJDRHNutn9OK6osOCFSS8tzboJVXM21HtyHuFBX6XnhoXB
3mhJu43jU96+qJ81IxMcvy/yIOcqQMqqwxRK6eb9S6ph0qgMEzgM7JDM9+HSYFAm
iqbIWZR4mB/AnEipjGXZCjBnFZZuZqBj09aIj+gf9QDwT9XRaGCAOtxBe7xffRKQ
4GaqdQ9Dd1z5jPuMAfAClhKmIUf/Yskufgq75p2V/ssSz8L24dWYmOazlQoJv5zb
E3CEMVSNTw8=
=Cc/L
-----END PGP SIGNATURE-----

--------------enigDA3F217FC679BA1A05CDC90F--
