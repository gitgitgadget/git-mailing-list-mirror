From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/5] hg-to-git fixes
Date: Sun,  6 Jul 2008 05:15:16 +0200
Message-ID: <cover.1215313871.git.vmiklos@frugalware.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
X-From: git-owner@vger.kernel.org Sun Jul 06 05:16:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFKjp-0000sb-79
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 05:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbYGFDPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 23:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753347AbYGFDPM
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 23:15:12 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57919 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbYGFDPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 23:15:11 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 807A31DDC5F;
	Sun,  6 Jul 2008 05:15:08 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 3878B1A9CEF; Sun,  6 Jul 2008 05:15:21 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.322.ge904b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87491>

Hi,

I just noticed that hg-to-git was not updated to use dash-less git
commands, which now causes problems on 'next'. If I was at it, I fixed a
few minor issues I noticed as well.

Miklos Vajna (5):
  hg-to-git: avoid raising a string exception
  hg-to-git: abort if the project directory is not a hg repo
  hg-to-git: rewrite "git-frotz" to "git frotz"
  hg-to-git: use git init instead of git init-db
  hg-to-git: use git rev-parse instead of git show

 contrib/hg-to-git/hg-to-git.py |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)
