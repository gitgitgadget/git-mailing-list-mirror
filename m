From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/3] l10: de.po: fixes around rebase
Date: Tue, 19 May 2015 10:51:31 +0200
Message-ID: <cover.1432025365.git.git@drmicha.warpmail.net>
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 10:51:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YudFZ-0007Rj-Lk
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 10:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbbESIvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 04:51:41 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58324 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752199AbbESIvj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2015 04:51:39 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 1C5D320AB4
	for <git@vger.kernel.org>; Tue, 19 May 2015 04:51:36 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 19 May 2015 04:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=
	mesmtp; bh=F51nyYTl1c1rkHN46gqhmvMqESE=; b=ScO8YGBkSCh5UQcoPXh+1
	MM9MYcrCrg4F+dDODXlJICs7lp+WGCqtlfs4VGRxvyMn/jjBhpmec3jcmIRrXqOA
	IzgMURFuKtA519s7p1iIJ0P09ZlRjMjpWawN+erIWjC0oxUGdvhyb1sJaXCNPoEk
	twPmxMobs7JuCGOnGRybyE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=F51nyYTl1c1rkHN46gqhmvMqES
	E=; b=LVcZVqAMG9flQABl5EOnZfK9v63yWjzREmxiiMQzC9tAF1rEHfZuc8ky6J
	A4lxn9kz2JnpE99GkOPQNU+dRGGpu7eZe9DUYBsrqmLbSKtgCi3znitSfeNWWmHJ
	atE4/8y+sc/KK/hPh5Q3Bh106XZOxl3ttR/WoF2U1HA/K3v8A=
X-Sasl-enc: Fkv7YLCc9It66oTfuphsl3HPwpIO3ghFnwu+yg1wurtr 1432025495
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 9DA0E680168;
	Tue, 19 May 2015 04:51:35 -0400 (EDT)
X-Mailer: git-send-email 2.4.0.rc3.332.g886447c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269345>

Fixes to a few issues that I found while running rebase
in German locale.

Michael J Gruber (3):
  l10: de.po: grammar fix
  l10: de.po: punctuation fixes
  l10: de.po: translation fix for fall-back to 3way merge

 po/de.po | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.4.0.rc3.332.g886447c
