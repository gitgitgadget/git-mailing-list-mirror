From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: is gitosis secure?
Date: Sun, 18 Jan 2009 08:19:11 -0600
Message-ID: <200901180819.11642.bss@iguanasuicide.net>
References: <200812090956.48613.thomas@koch.ro> <200901180650.06605.bss@iguanasuicide.net> <87skngoifj.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2352048.Kgx7GkkQTH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 15:20:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOYW1-00061L-V8
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 15:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761922AbZAROTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 09:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752825AbZAROTP
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 09:19:15 -0500
Received: from eastrmmtao104.cox.net ([68.230.240.46]:60708 "EHLO
	eastrmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761774AbZAROTO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 09:19:14 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090118141913.IWLG3752.eastrmmtao104.cox.net@eastrmimpo03.cox.net>;
          Sun, 18 Jan 2009 09:19:13 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id 52KC1b0012i4SyG022KC0x; Sun, 18 Jan 2009 09:19:12 -0500
X-Authority-Analysis: v=1.0 c=1 a=Fq1VQ0LPAAAA:8 a=9lUfmH7IU-mUekdLxe4A:9
 a=gRMj_-c_fHQ79ePMXdUA:7 a=G9AajokKSwpqJDzDdtnh8YoeWj0A:4 a=T3brmoaXcPoA:10
 a=LY0hPdMaydYA:10 a=QfQwK8wPLwLc4A3icFYA:9 a=pwEhibzAiqlyXY___yHtgOBpegAA:4
 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LOYUZ-000EtI-Ng; Sun, 18 Jan 2009 08:19:11 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <87skngoifj.fsf@mid.deneb.enyo.de>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106190>

--nextPart2352048.Kgx7GkkQTH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 18 January 2009, Florian Weimer <fw@deneb.enyo.de> wrote=20
about 'Re: is gitosis secure?':
>* Boyd Stephen Smith, Jr.:
>> On Sunday 18 January 2009, Florian Weimer <fw@deneb.enyo.de> wrote
>>
>> about 'Re: is gitosis secure?':
>>>* Sam Vilain:
>>>> Restricted unix shells are a technology which has been proven secure
>>>> for decades now.
>>>Huh?  Things like scponly and rssh had their share of bugs, so I can
>>>see that there is some concern.  (And restricted shells used to be
>>
>> From my understanding, a restricted shell is a difficult thing to
>> escape from unless a user is able to run binaries that they have
>> written.  FWIW, I don't remember sftp or scponly having this particular
>> vulnerability.
>
>scponly issues due to interpretation conflicts:

Not sure all these apply, but I beleive some of them do, and I want to=20
leave the CVE numbers in case someone wants to look them up.

>CVE-2002-1469
>CVE-2004-1162
>CVE-2005-4533
>CVE-2007-6350
>CVE-2007-6415
>CVE-2004-1161
=2D-- End of CVEs to investigate ---

>That's why I think it's not totally outlandish to assume that
>restricted shells are usually not very helpful for
>compartmentalization purposes.

I mostly agree with that statement.  I make the assumption that, if the=20
user can login via ssh (even under "only" a restricted shell) they can do=20
anything a user in the same groups can do.  I might be overestimating most=
=20
people, but I don't think I'm underestimating anyone.  I do *hope* that I=20
get local privilege escalations patched before they are exploited, but I=20
can't guarantee that.  (I'm not sure there's really anyway to guarantee=20
that, and I'd hate to upgrade a backup offline then replace the running=20
instance.  Especially if I had to go back to when the local privilege=20
escalation was introduced [not just when it was "discovered"].)
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart2352048.Kgx7GkkQTH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklzOl8ACgkQ55pqL7G1QFn96QCfYpQwwStk3w+cziq5nsh+h0Eu
DjEAn3JkJ7If61IirGAg3zOea6Funw3g
=XZfj
-----END PGP SIGNATURE-----

--nextPart2352048.Kgx7GkkQTH--
