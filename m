From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/6] git-reset.txt improvements
Date: Wed, 15 Sep 2010 22:47:38 +0200
Message-ID: <cover.1284582409.git.git@drmicha.warpmail.net>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 15 22:49:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovyun-0005JE-26
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 22:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981Ab0IOUrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 16:47:41 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:38927 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754939Ab0IOUrk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 16:47:40 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 013275EF;
	Wed, 15 Sep 2010 16:47:40 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 15 Sep 2010 16:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=VaQ/BDRZMGaeGG00PCLhfzM0PSw=; b=G1B4yH7Qb9cLCCS3tHDbNAc3EzLPL1PvfUsfJulbMjcBpjZ3ar2wOp6GHZdZb32Fld2Iz/HyiCfdsTLbv1J4sGoHSxuB0k5GohMCO6fnoDPkBjXrwnjy7j/5DUAjUlVfbb93/e73ZIxuBw56xGI0r+DZYEPz6Alc7c7lJSldU+s=
X-Sasl-enc: 3kq09G4ZjyXyQ65E1QjY7miFJ36/0z0hk5YuqsjS97je 1284583659
Received: from localhost (p548580A7.dip0.t-ipconnect.de [84.133.128.167])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 57841401802;
	Wed, 15 Sep 2010 16:47:39 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc1.215.g6997c
In-Reply-To: <cover.1284365021.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156249>

In v2 I tried to incorporate all changes as suggested by Junio. Thanks
for all the hints!

Michael J Gruber (6):
  git-reset.txt: clarify branch vs. branch head
  git-reset.txt: reset does not change files in target
  git-reset.txt: reset --soft is not a no-op
  git-reset.txt: use "working tree" consistently
  git-reset.txt: point to git-checkout
  git-reset.txt: make modes description more consistent

 Documentation/git-reset.txt |   76 ++++++++++++++++++++++++++----------------
 1 files changed, 47 insertions(+), 29 deletions(-)

-- 
1.7.3.rc1.215.g6997c
