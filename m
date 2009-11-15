From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/3] Document and refuse rebase -s ours
Date: Sun, 15 Nov 2009 19:25:29 +0100
Message-ID: <cover.1258309432.git.trast@student.ethz.ch>
References: <7vvdhggote.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 15 19:26:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9jnu-0003YL-EJ
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 19:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbZKOS0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 13:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753228AbZKOS0M
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 13:26:12 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:7158 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbZKOS0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 13:26:11 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 19:26:16 +0100
Received: from localhost.localdomain (129.132.210.10) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 19:26:15 +0100
X-Mailer: git-send-email 1.6.5.2.420.gf6c057.dirty
In-Reply-To: <7vvdhggote.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132946>

Junio convinced me that it is not possible to limit the choice to only
'subtree', so here's a short series that implements the other changes
I had already posted in diff form.

I also implemented Nicolas's suggestion to reject -s ours outright;
I'm not really happy with starting a blacklist there, but maybe it
helps the next unwary user.  I split it because even if you reject
3/3, I think the first two should go in as extra documentation.

Thomas Rast (3):
  Documentation: clarify 'ours' merge strategy
  rebase docs: clarify --merge and --strategy
  rebase: refuse to rebase with -s ours

 Documentation/git-rebase.txt       |   14 +++++++++++---
 Documentation/merge-strategies.txt |    5 +++--
 git-rebase--interactive.sh         |    4 ++++
 git-rebase.sh                      |    4 ++++
 4 files changed, 22 insertions(+), 5 deletions(-)
