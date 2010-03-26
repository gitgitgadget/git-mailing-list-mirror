From: "R. Tyler Ballance" <tyler@monkeypox.org>
Subject: Rebasing with merges and conflict resolutions
Date: Thu, 25 Mar 2010 20:11:12 -0700
Message-ID: <20100326031111.GB27737@kiwi.sharlinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 04:11:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuzxF-0005be-Qb
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 04:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872Ab0CZDLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 23:11:20 -0400
Received: from mail.geekisp.com ([216.168.135.169]:29147 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753125Ab0CZDLT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 23:11:19 -0400
Received: (qmail 31068 invoked by uid 1003); 26 Mar 2010 03:11:17 -0000
Received: from localhost (HELO kiwi.sharlinx.com) (tyler@monkeypox.org@127.0.0.1)
  by mail.geekisp.com with SMTP; 26 Mar 2010 03:11:17 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143206>


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I am trying to use rebase to straighten out a couple topic branches' histories
and running into nothing but troubles and I'm wondering if:
   a) I'm doing it wrong (highly likely)
   b) what I want is not possible
   c) banana!

Two contributors worked in tandem on a particular project, constantly merging
back and forth between each other creating a history of 118 commits total with
37 of them being merge commits, 7 of those merge commits having conflict
resolutions involved.

I would /like/ to rebase those into a more linear revision history, but I
can't seem to find any set of commands that doesn't have me:
   a) Manually re-doing every conflict resolution and merge (git rebase -p master)
   b) Drastically diverging from the original topic branch and entering some
      sort of mergeless hell (git rebase master)


Is it even possible to straighten this out without a massive rework of these
commits?

In the future, is there a better way for two developers to work in the same
back-and-forth fashion (code ping pong!) without leading to *heavily* merged
histories that are unpossible to untangle?


Halp!


Cheers,
-R. Tyler Ballance
--------------------------------------
 Jabber: rtyler@jabber.org
 GitHub: http://github.com/rtyler
Twitter: http://twitter.com/agentdero
   Blog: http://unethicalblogger.com


--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkusJc8ACgkQFCbH3D9R4W+UjACfbdPln6GyoXZXDpC4AHaqKIGT
ZZkAniSeYrSNb+hCGvwfeVzrAAbV+nkf
=11Bi
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
