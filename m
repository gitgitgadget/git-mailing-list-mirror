From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] Mac OS X 10.5 does not require the OLD_ICONV flag set
Date: Fri, 2 Nov 2007 10:39:35 +0100
Message-ID: <B858412A-853A-4660-BA4B-F9751E4AAEAE@lrde.epita.fr>
References: <1193971102-61907-1-git-send-email-blaker@gmail.com> <7v4pg55893.fsf@gitster.siamese.dyndns.org> <20071102093028.GA29699@glandium.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-52-940811109"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 10:40:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Int0W-0003O8-7z
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 10:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbXKBJju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 05:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbXKBJjt
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 05:39:49 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:53834 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbXKBJjt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 05:39:49 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Int0C-0003te-VH; Fri, 02 Nov 2007 10:39:45 +0100
In-Reply-To: <20071102093028.GA29699@glandium.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63088>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-52-940811109
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 2, 2007, at 10:30 AM, Mike Hommey wrote:

> On Fri, Nov 02, 2007 at 02:03:52AM -0700, Junio C Hamano  
> <gitster@pobox.com> wrote:
>> Blake Ramsdell <blaker@gmail.com> writes:
>>
>>> Signed-off-by: Blake Ramsdell <blaker@gmail.com>
>>> ---
>>>  Makefile |    4 +++-
>>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 71479a2..5d83756 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -401,7 +401,9 @@ endif
>>>  ifeq ($(uname_S),Darwin)
>>>  	NEEDS_SSL_WITH_CRYPTO = YesPlease
>>>  	NEEDS_LIBICONV = YesPlease
>>> -	OLD_ICONV = UnfortunatelyYes
>>> +	ifneq ($(uname_R),9.0.0)
>>> +		OLD_ICONV = UnfortunatelyYes
>>> +	endif
>>>  	NO_STRLCPY = YesPlease
>>>  	NO_MEMMEM = YesPlease
>>>  endif
>>
>> I do not have an access to a Darwin box, but do you mean 10.5
>> gives 9.0.0 as uname_R?
>
> Be it that or not, it looks wrong to me to check the Darwin version to
> know what to use. Do you rely on the Linux kernel version to know  
> whether
> iconv is present ?

It's very different, on OSX you don't change your own kernel as you  
want, the kernel isn't a standalone component, it comes packaged with  
the entire system of MacOSX.  When you do an update to 10.5 (aka  
Leopard) you will have a new version of iconv so you're guaranteed  
that someone with 10.5 has a system-wide iconv that is not OLD_ICONV.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-52-940811109
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHKvBXwwE67wC8PUkRAsCEAJ9ksAaAPCfUHytaltg69MFrTo2ExQCeJfsy
av+t+U91JTQnJPe5kdDiANs=
=ra8w
-----END PGP SIGNATURE-----

--Apple-Mail-52-940811109--
