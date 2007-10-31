From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: How to remove a specific hunk
Date: Wed, 31 Oct 2007 11:10:34 +0100
Message-ID: <13D08D3F-3647-4E20-AF80-8EC6FD14E66A@lrde.epita.fr>
References: <4722036E.5030204@wanadoo.fr> <20071026192034.GA3062@steel.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-34-769869878"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 11:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InAXM-0003ZT-Af
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 11:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080AbXJaKKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 06:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753819AbXJaKKo
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 06:10:44 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:55889 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757964AbXJaKKn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 06:10:43 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1InAX3-0002OK-5o; Wed, 31 Oct 2007 11:10:41 +0100
In-Reply-To: <20071026192034.GA3062@steel.home>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-34-769869878
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 26, 2007, at 9:20 PM, Alex Riesen wrote:

> Pascal Obry, Fri, Oct 26, 2007 17:10:38 +0200:
>>
>> I'm very new to Git... but start to love it :)
>>
>> Before committing sometimes I want to remove a specific hunk. Say in
>> file a.txt I have in the diff 3 hunks, I want to revert/delete/remove
>> the second one. Is there a way to do that ?
>
> Take a look at git-gui. Try right-clicking in the diff pane at the
> bottom.

This only allows you to stage a given hunk, not to remove one.  Right  
now I'm in a situation where I need to remove a specific hunk to  
compile and it's sad that git-gui doesn't provide an option so that  
you can right-click -> revert hunk.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-34-769869878
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHKFSbwwE67wC8PUkRAreFAJ9eiM1fMUEYiRsK8tha5wsXxliHWwCfQbZH
WpjHFoRR+kFAYoTufu4MwsI=
=uHuh
-----END PGP SIGNATURE-----

--Apple-Mail-34-769869878--
