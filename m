From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git reset
	--hard"
Date: Fri, 12 Sep 2008 01:39:41 +0200
Message-ID: <20080911233941.GP4829@genesis.frugalware.org>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com> <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com> <279b37b20809101946k309ad113neb7d051f1c6c410e@mail.gmail.com> <eafc0afe0809102305u6de85ef3ib2c08004dea8d6f9@mail.gmail.com> <51419b2c0809110932r4e8c833fx740ccb0c8e46f0af@mail.gmail.com> <3ab397d0809111022m24c81bd9y2520f6be478babd3@mail.gmail.com> <279b37b20809111424y73a3f6b9xe7f5019b9ba0da16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T/5gogCFEf4tDWvL"
Cc: Jeff Whiteside <jeff.m.whiteside@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Changsheng Jiang <jiangzuoyan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 01:40:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdvmM-0001H3-Bq
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 01:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbYIKXjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 19:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754811AbYIKXjn
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 19:39:43 -0400
Received: from virgo.iok.hu ([193.202.89.103]:54593 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213AbYIKXjn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 19:39:43 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C2D331B254B;
	Fri, 12 Sep 2008 01:39:41 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A5BB74465E;
	Fri, 12 Sep 2008 01:39:41 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8FD3311901A1; Fri, 12 Sep 2008 01:39:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <279b37b20809111424y73a3f6b9xe7f5019b9ba0da16@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95670>


--T/5gogCFEf4tDWvL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 11, 2008 at 02:24:51PM -0700, Eric Raible <raible@gmail.com> wrote:
> My question is why "git reset --hard" can't make a special case for
> _newly added_ tracked files.  After all, "git status" knows that they're
> "new files", and "git reset --hard" could realize that wiping them off
> the face of the earth isn't the most helpful thing possible.

I rarely need this, but I use 'git read-tree -m HEAD' before git reset
--hard in case I want such a behaviour.

--T/5gogCFEf4tDWvL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjJrD0ACgkQe81tAgORUJbB3QCglBDvkXDqLmeoqJWdg+Re6gri
B3sAn3nL1oGks3Ky8WZRF72xKESb4ehl
=Bf1n
-----END PGP SIGNATURE-----

--T/5gogCFEf4tDWvL--
