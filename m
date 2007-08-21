From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: Multiple branches and git-svn
Date: Tue, 21 Aug 2007 12:06:36 +0200
Message-ID: <9FD13095-36B5-4663-B658-082981B1ACD9@lrde.epita.fr>
References: <864pj16r10.fsf@lola.quinscape.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-11--1069800920"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Aug 21 12:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INQdh-00051W-C6
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 12:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbXHUKGj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 06:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754602AbXHUKGj
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 06:06:39 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:52811 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239AbXHUKGi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 06:06:38 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA:16)
	(Exim 4.50)
	id 1INQdB-0001hP-6T; Tue, 21 Aug 2007 12:06:37 +0200
In-Reply-To: <864pj16r10.fsf@lola.quinscape.zz>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56288>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-11--1069800920
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Aug 15, 2007, at 12:17 PM, David Kastrup wrote:

>
> After having had several embarrassing occurences with git-svn dcommit,
> I think it would not be amiss to mention in the docs just how git-svn
> happens to figure out which Subversion remote it is associated with.
>
> One surprising relevation was that this association changed after a
> git-rebase.
>
> It may be a general git thing, or it may be git-svn specific, but it
> was not exactly what I expected.  And the docs were not really that
> helpful.
>
> In particular, man git-svn is completely silent about this.
>

What I do usually is that I look in git log until I see a git-svn-id  
line:
git-svn-id: https://svn.foo.com/svn/project/branches/bar@<rev-SVN>  
<Repository UUID>
AFAIK git-svn dcommit will commit in the branch specified in the last  
git-svn-id.  I also dcommitted in the wrong branch after a rebase  
because I imported commits from another branch and the topmost commit  
in git-log was "pointing to" a different branch.

I hope this helps.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-11--1069800920
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGyrkswwE67wC8PUkRAlciAKDLYowmg5U9kgw0B9GttizONRScUQCfa1rA
jb4VaasFuLQqpOBgu+JStDg=
=DStc
-----END PGP SIGNATURE-----

--Apple-Mail-11--1069800920--
