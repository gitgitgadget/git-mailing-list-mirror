From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/2] log decorations for HEAD
Date: Tue, 10 Mar 2015 14:53:19 +0100
Message-ID: <cover.1425995310.git.git@drmicha.warpmail.net>
References: <54FEC8D0.2060304@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Julien Cretel <j.cretel@umail.ucc.ie>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 14:53:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVKbA-0000ZU-K7
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 14:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbbCJNxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 09:53:24 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35633 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751057AbbCJNxX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 09:53:23 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 3A91720485
	for <git@vger.kernel.org>; Tue, 10 Mar 2015 09:53:21 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 10 Mar 2015 09:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=b/Lgdmw1GraYtx
	kl1pE06uJozqI=; b=faseWR01n1eZ8heJloDt+Dg0L9C7cg5YPYkhL0u1Yi6IAs
	gf1q8ehoS5B5Bb3yzhm/rLsfs1VbNvuTkPtRBT8EcjASIUJekd/khKa34yMzmUFQ
	GYz42Ij4Am3iDXW9xx+Cia1v4Gcx4Qukb3dz1QIgI7T8+LUMwduDjLPwIn0cY=
X-Sasl-enc: JwOtTMBSTlRBsrvPyORUhsqUmJpqhVSTw5fPJ+zxoGNt 1425995602
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 567C6C00297;
	Tue, 10 Mar 2015 09:53:22 -0400 (EDT)
X-Mailer: git-send-email 2.3.2.346.gb6960c9
In-Reply-To: <54FEC8D0.2060304@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265237>

So it didn't take too long to convince me after all :)

Here comes Junio's version, preceded by a cleanup of the color
setting and resetting for decorations.

Junio C Hamano (1):
  log: decorate HEAD with branch name

Michael J Gruber (1):
  log-tree: properly reset colors

 log-tree.c                        | 76 ++++++++++++++++++++++++++++++++++-----
 t/t4013/diff.log_--decorate_--all |  2 +-
 t/t4207-log-decoration-colors.sh  | 16 ++++-----
 3 files changed, 77 insertions(+), 17 deletions(-)

-- 
2.3.2.346.gb6960c9
