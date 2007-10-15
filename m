From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: git-svn and submodules
Date: Mon, 15 Oct 2007 12:51:41 +0200
Message-ID: <83CC7B21-DF40-4725-9550-A09AAFF88673@lrde.epita.fr>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp> <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma> <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled> <Pine.LNX.4.64.0710142359020.25221@racer.site> <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr> <47133A40.20303@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-73--610063354"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 15 12:52:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhNYk-0006sp-IP
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 12:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758678AbXJOKwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 06:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758675AbXJOKwT
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 06:52:19 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:47870 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757068AbXJOKwS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 06:52:18 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IhNYX-00074J-CM; Mon, 15 Oct 2007 12:52:17 +0200
In-Reply-To: <47133A40.20303@op5.se>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60979>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-73--610063354
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 15, 2007, at 12:00 PM, Andreas Ericsson wrote:

> Benoit SIGOURE wrote:
>>   - git svn create-ignore (to create one .gitignore per directory  
>> from the svn:ignore properties.  This has the disadvantage of  
>> committing the .gitignore during the next dcommit, but when you  
>> import a repo with tons of ignores (>1000), using git svn show- 
>> ignore to build .git/info/exclude is *not* a good idea, because  
>> things like git-status will end up doing  >1000 fnmatch *per file*  
>> in the repo, which leads to git-status taking more than 4s on my  
>> Core2Duo 2Ghz 2G RAM)
>
> How spoiled we are. I just ran cvs status on a checkout of a repo  
> located
> on a server in the local network. It took 6 seconds to complete :P

Hehe, true, once you get used to the taste of Git, you'll never want  
to switch back to these disgusting SCMs.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-73--610063354
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHE0Y9wwE67wC8PUkRAqI1AKC+lyzXkHBV8BR6cn042Y4bDNnDXQCeIRUe
FSmaxHHNveNLwzPZQ68FVY8=
=Rojt
-----END PGP SIGNATURE-----

--Apple-Mail-73--610063354--
