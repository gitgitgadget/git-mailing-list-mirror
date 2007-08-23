From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: confused about preserved permissions
Date: Thu, 23 Aug 2007 09:48:23 +0200
Message-ID: <B38B8F2F-92B0-48F4-9093-54724FA862C2@lrde.epita.fr>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <6031FB22-648E-47DE-92EE-2E7255322C27@lrde.epita.fr> <7v8x83i5ma.fsf@gitster.siamese.dyndns.org> <20070823060052.GA25153@piper.oerlikon.madduck.net> <85mywiixtp.fsf@lola.goethe.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-29--905293478"
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 09:48:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO7Qe-0005SM-Tb
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 09:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344AbXHWHs3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 03:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755728AbXHWHs3
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 03:48:29 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:38076 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130AbXHWHs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 03:48:29 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.50)
	id 1IO7QZ-0001CQ-Dn; Thu, 23 Aug 2007 09:48:27 +0200
In-Reply-To: <85mywiixtp.fsf@lola.goethe.zz>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56466>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-29--905293478
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed


On Aug 23, 2007, at 8:12 AM, David Kastrup wrote:

> martin f krafft <madduck@madduck.net> writes:
>
>> also sprach Junio C Hamano <gitster@pobox.com> [2007.08.23.0009  
>> +0200]:
>>> We deliberately chose not to use that space, and this default is
>>> very unlikely to change.
>>
>> The downsides included change in SHA hash on mode change, as far as
>> I can remember. Anything else?
>
> The modes are recorded in patches and push/pull, so if you have
> several people working with different permissions/umasks, you get
> wagonloads of unnecessary patches and get your local permissions
> messed up by other contributors.
>
> For colloborative work, you _really_ don't want to have _personal_
> preferences distributed.
>
> Any patch offering to optionally track permissions must make very sure
> that it retains the possibility to have permissions in the directory
> policed to the values that are actually a property of the source files
> rather than the personal work environment.
>

Hmm yes, that's right.

Let's look at the problem from another point of view then: I want my  
*working tree* to be group readable even though my umask is 066.   
Would it be possible to add a local config option in the .git repo to  
tell git that it should create new file this way (exactly like  
core.sharedRepository but core.sharedWorkingCopy or whatever).

WDYT?

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-29--905293478
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGzTvHwwE67wC8PUkRAlLPAKCcCYnLYwyS3DvmDDeAhfoYkt5E3wCgvNNh
bgyhlvq/wRh78IINp+fIbo0=
=ivAT
-----END PGP SIGNATURE-----

--Apple-Mail-29--905293478--
