From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: git doesn't like big files when pushing
Date: Thu, 02 Mar 2006 13:43:06 +0100
Message-ID: <4406E85A.9030908@hogyros.de>
References: <20060301220802.GA18250@kroah.com> <Pine.LNX.4.64.0603011448230.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5F3E60271DBB6C461B18B6BE"
Cc: Greg KH <greg@kroah.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 13:43:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEn9Z-0004aC-Ma
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 13:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWCBMna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 07:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWCBMna
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 07:43:30 -0500
Received: from kleinhenz.com ([213.239.205.196]:11749 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S1751433AbWCBMna (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 07:43:30 -0500
Received: from [192.168.115.35] (p54994AEF.dip.t-dialin.net [84.153.74.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Simon Richter", Issuer "Kleinhenz Elektronik CA" (verified OK))
	by kleinhenz.com (Postfix) with ESMTP id AB2954A8045;
	Thu,  2 Mar 2006 13:43:14 +0100 (CET)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603011448230.22647@g5.osdl.org>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=http://www.hogyros.de/simon.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17065>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5F3E60271DBB6C461B18B6BE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Linus Torvalds wrote:

> But maybe it's really the case that you can't fit those 8 objects in 
> memory. One option (which might also solve some of the performance issues) 
> is to make the window be based on object _size_ rather than just be a 
> fixed number (ie with an 80MB object, you'd only try a couple of objects 
> around it, not the full window).

Well, doesn't the pack process involve keeping objects of similar size 
in memory next to each other? My suspicion is that the system is running 
out of virtual address space because almost every malloc() will attempt 
to get an entirely new block because the one that was just freed is a 
few bytes too small.

    Simon

--------------enig5F3E60271DBB6C461B18B6BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBRAboXVYr4CN7gCINAQL4WQP/SK/OrRW32f4lD4xIiLtUTS10rRbjjZdz
hGbXGzzEKezuj9oT+sG5MLm1UxP7m0Gef+PMvfQIVGiKDuhSjG+ZkPUKBLfM4QGZ
CMSoasmY7C6cCMi+kP1soCCqGR5eKHhM0Z23B9r/FOEakKqN7Hf78a9SESboUxoG
+DOT2NqL/RA=
=hYV1
-----END PGP SIGNATURE-----

--------------enig5F3E60271DBB6C461B18B6BE--
