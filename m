From: Felipe Contreras <felipec@infradead.org>
Subject: [PATCH 0/4] completion: trivial cleanups
Date: Mon, 30 Jan 2012 19:23:13 +0200
Message-ID: <1327944197-6379-1-git-send-email-felipec@infradead.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 18:23:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrux2-0004eQ-AB
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 18:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664Ab2A3RX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 12:23:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54035 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab2A3RX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 12:23:26 -0500
Received: from canuck.infradead.org ([2001:4978:20e::1])
	by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Rruwv-0005aw-7m; Mon, 30 Jan 2012 17:23:25 +0000
Received: from bombadil.infradead.org ([2001:4830:2446:ff00:4687:fcff:fea6:5117] helo=localhost)
	by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
	id 1Rruwu-0004wl-IM; Mon, 30 Jan 2012 17:23:24 +0000
X-Mailer: git-send-email 1.7.8
X-SRS-Rewrite: SMTP reverse-path rewritten from <felipec@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189378>

From: Felipe Contreras <felipe.contreras@gmail.com>

And an improvement for zsh.

Felipe Contreras (4):
  completion: simplify __git_remotes
  completion: remove unused code
  completion: cleanup __gitcomp*
  completion: be nicer with zsh

 contrib/completion/git-completion.bash |   66 +++++---------------------------
 1 files changed, 10 insertions(+), 56 deletions(-)

-- 
1.7.8
