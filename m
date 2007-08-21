From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: Multiple branches and git-svn
Date: Tue, 21 Aug 2007 19:55:01 +0200
Message-ID: <09C6E878-619D-458E-8076-4304C20D5A52@lrde.epita.fr>
References: <864pj16r10.fsf@lola.quinscape.zz> <9FD13095-36B5-4663-B658-082981B1ACD9@lrde.epita.fr> <861wdxgncz.fsf@lola.quinscape.zz> <20070821115611.GA21410@mimvista.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-17--1041696213"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Watson <dwatson@mimvista.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 19:55:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INXwa-0003xD-QW
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 19:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760494AbXHURzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 13:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760160AbXHURzF
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 13:55:05 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:33482 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758555AbXHURzD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 13:55:03 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.50)
	id 1INXwS-0007Ac-Ur; Tue, 21 Aug 2007 19:55:01 +0200
In-Reply-To: <20070821115611.GA21410@mimvista.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56317>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-17--1041696213
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Aug 21, 2007, at 1:56 PM, David Watson wrote:

> Yes, that's quite true. It took me quite a while to figure that out  
> when I
> first started using git-svn, and its non-sensicalness nearly put me  
> off using
> git entirely. My workflow at this point is to use git-cherry-pick - 
> e to pull in
> any changes from other branches, then delete the git-svn-id line.
>
> Essentially, merging using git-svn is almost entirely broken, since an
> inconsistent tool is worthless - you spend more time figuring out  
> if it's going
> to break, and working around the breakage, than you save using it.

To me this sounds exaggerated, I fell in the pitfall once after a git- 
rebase but never had the problem again since then.

>
> Now, I'm not sure this is 100% the fault of git-svn. Perhaps  
> keeping its
> metadata about which SVN branch it's connected to isn't the best  
> thing, but
> git-merge is doing exactly what you ask for. Perhaps we need a  
> merge command in
> git-svn that does the right thing? Although what that right thing  
> would be, I'm
> not quite sure.  Either way, there needs to be a BIG GIGANTIC  
> WARNING in the
> git-svn manual that if you actually use git for what it claims to  
> be great at
> (i.e., merging) you may be in for a world of pain, with your  
> coworkers and boss
> coming at you with pitchforks and torches. Especially because there  
> are
> so many git users who need to interoperate with SVN.
>

IMO the only think that git-svn dcommit needs is an option to specify  
to which SVN branch you want to commit in case you want your commit  
to go in another branch than that specified in the last git-svn-id line.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-17--1041696213
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGyyb1wwE67wC8PUkRAj7RAJ9/p2aHvGWxFDuuoZ8YdNseJsxFbQCeOy+Z
xli2YFwkCy2KIhGAknMPOYQ=
=lwEr
-----END PGP SIGNATURE-----

--Apple-Mail-17--1041696213--
