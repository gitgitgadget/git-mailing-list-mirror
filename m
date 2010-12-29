From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/2] Handle cvsimport config for uppercase options
Date: Wed, 29 Dec 2010 22:55:32 +0100
Message-ID: <cover.1293659350.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 29 22:54:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY3yx-0007Lc-G8
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 22:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab0L2Vyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 16:54:50 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42410 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753917Ab0L2Vyu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Dec 2010 16:54:50 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 83583600
	for <git@vger.kernel.org>; Wed, 29 Dec 2010 16:54:49 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 29 Dec 2010 16:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=g85BtIpqgjq5TvbE32zuEITKS2M=; b=ZR71KoOUat55ExipWIvpvf+BfNB3OIZWsBUI8CvMK/JYxGRvA/TEfYT06oa7vxhHBwhs7Jrun6Kj2wUXATWfPZzlbsrqZ/4B1E6eEbOetOFHBJPMUQvRbMa8mzFiYyokOZfoxQwoJdg9OB+XLXfWKt12epzzceOty6tuVN5H84A=
X-Sasl-enc: KZX90SiMJ7ZK0nadfpPyXk7uc8juZCzvcnfRFX7efDG8 1293659688
Received: from localhost (p54858E58.dip0.t-ipconnect.de [84.133.142.88])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D7A6E44129A;
	Wed, 29 Dec 2010 16:54:48 -0500 (EST)
X-Mailer: git-send-email 1.7.3.4.865.ga2bc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164333>

Sorry for rushing this out (no in-reply-to etc.) , I'm mostly offline
these days and pressed by the rc phase.

This is the version (n+1) as suggested by Junio, so 2/2 is mostly by JC
(only that his patch didn't apply, it probably was for maint).

I dropped the documentation patch, since the discussion resulted in short
config option names being frowned upon, so we should leave them undocumented
and return to rewrite them one day.

Michael J Gruber (2):
  cvsimport: partial whitespace cleanup
  cvsimport: handle the parsing of uppercase config options

 git-cvsimport.perl   |   33 +++++++++++++++++++++++++--------
 t/t9600-cvsimport.sh |    7 +++++--
 2 files changed, 30 insertions(+), 10 deletions(-)

-- 
1.7.3.4.865.ga2bc4
