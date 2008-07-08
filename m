From: Pierre Habouzit <madcoder@debian.org>
Subject: [take 2] revision parsing made incremental
Date: Tue,  8 Jul 2008 15:19:32 +0200
Message-ID: <1215523175-28436-1-git-send-email-madcoder@debian.org>
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 15:21:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGD7o-00035L-3d
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 15:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbYGHNTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 09:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753049AbYGHNTo
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 09:19:44 -0400
Received: from pan.madism.org ([88.191.52.104]:33617 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbYGHNTm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 09:19:42 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 8378C34451;
	Tue,  8 Jul 2008 15:19:37 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CAF86578671; Tue,  8 Jul 2008 15:19:35 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.396.gca539
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87764>

Following Dscho's remarks, I reworked the series to avoid changing
setup_revisions semantics for now, and only exposed the part that groks
options (and keep pseudo revision arguments out).

It indeed makes the series smaller, even if the first patch is quite
long to read, and is just enough for simplifying git-blame in a very
satisfying way.

The series passes the testsuite, has no know blanks issues, and is
pushed to my public repository.
