From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH RFC] git-remote-mediawiki: push-by-rev
Date: Sun, 16 Jun 2013 22:28:18 +0200
Message-ID: <1371414499-13027-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 22:28:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoJZ5-00079O-0c
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 22:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406Ab3FPU2a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Jun 2013 16:28:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37084 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015Ab3FPU23 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 16:28:29 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5GKSPp3015005
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Jun 2013 22:28:25 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5GKSRFG018209;
	Sun, 16 Jun 2013 22:28:27 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5GKSR0B012602;
	Sun, 16 Jun 2013 22:28:27 +0200
X-Mailer: git-send-email 1.8.3.1.522.gd761f2b.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 16 Jun 2013 22:28:25 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228025>

=46rom: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>

This patch intends to introduce the by_rev strategy for the push comman=
d, as
already available for the fetch one.
This uses subroutines used by the fetch-by-rev strategy. I'm not sure i=
t's
actually complete: can it be that simple? However, I tested on a local =
wiki and
it seemed to work perfectly.=20
Should I add associate tests?

C=C3=A9lestin Matte (1):
  git-remote-mediawiki: push-by-rev

 contrib/mw-to-git/git-remote-mediawiki.perl | 24 +++++++++++++++++++++=
+--
 1 file changed, 22 insertions(+), 2 deletions(-)

--=20
1.8.3.1.522.gd761f2b.dirty
