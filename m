From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [ANNOUNCE] gitolite v3.0 released
Date: Wed, 18 Apr 2012 07:17:52 +0530
Message-ID: <20120418014752.GA29186@sita-lt.atc.tcs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Cc: git@vger.kernel.org
To: gitolite@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Apr 18 03:48:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKK0A-0001tM-6a
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 03:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287Ab2DRBsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 21:48:04 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:51313 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab2DRBsD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 21:48:03 -0400
Received: by dake40 with SMTP id e40so9115978dak.11
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 18:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=DUBSYXMvs33kjz1OFc6UJv87pzA/JmcTA1oqXyximW0=;
        b=O9ONMREjS19Xg1Eiy6aLX4NqRBpzod9XVpjeIgX5OCYaOxSy6LKtl8LU11to2FI0wS
         UwCWNwPr36Gt+I4QE9fRa9RCmcm5psa8aM0Gj2POPuxBgaMYG/MyD+b9h17buGCdKb/9
         LuYLh8O4hsqo1tnJul8SaREfl2tVG8KRnjeAWM+lKpcL6JfGZtRUY/Ey3gIL/7WHxJgt
         OrsdvKb64m1fkeLuEc3rAXuL8z3oNm/+e1pTbijR1yFo3AuAuTDDSLm2SW99tkF5hZNf
         zSspOMGidQam22MiQv43tSDdrsFVq1ziC9qDYf4+WxBNvOrTjg8qq0rWDSFdKxvO1ppq
         xd6w==
Received: by 10.68.239.39 with SMTP id vp7mr1817673pbc.153.1334713682263;
        Tue, 17 Apr 2012 18:48:02 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.172.29])
        by mx.google.com with ESMTPS id r10sm22244836pbf.22.2012.04.17.18.47.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 18:48:01 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195827>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

Gitolite is now at version 3.0.  The new "master" branch (as of
a few minutes ago) is what used to be "g3", and the old "master"
has been renamed to "g2".

The tag is "v3.0".  However, since this is a complete rewrite,
with no common commits, the older tags are not ancestors of this
one.  Please be aware of this, although to most people it should
not matter.

The online documentation has also been switched around; the
default docs at [1] are now "g3" docs, and the old ones are in a
"g2" subdirectory; see [2].

The reasons for the rewrite are at [3], although some may make
sense only to people who've used gitolite.

I'm using it in "production" in my own group, although my
biggest internal customer has not yet migrated due to scheduling
issues.  If you're using any exotic features in gitolite, please
see the dev-status page at [4] before migrating.  Migration from
the older gitolite is documented at [5].

Sitaram

[1]: http://sitaramc.github.com/gitolite
[2]: http://sitaramc.github.com/gitolite/g2
[3]: http://sitaramc.github.com/gitolite/g3why.html
[4]: http://sitaramc.github.com/gitolite/dev-status.html
[5]: http://sitaramc.github.com/gitolite/install.html#migr

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjh1IAAoJEKRCkIUIgjelvbgP/0+8feC62ribuZYK1zYMwD63
cQPYRMZ10jMf3jCICLUUNizkHep2t8WultZrad+WtXJeJU/KYlVJhYo/o+nvn6Aq
eiFa7taKOdYS66hwL2aJ/aMEYheQOPQ5TYifJ32tycDhtVap4a2Q/gsy76gZo0GC
sBcxGnlpGihZM2USpRck1zqsbU9twtEDeC2AVlQxtmd7ha1B+5pU9OdRZ7xLqxuY
mM8+hqSxPxyHs1hb16zty1eSfsNnTt3A20lb8uR0a18lEK3ul8T6CYe5ZioPg77/
a3wguqPLKK2CfAUdRpg2lbejptUHNxGqOe4bao0PR4mr5p8Dgf5vP8C+IiKMxDc+
Ov0sAXFgBI3Fm1sNJyOFGafgcszeLCXIgw+sZ3wMdEutuvso8RuDsk0HjlTIx568
VqofKIOtXDM/y4VPzQnTsibKuZWJGsMtaEOqQ4OukPb/vABfKyS6ACLjW0AdKYOR
taxE+3CXMdzwzqZEMiPyyQN4Ik0PIyFbbpRiVOJcfPo6848g1cmpKiUzV5T5wAmU
kXIJcF/9xf2UhHkiF2PBTK3yTw4khMsUBNC+V6F2JOMtnCO9b608DdvCQE2D1576
z4o4wvpecbTGaLRtdMJ+axL7cvr2jBC4ECCivyFTuJRPzMGWi4k0q/II0c3XdhJC
zGB4+i0MWIFkuClT8CjO
=sJzc
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
