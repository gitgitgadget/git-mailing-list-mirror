From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Fri, 1 Jun 2007 23:08:36 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200706012308.41335.ismail@pardus.org.tr>
References: <200704241705.19661.ismail@pardus.org.tr> <200706012247.57273.ismail@pardus.org.tr> <7vbqfzzbq8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2212351.UBinQqMRMC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 22:08:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuDQH-0006Sn-GI
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 22:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762596AbXFAUI0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 16:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762851AbXFAUIZ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 16:08:25 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:53010 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762596AbXFAUIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 16:08:25 -0400
Received: from southpark.local (unknown [85.96.75.185])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 77D7E602143C;
	Fri,  1 Jun 2007 23:08:15 +0300 (EEST)
User-Agent: KMail/1.9.6 (enterprise 0.20070508.662491)
In-Reply-To: <7vbqfzzbq8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48881>

--nextPart2212351.UBinQqMRMC
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 01 June 2007 23:00:31 you wrote:
> Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:
> > On Friday 01 June 2007 22:44:36 Junio C Hamano wrote:
> >> Alexandre Julliard <julliard@winehq.org> writes:
> >> > Sorry for the late nack, but it turns out that this patch breaks diff
> >> > output on the Wine server for files that are not utf-8.
> >> >
> >> > The cause is apparently that decode_utf8() returns undef for invalid
> >> > sequences instead of substituting a replacement char like
> >> > decode("utf8") does.
> >>
> >> Thanks for noticing.  Will revert.
> >
> > Why are reverting a correct bugfix? :( He's at most using outdated
> > software. *sigh*
>
> I would assume that on top of a revert, with an additional
>
> 	return $str if is_utf8($str);
>
> to to_utf8() you should be able to fix both installations that
> has old or new Encode.pm?

I can try the patch if you can send me what you propose.=20

/ismail

=2D-=20
Perfect is the enemy of good

--nextPart2212351.UBinQqMRMC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4 (GNU/Linux)

iQIVAwUARmB8yUe9qviWcMsnAQL22xAAyD3wHp7OSD6SR3IDkFTEjckiOerEuamO
OmePZwV6JNKSHy9NPt1MJXME5QEe01x+a/U/oWCfhpnUR0w1k/+c++pvMWzzaPyN
OOeyQjsW9oBylEqR6wpUgSVzMi1ttXzLDS3bT1dti7Pub5mfvQpdiXc5ihtDAoJF
hQU3q2Gj9ERyVkTb5SWudnPnjfSYrCkuF3xcMC8PplPwYFnH3FjJKgGRk0nHjFqU
imcPz97QdM2XMbPB2SMzeOXlxmah9aoTI0dX8sCt1GfCk8Xn6X6+WV36NPvWEiWr
86ufYa6GrngoWJMzGnsqqqiv8BrGA9y0Zu1XEyrtOZUuxJNYbk5oRPFZYGZlnFo9
+H0oPzzs4AchEF7TmP1fw714alz1KZ3z1CZ17LsbV8j98OxVrtCXrPuW+HaLg/v4
0v+JLc5d733CC2Bo7UWpiUkGvb9XEcP1ju3IBrPc9WkSCXD4qxTvl23YgJu3DELi
Y6uSXkFtpRAuFYwqzYW5rvPkwkB5zlwt8g03/1qstcVjZ2+azD3n5rKzfqiMt3qi
uXIlJsB3N5wd7dufEZW2jxMnIlbqRpYAC/hhVaBWLYVHnlL3Qw3aDQpanWggZKYT
lPJj5IgxZMqWYvMdC3mZSbyxnXAAo/jw2YkQhlVZcKqk4LApIhyyX6K3fOls4Ycz
XBRAbzNRZbs=
=rMZ1
-----END PGP SIGNATURE-----

--nextPart2212351.UBinQqMRMC--
