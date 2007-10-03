From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: Linking with -R (rpath) not supported on Darwin
Date: Thu, 4 Oct 2007 00:58:33 +0200
Message-ID: <3BF85D94-84E2-4D56-82FC-E8108E28468D@lrde.epita.fr>
References: <4D954ADB-E66E-43CA-87EE-7522FFA87370@lrde.epita.fr> <ECAD7CED-FFA0-46F2-8094-2FDE47CB5D54@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-79-544232993"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 00:59:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdDBT-000680-KH
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 00:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbXJCW7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 18:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbXJCW7H
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 18:59:07 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:37170 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbXJCW7F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 18:59:05 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IdDBF-00023d-Mj; Thu, 04 Oct 2007 00:59:01 +0200
In-Reply-To: <ECAD7CED-FFA0-46F2-8094-2FDE47CB5D54@silverinsanity.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59904>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-79-544232993
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 4, 2007, at 12:39 AM, Brian Gernhardt wrote:

> On Oct 3, 2007, at 5:34 PM, Benoit SIGOURE wrote:
>
>> Hello,
>> I've just compiled HEAD (1.5.3.4.209.g9e417) and saw a:
>>     LINK git-http-fetch
>> i686-apple-darwin8-gcc-4.0.1: unrecognized option '-R/opt/local/lib'
>>
>> It didn't harm but the build process should be more careful to not  
>> use options that are not supported by the compiler.  And it's not  
>> a matter of using -Wl,-rpath instead.
>
> I compile git very regularly on my MacBook Pro and have never seen  
> this error.  Do you have the most recent copy of Xcode?  I've seen  
> odd errors on one of the not very old versions of the developer's  
> tools.  For me, `gcc -v` reports "gcc version 4.0.1 (Apple  
> Computer, Inc. build 5367)".
>
> ~~ Brian

$ gcc -v
[...]
gcc version 4.0.1 (Apple Computer, Inc. build 5367)

I've seen this message for the 1st time when compiling Git after my  
nightly git pull today.  Anyways, this should be done because there  
is no point in trying to use a feature that doesn't exist, even  
though GCC is being nice by simply issuing a warning instead of an  
error.

See:
http://developer.apple.com/releasenotes/DeveloperTools/RN-dyld/ 
index.html

In the section "Known Issues" it clearly states "No rpath support".

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-79-544232993
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHBB6awwE67wC8PUkRAvxoAJ0UDyZYzIo5c7/BS0aJSadNN0lFKACgzZcJ
V8NnqOXKEUe01zQs9Bnjd7k=
=Insv
-----END PGP SIGNATURE-----

--Apple-Mail-79-544232993--
