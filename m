From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCHv3] git-tag man: when to use lightweight or annotated tags
Date: Sat, 27 Jul 2013 13:45:21 +0200
Message-ID: <51F3B2D1.2040402@googlemail.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com> <51F13A8F.9040400@xiplink.com> <51F23706.5040009@gmail.com> <51F2375E.1080003@gmail.com> <51F28D08.8050507@xiplink.com> <51F2AFBA.4020602@gmail.com> <51F2B2CD.1030004@gmail.com> <20130726190602.GC29799@sigill.intra.peff.net> <51F3A358.5000807@gmail.com> <720060083F5C476A905C09146E7CD711@PhilipOakley>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF624FD2013034DA52846D69F"
Cc: Daniele Segato <daniele.segato@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Jul 27 13:45:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V32wP-0002Q6-3u
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 13:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538Ab3G0LpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 07:45:16 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:56353 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab3G0LpP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 07:45:15 -0400
Received: by mail-wi0-f173.google.com with SMTP id en1so1595760wid.0
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=xXIsTgXNMwEK1/iwJA3Esud/ikeX2kM5oarzenpgTvQ=;
        b=yIG/uv7dZHTMw4Y57tTB0ZE6/DDhkmXDt8K+XJLh40aoFLvjlfeMME8te/qUFoJY1b
         jqcfG7PE9nOIQuEyoAuqazzMG3Xv00TOpJCBYcQngUOoyQUsbAA9X9RcC0Iffkyzwqa4
         VdGB85sQQMd8Ga9fZv7voWD5cfH5fB1/3y+q0z8+V++uyAKi9Fjhu3Jg7YLTi5D5N8Sb
         tPFjpUD1vde/y5ETNsmYimhZpBAZQdqAQOZEz0Dcuu2gDWib3KA4DLDpDzW2nRn9Mh8Q
         3ApGVnDGYSPtMHa2pGVbU5upBVRxafjgArgWyDGKYajrzbFUQWc7YvCkzMF3P0l/Vw0H
         8BlQ==
X-Received: by 10.180.198.79 with SMTP id ja15mr1780512wic.36.1374925513977;
        Sat, 27 Jul 2013 04:45:13 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id ev19sm10219957wid.2.2013.07.27.04.45.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Jul 2013 04:45:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <720060083F5C476A905C09146E7CD711@PhilipOakley>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231237>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF624FD2013034DA52846D69F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/27/2013 01:26 PM, Philip Oakley wrote:

> Try 'git format-patch' and 'git send-email'. The format-patch man page
> even has a note about Thunderbird corruptions.
>=20
> Philip
>=20

Well I use Thunderbird as well for regular communication except for
sending patches.=20
The kernel documentation has also some words about Thunderbird
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docu=
mentation/email-clients.txt

Given so many steps, I also configured git send-email, which makes
sure that patches are uncorrupted.=20
For gmail add these lines to your ~/.gitconfig

[sendemail]
        from =3D Your Name <emailaddress@gmail.com>
        smtpserver =3D /usr/bin/msmtp
        smtpuser =3D emailaddress
        smtpencryption =3D tls
        chainreplyto =3D false
        confirm =3D auto

Then you'd need to have msmtp installed and have the following
in the file ~/.msmtprc

# Example for a user configuration file
# Set default values for all following accounts.
defaults
tls on
tls_trust_file /usr/share/ncat/ca-bundle.crt
logfile ~/.msmtp.log
# My email service
account gmail
host smtp.gmail.com
port 587
from emailaddress@gmail.com
auth on
user emailaddress@gmail.com
password mysecret
account default : gmail


I think it would also work without having git relying on msmtp by now,
but I'd be too lazy to change my existing working setup.

Stefan


--------------enigF624FD2013034DA52846D69F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR87LRAAoJEJQCPTzLflhqjaMP/AhWBdJo+uPFN7r1YEdExhaq
hPYcRj0uq6BVmx2y99SLureWfOPNRwHms6TOxIA9ZK8ArfAmFRQq7WH/shz/qmpI
Qqshj9Z4qHCjAK54gC91hswsiua8d9GxrblMDVkDt0b9/sJmVrvAe6Zh4LmcWMh0
yqFyIm9deFRNizmEuv60n9VWbCFGn3vH4edsM0e5uWjs6pXe0PtdTJpxEQEinekA
QwgleqPqm4Gd3f4L0TPEWJI2t5JrFL2uMF5ZDmwa+tTv2QjCUaneJDiyhMyZ9oG6
rI4In62cfjDGj8C7PsNYqR/DFPWq9AUEO9ZvbShaB4A6KvllcuKdsr3dxo5woOCL
UU7IVuLVowVTh+YgXUF7u3w5z8FZ1/uPSN9yRsbObZ9wucrlPefsBWzdLsr2T8Bb
0vEzBxObtu9FqvPc3Y9YA3Nr2nVQMm+y7Fz+uO6bR6Nvm3gNq1Dybvd/fNjOF1ob
E+vO7U0e1r97GQDM25xN5052iKJcJGzW0yvSgDj7gQo1d4CRmtx4ZFxDEksWgNUJ
r3nsj8WjBo4tMGiyR+UgREJD+Gaw9aLh7g27UAmkqU2qPfG4zDVzX/Ij7aurPYhy
qNlEXHebAFMvmTpIlzLqbI7X1EqRQ5zxSgSgyT/aZK0Qw4KYvvkG1yX0BiiVKI7b
C0jvmXpw0tDMKdvULS5p
=iQI3
-----END PGP SIGNATURE-----

--------------enigF624FD2013034DA52846D69F--
