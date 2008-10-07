From: David Bryson <david@statichacks.org>
Subject: error pushing stash ?
Date: Mon, 6 Oct 2008 17:34:35 -0700
Message-ID: <20081007003435.GZ5774@eratosthenes.cryptobackpack.org>
Reply-To: David Bryson <david@statichacks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYjDATHXTWnytHRU"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 07 02:35:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn0YG-0006LQ-Pk
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 02:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbYJGAeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 20:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbYJGAeh
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 20:34:37 -0400
Received: from cryptobackpack.org ([64.105.32.74]:36226 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbYJGAeg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 20:34:36 -0400
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 9809010D0271; Mon,  6 Oct 2008 17:34:36 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	DNS_FROM_SECURITYSAGE autolearn=no version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id E3CB310D01B2
	for <git@vger.kernel.org>; Mon,  6 Oct 2008 17:34:35 -0700 (PDT)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id A79C914464; Mon,  6 Oct 2008 17:34:35 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97647>


--zYjDATHXTWnytHRU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have a git mirror remote setup on a few of my repositories:

[remote "backup"]
    url = /users/dbryson/backup/janus.git/
    fetch = +refs/heads/*:refs/remotes/origin/*
    receivepack = sudo -u dbryson git-receive-pack
    mirror = 1

I send my refs to the backup with:

$ git push backup

Only to find some odd error messages:

Counting objects: 133, done.
Compressing objects: 100% (109/109), done.
Writing objects: 100% (109/109), 31.25 KiB, done.
Total 109 (delta 82), reused 0 (delta 0)
error: refusing to create funny ref 'refs/stash' remotely
To /users/dbryson/backup/janus.git/
   549f8a4..8e93d51  8654 -> 8654
   ef6195b..549f8a4  origin/8654 -> origin/8654
 + 623e7cb...63d7262 origin/master -> origin/master (forced update)
 ! [remote rejected] refs/stash -> refs/stash (funny refname)
error: failed to push some refs to '/users/dbryson/backup/janus.git/'

Should I be concnerned about this or is it normal ? To be honest the
fact that the stash isn't pushing doesn't bother me.  But maybe it is a
symptom of a larger problem ?

Dave


--zYjDATHXTWnytHRU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkjqrpsACgkQLfsM4nS2FiAqQwCZAWeIE0SH+ds0ow5eGEG2YmNb
RUkAoIQ0zXuSoyKhRvPgDGMtzuYiWkYQ
=5cJg
-----END PGP SIGNATURE-----

--zYjDATHXTWnytHRU--
