From: =?UTF-8?B?IkwuIEFsYmVydG8gR2ltw6luZXoi?= 
	<agimenez-git@sysvalve.homelinux.net>
Subject: Re: wishlist: git send-email improvement
Date: Tue, 09 Mar 2010 20:30:53 +0100
Message-ID: <4B96A1ED.3020809@sysvalve.homelinux.net>
References: <1268155306.4277.14.camel@localhost>	 <7veijtz9kn.fsf@alter.siamese.dyndns.org>	 <1268156947.4277.26.camel@localhost> <1268157314.4277.30.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yann Droneaud <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Tue Mar 09 20:38:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np5G5-0007AD-PK
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 20:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab0CITiV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Mar 2010 14:38:21 -0500
Received: from capside.net ([81.19.98.74]:51521 "EHLO eul0600410.eu.verio.net"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751785Ab0CITiT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 14:38:19 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2010 14:38:18 EST
Received: (qmail 878 invoked by uid 89); 9 Mar 2010 19:30:55 -0000
Received: from 152.Red-88-2-254.staticIP.rima-tde.net (HELO [192.168.1.30]) (88.2.254.152)
  (smtp-auth username lagimenez@capside.com, mechanism cram-md5)
  by eul0600410.eu.verio.net (NEVRiON/smtpd) with (AES256-SHA encrypted) ESMTPSA; Tue, 09 Mar 2010 20:30:55 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090706)
In-Reply-To: <1268157314.4277.30.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141844>

On 03/09/2010 06:55 PM, Yann Droneaud wrote:
> Le mardi 09 mars 2010 =C3=A0 18:49 +0100, Yann Droneaud a =C3=A9crit =
:
>> Perhaps I should learn to use git send-email --from instead.
>=20
> Sadly, it appends the From: field extracted from file to the Cc: list=
 :/
>=20
> So I still have to manually fix the mbox file before using git
> send-email.

Hi,

Have you tried --suppress-from?

--[no-]suppress-from
           If this is set, do not add the From: address to the cc: list=
=2E
Default is the value of sendemail.suppressfrom configuration value; if
that is
           unspecified, default to --no-suppress-from.

I'm not sure if it's what you need, but it seems to be.


Best regards,
--=20
L. Alberto Gim=C3=A9nez
GnuPG key ID 0x3BAABDE1

--=20
L. Alberto Gim=C3=A9nez
GnuPG key ID 0x3BAABDE1
