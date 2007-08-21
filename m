From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Document the -p option for git-show.
Date: Tue, 21 Aug 2007 14:49:49 +0200
Message-ID: <20070821124949.GH768@genesis.frugalware.org>
References: <46C97D26.9090102@brefemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 14:50:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INTBQ-0002jX-Dt
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 14:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbXHUMuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 08:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753479AbXHUMuE
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 08:50:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:57735 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753463AbXHUMuD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 08:50:03 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1INTBF-0005FF-QP
	from <vmiklos@frugalware.org>; Tue, 21 Aug 2007 14:50:01 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B616113A4022; Tue, 21 Aug 2007 14:49:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46C97D26.9090102@brefemail.com>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.1
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.1 required=5.9 tests=BAYES_50,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4998]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56292>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-show.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index a42e121..2409389 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -33,6 +33,10 @@ This manual page describes only the most frequently used options.
 
 OPTIONS
 -------
+
+-p::
+	For commits, show the change the commit introduces in a patch form.
+
 <object>::
 	The name of the object to show.
 	For a more complete list of ways to spell object names, see
-- 
1.5.2.2
