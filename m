From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH 2/3] git-p4: support exclude paths
Date: Fri, 15 Feb 2008 23:56:31 +0100
Message-ID: <200802152356.34841.simon@lst.de>
References: <48092.216.228.112.21.1199496008.squirrel@numba-tu.com> <47B1C102.7020400@thorn.ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1350657.SEFbmnx3bv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tommy Thorn <tommy-git@thorn.ws>
X-From: git-owner@vger.kernel.org Fri Feb 15 23:57:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ9Un-0004S9-Gr
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 23:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765547AbYBOW4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 17:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765792AbYBOW4n
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 17:56:43 -0500
Received: from hoat.troll.no ([62.70.27.150]:40440 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765547AbYBOW4h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 17:56:37 -0500
Received: from localhost (localhost [127.0.0.1])
	by hoat.troll.no (Postfix) with ESMTP id D1BD458090;
	Fri, 15 Feb 2008 23:55:49 +0100 (CET)
Received: from hoat.troll.no ([127.0.0.1])
 by localhost (hoat.troll.no [127.0.0.1]) (amavisd-maia, port 10024) with LMTP
 id 19110-03; Fri, 15 Feb 2008 23:55:49 +0100 (CET)
Received: from luria.local (unknown [172.20.1.59])
	by hoat.troll.no (Postfix) with ESMTP id 70E225807A;
	Fri, 15 Feb 2008 23:55:49 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20080118.763038)
In-Reply-To: <47B1C102.7020400@thorn.ws>
X-Virus-Scanned: Maia Mailguard 1.0.2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73993>

--nextPart1350657.SEFbmnx3bv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 12 February 2008 16:53:38 Tommy Thorn wrote:
> On Sunday 03 February 2008 10:21:05 I wrote:
> > Teach git-p4 about the -/ option which adds depot paths to the exclude
> > list, used when cloning. The option is chosen such that the natural
> > Perforce syntax works, eg:
> >
> >   git p4 clone //branch/path/... -//branch/path/{large,old}/...
> >
> > Trailing ... on exclude paths are optional.
> >
> > This is a generalization of a change by Dmitry Kakurin (thanks).
> >
> > Signed-off-by: Tommy Thorn <tommy-git@thorn.ws>
>
> .. to which Simon replied:
> > Acked-By: Simon Hausmann <simon@lst.de>
> >
> > I like it, Perforce'ish syntax. (Not that I like p4 though ;)
>
> Alas, this change needs more work - the exclude paths needs to
> be maintained in the commit messages as otherwise we pull in new
> files in the excluded path. I haven't done this yet.
>
> However, the other patch (git-p4: no longer keep all file contents while
> cloning) is IMO critical. You simply cannot clone a non-trivial Perforce
> repository without it. Why is this being ignored? Are there no users of
> git-p4?

Sorry for the delay, my real life has kept be busy :)

I now looked at the patch and I'm all in favour of applying it. However it=
=20
doesn't seem to apply against the current git-p4. Can you re-send the patch=
=20
to me?

Thanks,
Simon

P.S.: I have applied the other patch (exclude path support)

--nextPart1350657.SEFbmnx3bv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHthiiWXvMThJCpvIRApLqAKDEHj1vF45gwRO0IiHxwFPF989XPgCfV2cM
CHeoYZNjj//wB/oKou8tebg=
=M70w
-----END PGP SIGNATURE-----

--nextPart1350657.SEFbmnx3bv--
