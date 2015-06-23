From: Johannes =?utf-8?B?TMO2dGhiZXJn?= <johannes@kyriasis.com>
Subject: Re: Untracked files when git status executed on a new folder
Date: Tue, 23 Jun 2015 18:54:53 +0200
Message-ID: <20150623165453.GA9265@leeloo.kyriasis.com>
References: <1435072761.15867.38.camel@aliga.ieec.uab.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Cc: git@vger.kernel.org
To: =?utf-8?B?VsOtY3RvciBNYXJ0w61uIEhlcm7DoW5kZXo=?= 
	<vmartin@aliga.ieec.uab.es>
X-From: git-owner@vger.kernel.org Tue Jun 23 18:55:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7RTq-0002jZ-OB
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 18:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932924AbbFWQzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 12:55:23 -0400
Received: from theos.kyriasis.com ([212.71.254.33]:51725 "EHLO
	theos.kyriasis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbbFWQzV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 12:55:21 -0400
Received: from theos.kyriasis.com (localhost.localdomain [127.0.0.1]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTP id 54ccbb5b;
	Tue, 23 Jun 2015 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyriasis.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=theos; bh=xftAhIEHHCxvc2T4TtynQcVesEI=; b=VaDQLG
	ktNGG7SAk4+d7EujtGThFVglPKYcf1s0ZODZoO33/JmzyCYwTL7R+TZOFeqDz7QJ
	z2p+9en6uCfcPtyb8H5ELAP5yiPbJc/pFhc92smc5dXzGlkUYc6fxUHNd9gYaXez
	EMptrJCu/xEeMYMkDkV8eVG7AkSaTkrOOdXbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kyriasis.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=theos; b=N/2qIOAap1++UdH1OteJ+EteD6FXZYfs
	WNo1/tq2ucQgiQDgHFtcyptDH3tdrJ/4r0O2uAJ9QCmX7haWjExURn59y37EpkHu
	GvM2GIjRXVT92J1cO53xSFJAZq8SCCo4yJp5Zz2W7mSidR0RozHCXYBK6g+IfVfE
	cgvdntnvRuw=
Received: from leeloo.kyriasis.com (host-95-192-142-179.mobileonline.telia.com [95.192.142.179]);
	by theos.kyriasis.com (OpenSMTPD) with ESMTPSA id d3cd90b6;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Tue, 23 Jun 2015 16:55:17 +0000 (UTC)
Mail-Followup-To: =?utf-8?B?VsOtY3RvciBNYXJ0w61uIEhlcm7DoW5kZXo=?= <vmartin@aliga.ieec.uab.es>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1435072761.15867.38.camel@aliga.ieec.uab.es>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272460>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23/06, V=C3=ADctor Mart=C3=ADn Hern=C3=A1ndez wrote:
>Hi all.
>Today I've had an unexpected behaviour that I'm not sure if is a bug or
>I'm not doing git best practices... (surely the latest...)
>The sequence of actions is :
>
>1. create a new subfolder of my local repository branch
>2. cd to this new folder, and create a new file
>3. execute git status from the new folder
>
>Doing that, the new folder doesn't appear as untracked.
>
>4. cd ..
>5. git status
>In this case, the new folder appears.
>
>If I create a new folder on the same level that the new one created in
>step 1, cd into it, and execute git status, the folder created in step 1
>appears as untracked.
>

Can't reproduce on Git 2.4.4/Linux, which Git version and platform are=20
you using?

--=20
Sincerely,
  Johannes L=C3=B6thberg
  PGP Key ID: 0x50FB9B273A9D0BB5
  https://theos.kyriasis.com/~kyrias/

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQQcBAEBCgAGBQJViY9ZAAoJEJAcHDIOsNRdbu0f/1ZTRjchad7rTVepoc3TtVWm
FeFvp/k09jXoSA6/z5e7cuxEZTYupcVbDrTz0w9jw+tfGSgAxbNDRRhBriogxdsR
c+HzKl8jFht+t6XWHiBjv6VyMcInFo6y64qnQhQobZDHnGP6jEe+eGKO8xlulcV4
zZitUEEAFU/F+25ZbUMloEAv1Px2vHjTBGDWxbqDX780a+vz8Kml+m4alWnfI6n4
/6+HUBMx43/+kfH8Nd6LMmc4jq/+jSkY4X2cSMuKF1AC3Zl9KnzCZqUA7+I2/bC1
WTY4P2DiqAI9DvfaL5XkgPhCFSYZ1AHB065HgsxHW0MteLJknHWv5y6xk05t+eC3
syA7h64ajFtm95G/NnK9rl+02QakMvTK2lQF2wUZV5fmzi3pn2Ybvgfa5dEDMBF/
YGk01qbHb9SUJDRP/6nr5Na1S+HLKvMbDHbj7Ymf4mv5gGSpRPkXk3gGEC3J/mQ9
/yvlqsHoBN3R9xNyIo4g0A10cUdinJ97ZSilDobwql2KIp0Rj1rN+Lg6Ihjxw8Ur
fHerQpde0RsrMQ+EFHkaP8R6J6zhAbEu0oiV02hc8WVnSfGQVheumMgzX1bpf47O
DQwGu6Brqe8xCasNzJcJzQMw6AbGwl0rADcCFIuboCziX+i+4L+VjYSMd1zouJ7P
j7brb2I4wxh/LgqMaojqw3nKWR6iJi9lrUN3dHh72/gbKfEdI3QbVO29l5bRJ3NJ
auattAz4L4wIdyxjFZgszTCeZexNUhpaMCvnlH/v9ueF5mTS+qQpL5dKwTNVFxc6
ayqWCRPmEaNLMlyOOwD4aA+oc7hR3Q6sI0OpiQLVApg+bRMR/1HC6SxjHPHRhW7Y
tJEERZ73WwRBZgiBqBml2paP8zmRIpA3rOrtV1h3ScW+iN+OvISKv97YPYCt3zph
i0nV6S2XTv920EMLyPQ3abXiRsL703H2o7DFEd7eg6NR6cm5lA4HyskDPlibW7eH
nfodRFkMDQzOAynYaRKBVIU3S/62ekDRkjpPF5tMJ1q9OuIYUz70+esiz4ksA3OD
pt4TCnNEvI5cGOR1Q+uYCyp3BkfEa2TdZLxo/XbBTLt3Cjbh0zttR9Q+7Jw+kiVs
n6e5jURCbHfuKzCjWnlI9O0fsFjKq6NBD7QGrEP2Ve8cV9zKH11wo63GoUjCJS04
5Y0aS8/4+1sLY7xKIZdIAUIeQFFeXdzYbJpsBCyuS+giEQjBUpdIoMzXPQm21jUR
uxEC2AN46ZMs5trbqYsfAriLMdGarNOGGX3pnPlpZ36YSmdJE24eBH47BCw/f0E+
XkH8cDgXh1Zp9ZUEHEy3jjD9OXutidUxPaFWGduAU1JOjnaioEedTvi7J5XRw8w=
=QeeE
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
