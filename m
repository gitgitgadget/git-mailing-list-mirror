From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: Performance issue with excludes (was: Re: git-svn and submodules)
Date: Mon, 15 Oct 2007 18:51:27 +0200
Message-ID: <45410184-8D7D-47ED-AB10-1A4E52D0ADB0@lrde.epita.fr>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp> <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma> <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled> <Pine.LNX.4.64.0710142359020.25221@racer.site> <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr> <alpine.LFD.0.999.0710150848380.6887@woody.linux-foundation.org> <C7EA8AD7-BACA-4116-9C6B-90BA23F0005C@lrde.epita.fr> <alpine.LFD.0.999.0710150928450.6887@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-9--588476712"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 18:54:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhTAy-0002aG-6n
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 18:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759267AbXJOQwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 12:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757304AbXJOQwI
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 12:52:08 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:55557 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757495AbXJOQwH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 12:52:07 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IhTAk-0003QO-02; Mon, 15 Oct 2007 18:52:06 +0200
In-Reply-To: <alpine.LFD.0.999.0710150928450.6887@woody.linux-foundation.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61011>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-9--588476712
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 15, 2007, at 6:34 PM, Linus Torvalds wrote:

> On Mon, 15 Oct 2007, Benoit SIGOURE wrote:
>>
>> I re-used the test that was posted some time ago:
>
> I think your test is scrogged. You should add the ".gitignore" file
> *before* you do the "git add .". That's when it's going to hurt (since
> that's when you have new files you don't yet know about).
>
> But then it should hurt only for the "git add ." phase, not for  
> anything
> else (unless we have the performance bug of doing the ignore  
> matching even
> on files we know about). And more importantly, it should hurt only  
> once
> (since afterwards, we'll know about the files and know not to ignore
> them).

There is no .gitignore, only .git/info/exclude.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-9--588476712
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHE5qQwwE67wC8PUkRAhb2AKDH/xVGxdqm3n/osWb07p3hbZUmmgCeO7eR
T2rF1vmUEe0dCmA5m6nXuy8=
=/YnS
-----END PGP SIGNATURE-----

--Apple-Mail-9--588476712--
