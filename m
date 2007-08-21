From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: Multiple branches and git-svn
Date: Tue, 21 Aug 2007 19:51:05 +0200
Message-ID: <883671F6-F11C-4962-8BEE-763267DA9FEE@lrde.epita.fr>
References: <864pj16r10.fsf@lola.quinscape.zz> <9FD13095-36B5-4663-B658-082981B1ACD9@lrde.epita.fr> <861wdxgncz.fsf@lola.quinscape.zz> <20070821115611.GA21410@mimvista.com> <20070821151243.GA29020@artemis.corp>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-16--1041932043"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Aug 21 19:51:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INXsm-0002Iz-CT
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 19:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761355AbXHURvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 13:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761347AbXHURvH
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 13:51:07 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:33389 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757755AbXHURvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 13:51:06 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.50)
	id 1INXsf-0006Hz-8w; Tue, 21 Aug 2007 19:51:05 +0200
In-Reply-To: <20070821151243.GA29020@artemis.corp>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56315>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-16--1041932043
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Aug 21, 2007, at 5:12 PM, Pierre Habouzit wrote:

> On Tue, Aug 21, 2007 at 11:56:11AM +0000, David Watson wrote:
>> Now, I'm not sure this is 100% the fault of git-svn. Perhaps  
>> keeping its
>> metadata about which SVN branch it's connected to isn't the best  
>> thing, but
>> git-merge is doing exactly what you ask for. Perhaps we need a  
>> merge command in
>> git-svn that does the right thing? Although what that right thing  
>> would be, I'm
>> not quite sure.  Either way, there needs to be a BIG GIGANTIC  
>> WARNING in the
>> git-svn manual that if you actually use git for what it claims to  
>> be great at
>> (i.e., merging) you may be in for a world of pain, with your  
>> coworkers and boss
>> coming at you with pitchforks and torches. Especially because  
>> there are
>> so many git users who need to interoperate with SVN.
>
>   IMHO here is what git-svn should do. It should use the not-so-new
> remotes mechanism, and have all the svn remotes branches under a  
> remote
> namespace, clean, simple, and also knowing which "upstream" svn  
> "thing"
> it's following.

Isn't what git-svn already does if you git-svn clone with `-T trunk - 
b branches -t tags'?  At least in my git-svn repositories I do see  
the SVN branches as remote branches with `git branch -r'

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-16--1041932043
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGyyYJwwE67wC8PUkRAg2dAJ9b4bu8hCDpyvBSr5JVfJfkzIM7yQCgtXpM
e10tQePzjcYfblN0D0f40C0=
=AItu
-----END PGP SIGNATURE-----

--Apple-Mail-16--1041932043--
