From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH AMENDED] help: add "man.viewer" config var to use "woman" or "konqueror"
Date: Mon, 03 Mar 2008 08:42:23 +0100
Organization: At home
Message-ID: <fqga4j$hgt$1@ger.gmane.org>
References: <200802290814.39366.chriscool@tuxfamily.org> <200803010100.m2110ULs008889@localhost.localdomain> <7vir079ong.fsf@gitster.siamese.dyndns.org> <200803030838.48976.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:43:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW5KZ-0006gM-Qt
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 08:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbYCCHm1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 02:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbYCCHm1
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 02:42:27 -0500
Received: from main.gmane.org ([80.91.229.2]:54998 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbYCCHm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 02:42:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JW5JU-0006WY-8R
	for git@vger.kernel.org; Mon, 03 Mar 2008 07:42:20 +0000
Received: from abxb32.neoplus.adsl.tpnet.pl ([83.8.251.32])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 07:42:20 +0000
Received: from jnareb by abxb32.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 07:42:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abxb32.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75903>

Christian Couder wrote:
> Le samedi 1 mars 2008, Junio C Hamano a =E9crit :

>> How about allowing multi-valued man.viewer like this:
>>
>> =A0 =A0 =A0 =A0 [man]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 viewer =3D woman
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 viewer =3D konqueror
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 viewer =3D man
>=20
> I tried the above in my .git/config and I get:
>=20
> $ git config man.viewer
> woman
> error: More than one value for the key man.viewer: konqueror
> error: More than one value for the key man.viewer: man
>=20
> so I guess this can work only in C.

$ git config --get-all man.viewer=20

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git


