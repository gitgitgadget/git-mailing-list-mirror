From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: Performance issue with excludes (was: Re: git-svn and submodules)
Date: Mon, 15 Oct 2007 19:38:12 +0200
Message-ID: <DF6FA0BD-C227-4F62-82D8-F4873CC52B5A@lrde.epita.fr>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp> <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma> <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled> <Pine.LNX.4.64.0710142359020.25221@racer.site> <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr> <alpine.LFD.0.999.0710150848380.6887@woody.linux-foundation.org> <C7EA8AD7-BACA-4116-9C6B-90BA23F0005C@lrde.epita.fr> <alpine.LFD.0.999.0710150928450.6887@woody.linux-foundation.org> <45410184-8D7D-47ED-AB10-1A4E52D0ADB0@lrde.epita.fr> <alpine.LFD.0.999.0710151009460.6887@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-14--585671866"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 20:44:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhTuI-0004Ai-BA
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 19:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676AbXJORiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 13:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757537AbXJORiv
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 13:38:51 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:53406 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757478AbXJORiu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 13:38:50 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IhTtw-0005He-IT; Mon, 15 Oct 2007 19:38:48 +0200
In-Reply-To: <alpine.LFD.0.999.0710151009460.6887@woody.linux-foundation.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61018>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-14--585671866
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 15, 2007, at 7:10 PM, Linus Torvalds wrote:

> On Mon, 15 Oct 2007, Benoit SIGOURE wrote:
>>
>> There is no .gitignore, only .git/info/exclude.
>
> They do exactly the same thing (apart from the nesting nature of
> .gitignore wrt subdirectories), so that doesn't change anything.

I fail to see how the mechanism work then.  You said that I needed to  
add the .gitignore before adding all the other bummer stuff, fair  
enough.  AFAIK .git/info/exclude doesn't need to be added, it's just  
there.  But you can try to change the test, add the .git/info/exclude  
*first* and then make a commit and then add all the bummer stuff and  
then commit, and finally, do a git-status, for me it still takes 9s.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-14--585671866
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHE6WEwwE67wC8PUkRAgrXAKCDpYpobNHcOqz+k2f5aXazbPyvvwCdGvZM
VPpxSFCiVCh7e4JIAH5lgxE=
=awIJ
-----END PGP SIGNATURE-----

--Apple-Mail-14--585671866--
