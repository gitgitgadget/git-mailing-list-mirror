From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: How to remove a specific hunk
Date: Fri, 26 Oct 2007 19:03:49 +0200
Message-ID: <2669F76D-6FF2-4CCF-9337-639D84EE65E8@lrde.epita.fr>
References: <4722036E.5030204@wanadoo.fr> <472207AA.8030100@op5.se> <47220A05.4040705@wanadoo.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-7-362665073"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal.obry@wanadoo.fr>
X-From: git-owner@vger.kernel.org Fri Oct 26 19:04:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlSbY-0007dy-Oe
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 19:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217AbXJZRD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 13:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755186AbXJZRD4
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 13:03:56 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:50229 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529AbXJZRDz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 13:03:55 -0400
Received: from intranet.gostai.com ([88.191.59.152] helo=[192.168.0.51])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IlSbB-0003SL-Oz; Fri, 26 Oct 2007 19:03:53 +0200
In-Reply-To: <47220A05.4040705@wanadoo.fr>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62432>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-7-362665073
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Oct 26, 2007, at 5:38 PM, Pascal Obry wrote:

> Andreas,
>
>> Once you've added the other two hunks, they'll no longer show up in
>> git-diff, so you can do something like this:
>>
>> $ git-add -i; # add the other two hunks to commit
>> $ git-diff > middle-hunk.patch
>> $ git-apply -R middle-hunk.patch
>> test, test, test
>> $ git-apply middle-hunk.patch
>
> Thanks, this will clearly work. I was expecting something more
> integrated like a "git reset --interactive" or something like that :)

That'd be great!  :)

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-7-362665073
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHIh31wwE67wC8PUkRAj03AKCB3fX3yXV6xxfVeZRLO2d9p0m1XQCfRd+E
a1UCKVQJF5aKernJIUJMPno=
=+kLJ
-----END PGP SIGNATURE-----

--Apple-Mail-7-362665073--
