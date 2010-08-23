From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/3] git-bundle.txt options clarification
Date: Mon, 23 Aug 2010 11:02:36 +0200
Message-ID: <cover.1282553585.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 11:02:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnSvZ-0001ZX-60
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 11:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544Ab0HWJCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 05:02:44 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45635 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753596Ab0HWJCn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 05:02:43 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8DA4B466;
	Mon, 23 Aug 2010 05:02:42 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 23 Aug 2010 05:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=s5lMZWOHSQZ8MVzNJVnfnKXfYpk=; b=NZz76gmomspCasN+4XhimQ16OmdPKALajTiSDHvJlz4cLUhxD5DUAhGqIoKheEdxPlhQ7qXB04QrfMd6ffh76sBQjfC03/ih/ujZ302ct/luKFGq4L84XJP/F98T8WWX5Zm4LXDVWfxgTvAdeBqPM7885V5rhGKsj0UN7fLUuUY=
X-Sasl-enc: lSthyNmlJ8LVGrAtKoXYslSvzdDK83wc51TSNFlgXQSa 1282554162
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0C4C25EB461;
	Mon, 23 Aug 2010 05:02:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.1.52.g7f7860
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154210>

This mini-series is the outcome of my attempt with the following command:

git bundle master~7..master~5

I understand (now) why it fails and why it must fail, but this should be
easier to grasp from the man page. Before amending it, the 1st two patches
do some systematic and coding resp. whitespace cleanup. Feel free to squash
as you deem appropriate.

Michael J Gruber (3):
  git-bundle.txt: Cleanup
  git-bundle.txt: whitespace cleanup
  git-bundle.txt: Clarify rev-list-args restrictions

 Documentation/git-bundle.txt |   73 +++++++++++++++++++++--------------------
 1 files changed, 37 insertions(+), 36 deletions(-)

-- 
1.7.2.1.52.g7f7860
