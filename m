From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 0/2] Make git branch -f forceful
Date: Thu,  4 Dec 2014 14:26:43 +0100
Message-ID: <cover.1417699299.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 14:26:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwWQo-0005je-9I
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 14:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbaLDN0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 08:26:49 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37197 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750907AbaLDN0s (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 08:26:48 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id C14B020ABA
	for <git@vger.kernel.org>; Thu,  4 Dec 2014 08:26:47 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 04 Dec 2014 08:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:subject:date
	:message-id; s=smtpout; bh=hCTDJEBkWYjWiFRZKytJvDtaP90=; b=lNlAb
	wL33CnkQJDFduFJ3HqtXT862g1kSCiJPEfnjWTB9Kg8g36IhK+xRt1v848H9RfuT
	gZyv9AtiEC0TZKKmiBIjqwiPvCPgen+dLK65lasB1E2eVDomLh1dxe1erbLlg4Mx
	XjpN9KQPkGyri+JwAy6X+VkaMTHdlGzkQo63wU=
X-Sasl-enc: CNvT0OX1QVd3wSyCsv/OaBrSKwZHuL9sXiV715GMp4ob 1417699607
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5DE85680013;
	Thu,  4 Dec 2014 08:26:47 -0500 (EST)
X-Mailer: git-send-email 2.2.0.rc3.286.g888a711
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260756>

For many git commands, '-f/--force' is a way to force actions which
would otherwise error out. Way more than once, I've been trying this
with 'git branch -d' and 'git branch -m'...

I've had these two patches sitting in my tree for 3 years now it seems.
Here's a rebase.

Before applying these for food I should probably rename force_create to force.

Michael J Gruber (2):
  t3200-branch: test -M
  branch: allow -f with -m and -d

 builtin/branch.c  |  9 +++++++--
 t/t3200-branch.sh | 14 ++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.2.0.rc3.286.g888a711
