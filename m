From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/5] builtin-remote: Make "remote -v" display push urls
Date: Sat, 13 Jun 2009 18:29:09 +0200
Message-ID: <1244910551-4420-1-git-send-email-git@drmicha.warpmail.net>
References: <7vtz2pmf98.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 18:30:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFW7Z-00067D-Ei
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 18:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759825AbZFMQaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 12:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758971AbZFMQaG
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 12:30:06 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35956 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758934AbZFMQaF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2009 12:30:05 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 5267C35E1C9;
	Sat, 13 Jun 2009 12:30:08 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sat, 13 Jun 2009 12:30:08 -0400
X-Sasl-enc: wbSIR5G5DfCYmA/n0Llku6tsClVUGMg6SUTfLy9v2QAR 1244910607
Received: from localhost (p5485A135.dip0.t-ipconnect.de [84.133.161.53])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8A61A31564;
	Sat, 13 Jun 2009 12:30:07 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.2.367.gf0de
In-Reply-To: <7vtz2pmf98.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121508>

So here are v2 of 4/5 and 5/5: Only the commit messages are revised
according to the discussion. The one of 5/5 uses a better example, and
the one of 4/5 shows the output for the same example now (before it had
no example). Patch-ids unchanged. 1/5, 2/5 and 3/5 are completely
unchanged and, thus, unsent :)

Cheers,
Michael

Michael J Gruber (2):
  builtin-remote: Show push urls as well
  builtin-remote: Make "remote -v" display push urls

 builtin-remote.c  |   47 ++++++++++++++++++++++++++++++++++++++---------
 t/t5505-remote.sh |   10 +++++++---
 2 files changed, 45 insertions(+), 12 deletions(-)
