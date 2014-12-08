From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/2] Make git branch -f forceful
Date: Mon,  8 Dec 2014 17:28:43 +0100
Message-ID: <cover.1418055912.git.git@drmicha.warpmail.net>
References: <xmqqbnniq8k8.fsf@gitster.dls.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 17:28:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy1BB-00056B-Oe
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbaLHQ2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:28:48 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43502 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750908AbaLHQ2r (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2014 11:28:47 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id E201020289
	for <git@vger.kernel.org>; Mon,  8 Dec 2014 11:28:46 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 08 Dec 2014 11:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=eXHk4KizW6smXa
	1UBB9UVvA/gOk=; b=q6f+Ge0t40A92eGj7ZRHQki4fKDGnOhf9UHN957X4bvu28
	F7+6YB/8yP4hVS2QoCr8wy9vDFGCZM4uFG0u45Q2HoMAjDi6+AdNCgIHzhmephZT
	5ypih99cuHAWdlYTTroVUR/7rhkI0gqasYS+z61EMAAzPqab6kS9G5MUw1VTc=
X-Sasl-enc: jNl6Up8Yo6Es3Fh5+chYDBT2al/4okl3gEZzJeIB4QgF 1418056126
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8049368012B;
	Mon,  8 Dec 2014 11:28:46 -0500 (EST)
X-Mailer: git-send-email 2.2.0.345.g7041aac
In-Reply-To: <xmqqbnniq8k8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261073>

For many git commands, '-f/--force' is a way to force actions which
would otherwise error out. Way more than once, I've been trying this
with 'git branch -d' and 'git branch -m'...

I've had these two patches sitting in my tree for 3 years now it seems.
Here's a rebase.

In v2 I rename force_create to force and spell out the "-f" behaviour
for other options in the commit message.

Michael J Gruber (2):
  t3200-branch: test -M
  branch: allow -f with -m and -d

 builtin/branch.c  | 13 +++++++++----
 t/t3200-branch.sh | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.2.0.345.g7041aac
