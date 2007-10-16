From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: [PATCHv2 1/5] Add a generic tree traversal to fetch SVN properties.
Date: Tue, 16 Oct 2007 17:10:29 +0200
Message-ID: <0D1ADA80-223C-4143-BCEC-5275E0EAD357@lrde.epita.fr>
References: <1192545412-10929-1-git-send-email-tsuna@lrde.epita.fr> <4714D068.8090606@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-39--508135093"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 17:11:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iho4n-0006k9-6E
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 17:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932894AbXJPPLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 11:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbXJPPLI
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 11:11:08 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:53264 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932764AbXJPPLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 11:11:08 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Iho4Y-0002vE-D1; Tue, 16 Oct 2007 17:11:06 +0200
In-Reply-To: <4714D068.8090606@viscovery.net>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61189>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-39--508135093
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 16, 2007, at 4:53 PM, Johannes Sixt wrote:

> Benoit Sigoure schrieb:
>> 	* git-svn.perl (&traverse_ignore): Remove.
>> 	(&prop_walk): New.
>> 	(&cmd_show_ignore): Use prop_walk.
>
> This may be your favorite style of commit messaged, but I think the  
> concensus for git is a different style of commit message: We would  
> like to see *why* this change is good. But you only note *what* was  
> changed, something that can be seen by looking at the patch anyway.
>
> The commit message should be helpful when the commit is looked at  
> in isolation, like when you are doing some code archeology half a  
> year later and e.g. git-blame/git-bisect points you to this commit.
>
> Also a notice such as
>
>  "With this we will be able to lift properties like svn:ignore into
>   .gitignore in a follow-up change."
>
> tells that this was actually part of a series and you don't have to  
> remember that half a year ago there were 4 more patches submitted  
> in the same second with this one.

Indeed, sorry, I'll write more explanatory commit messages next time :)

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-39--508135093
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHFNRlwwE67wC8PUkRAt/QAKCIfPwJ8ujP08udNoo0Vwm67cY1XACfSozM
eTzLIocuphllbxh2PxDjaRA=
=D4qT
-----END PGP SIGNATURE-----

--Apple-Mail-39--508135093--
