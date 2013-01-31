From: Konstantin Ryabitsev <mricon@kernel.org>
Subject: Re: "git archve --format=tar" output changed from 1.8.1 to 1.8.2.1
Date: Thu, 31 Jan 2013 12:52:15 -0500
Organization: Linux Foundation/Kernel.org
Message-ID: <510AAF4F.6060201@kernel.org>
References: <20130131172805.GC16593@kroah.com> <7vzjzpgswz.fsf@alter.siamese.dyndns.org> <20130131174103.GA20111@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2VMFJDISPHJUOKJRECLFN"
Cc: Junio C Hamano <gitster@pobox.com>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 18:52:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0yJZ-0001Ze-6l
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 18:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab3AaRwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 12:52:24 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:58826 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab3AaRwW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 12:52:22 -0500
Received: by mail-ie0-f169.google.com with SMTP id 13so628544iea.0
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 09:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type;
        bh=JhISylK9NG06K/SHhMOoTUzhKkkWjTWuO37TY2sz7Fg=;
        b=ZuVPZ6zrww11fi1sxerPcHaqYpf2EbNkPISYR7sv2d9LLgUwOX33BjlEuprGg1ZAnT
         2m0Qqq7qlFlwjiYQ7b2SPX6iVNAueTI0kLXHtDmBpscSuf5ubnCUL/7moQzqvXBuuag/
         5bryCV4tkM1A3ailD7oHv3kkFecQaDorKLCO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:x-gm-message-state;
        bh=JhISylK9NG06K/SHhMOoTUzhKkkWjTWuO37TY2sz7Fg=;
        b=BuyhI+efdtM8gk/hfDuWRmSHHa99532IQeDuoa46PFdSlQM+ljEZauYsp3ob4JzhX3
         VIbnpkGruC5sTFBAnLstfhiwVBwsi2mtzJ9RSzPNIr/A2ojxT3DBDLcaSQxeQvCZRjoz
         1DVXopUXJqXd4FBFHq2qcCAdXAJbTyKIfHEl8Ur4ko3KHvWaDrr1n77opghWUFAK0P1c
         vvbrcsgrT5VjEDFjnguACkjMMmasrhvIuiCGFOLBCwE/oJ8MoaqKjT+AeS7SBoTR6KiR
         nrX2hIDEiGlHm+XWlzXDvpPEKaOfFnZMNs1Udc+MXGDNg0cRXqnhF5dUwFx9mwnMh6r9
         TRAQ==
X-Received: by 10.50.57.133 with SMTP id i5mr1870988igq.67.1359654742054;
        Thu, 31 Jan 2013 09:52:22 -0800 (PST)
Received: from nikko.mricon.com (24-212-241-94.cable.teksavvy.com. [24.212.241.94])
        by mx.google.com with ESMTPS id c3sm3082773igj.1.2013.01.31.09.52.20
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 09:52:21 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <20130131174103.GA20111@kroah.com>
X-Enigmail-Version: 1.5.0
X-Gm-Message-State: ALoCoQkCi3M1IwBpsJ1ScjNc2PH4LCpNSUXbRLrVkE0h4uFuHVlFsNN0JdvAzJY3bZSZvV/+GB0r
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215134>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2VMFJDISPHJUOKJRECLFN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 31/01/13 12:41 PM, Greg KH wrote:
> Ugh, uploading a 431Mb file, over a flaky wireless connection (I end up=

> doing lots of kernel releases while traveling), would be a horrible
> change.  I'd rather just keep using the same older version of git that
> kernel.org is running instead.

Well, we do accept compressed archives, so you would be uploading about
80MB instead of 431MB, but that would still be a problem for anyone
releasing large tarballs over unreliable connections. I know you
routinely do 2-3 releases at once, so that would still mean uploading
120-180MB.

I don't have immediate statistics on how many people release using "kup
--tar", but I know that at least you and Linus rely on that exclusively.


Regards,
--=20
Konstantin Ryabitsev
Systems Administrator
Linux Foundation, kernel.org
Montr=C3=A9al, Qu=C3=A9bec


------enig2VMFJDISPHJUOKJRECLFN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQGcBAEBAgAGBQJRCq9PAAoJEI6WedmufElei0AL/22r8Y567SJYY70v0ZKlI2cI
PzK17V/k+6ono3yoUbKKlv4zOdi89d9W3oxhuAtaMauyfnXzRxXSIH1Bbe9EG5OD
VPDrKIsb9x2VLkS/43+N+0diPRuPQnM2R2UkqgW7N7vLRw4uDAXdypr3VmZ8QV1a
xD8EJpnRlaPndy8iTDLznxWnSSs6XPF1fiEd6vOqzCtoDKanrFS/rF/9zeNhzP7V
YEIDIgho7Tr1DufXFj/2LEI5XB8xvYkuxts3+8gtviDYBCLiUGd6uGGFHzWBHg4a
EAF0M71zHNbomFicUwTjAfRMkkfW7MSTt6K2IlSGeghhGdrDeuJldbhtmDWuirCK
bm31nawI6aKEoSAKtPrcmEVlHywGNKvD0dZGWwbbNtiF8kF+y0w3dOrtH1b7kun0
tpobktZTchzIazaVAg74L1+jXf1xx5PyXcCkssKCIzrFCEMaf3jxV0eyyODw0hqZ
ON8xgwQgrnAcphl5I1nbUiqU7ahMMNEUZKhjISoWmw==
=htSR
-----END PGP SIGNATURE-----

------enig2VMFJDISPHJUOKJRECLFN--
