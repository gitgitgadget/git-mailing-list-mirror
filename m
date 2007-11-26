From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: Rebase/cherry-picking idea
Date: Mon, 26 Nov 2007 10:32:38 +0100
Message-ID: <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-31-866510145"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 10:33:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwaKz-00027Y-5S
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 10:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbXKZJcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 04:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753830AbXKZJcu
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 04:32:50 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:50400 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbXKZJct (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 04:32:49 -0500
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IwaKe-0003sm-40; Mon, 26 Nov 2007 10:32:48 +0100
In-Reply-To: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66061>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-31-866510145
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 26, 2007, at 10:02 AM, Wincent Colaiuta wrote:

> In using "git-rebase --interactive" to re-order commits you  
> occasionally get conflicts and will see a message like this:
>
> 	When commiting, use the option '-c %s' to retain authorship and  
> message
>
> I was thinking that it might be nice to stash away this commit id  
> somewhere in GIT_DIR so that the user didn't have to explicitly  
> remember it, and add a new switch to git-commit that could be used  
> to automatically use that stashed commit id, something like:
>
> 	git commit --retain
>
> Although I most often see this kind of message in interactive  
> rebasing, the message is generated in builtin-revert.c when cherry- 
> picking, so you can also see it in any other situation where you're  
> cherry picking and there's a conflict.
>
> What do people think? Would this be a nice usability improvement?  
> Or is it adding clutter?


I'm not sure but I think this message is just some unwanted  
(misleading) noise, since when you rebase, once you solve the  
conflicts, you git-rebase --continue, you don't git-commit.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-31-866510145
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHSpK2wwE67wC8PUkRAoyTAKDARgRqa7BPNOaeVSZ/K0XrVCCbnQCgnwD+
j+y6deKSLMUR+kcCNMVUv9c=
=LnJb
-----END PGP SIGNATURE-----

--Apple-Mail-31-866510145--
