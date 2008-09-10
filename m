From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 22:32:49 +0200
Message-ID: <20080910203249.GX4829@genesis.frugalware.org>
References: <20080909132212.GA25476@cuci.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pwWdILMQNxDD/Cps"
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 22:33:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdWNy-00022p-Rb
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 22:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYIJUcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 16:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752120AbYIJUcv
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 16:32:51 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50220 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086AbYIJUcv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 16:32:51 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id CE57E1B253F;
	Wed, 10 Sep 2008 22:32:49 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C118D4465E;
	Wed, 10 Sep 2008 22:32:49 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 862F9119019E; Wed, 10 Sep 2008 22:32:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080909132212.GA25476@cuci.nl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95554>


--pwWdILMQNxDD/Cps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2008 at 03:22:12PM +0200, "Stephen R. van den Berg" <srb@cuci.nl> wrote:
> origin a1184d85e8752658f02746982822f43f32316803 2
> author Junio C Hamano <gitster@pobox.com> 1220132115 -0700
> committer Junio C Hamano <gitster@pobox.com> 1220153445 -0700

First, sorry for joining the thread lately, as far as I see the idea I
want to shere here was not mentioned by anybody yet.

So, git revert already includes the "origin" of the commit in the commit
message, and I think that is fine for most people.

What about adding an option to cherry-pick to add a similar
"commit 7b27718bdb1b70166383dec91391df5534d449ee upstream" or similar
string to the commit message?

As far as I see the kernel -stable tree already have this, but it is
added manually and in many different forms, like:

[ Upstream commit 5f3a9a207f1fccde476dd31b4c63ead2967d934f ]

commit 7b27718bdb1b70166383dec91391df5534d449ee upstream

Already in Linus' tree:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=b25b791b13aaa336b56c4f9bd417ff126363f80b

etc.

Once git would provide a standard way to do this, that could be used to
avoid this.

--pwWdILMQNxDD/Cps
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjILvEACgkQe81tAgORUJb6fwCeKHFp8l9NnaDd1oePLRaEVNmD
+A4Anjom/zWL1EBxmP4Jan00XEkhuHF/
=1jBS
-----END PGP SIGNATURE-----

--pwWdILMQNxDD/Cps--
