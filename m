From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 0/3] uppercase config options for cvsimport
Date: Wed,  1 Dec 2010 13:53:19 +0100
Message-ID: <cover.1291207768.git.git@drmicha.warpmail.net>
References: <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 13:56:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNmEC-0003d0-Or
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 13:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189Ab0LAMzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 07:55:39 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59684 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755183Ab0LAMzi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 07:55:38 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4616857E;
	Wed,  1 Dec 2010 07:55:38 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 01 Dec 2010 07:55:38 -0500
X-Sasl-enc: 5HTAA/5tiU3Eklbvj4zWq+sNJSC7YivS4eT5E7JhQKPg 1291208137
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BB5E5400DF3;
	Wed,  1 Dec 2010 07:55:37 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.617.g84f63
In-Reply-To: <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162505>

v3 changes the naming to "cvsimport.capital-x" for the config variable
corresponding to "-X", and amends the commit message in 2/3 to make it
clear that this "fix" addresses an undocumented feature of cvsimport
(as far as included documentation goes).

Also, v3 adds a cover letter :)

Michael J Gruber (3):
  cvsimport: partial whitespace cleanup
  cvsimport: fix the parsing of uppercase config options
  cvsimport.txt: document the mapping between config and options

 Documentation/git-cvsimport.txt |    7 +++++++
 git-cvsimport.perl              |   18 ++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
1.7.3.2.617.g84f63
