From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] Clarify semantics of git attribute macros
Date: Wed,  3 Aug 2011 15:41:28 +0200
Message-ID: <1312378890-31703-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, peff@peff.net,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 15:41:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qobhm-0002xk-TX
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 15:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab1HCNlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 09:41:46 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:53303 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab1HCNlp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 09:41:45 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QobfE-0000wA-SJ; Wed, 03 Aug 2011 15:39:12 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178576>

Make it clearer that attribute macros do not only affect other
attributes, but are attributes themselves.

The second patch changes the nomenclature in gitattributes(5) from
"attribute macro" to "macro attribute", which I think makes the point
a tiny bit clearer.  But it is definitely optional.

Michael Haggerty (2):
  gitattributes: Clarify discussion of attribute macros
  gitattributes: Reword "attribute macro" to "macro attribute"

 Documentation/gitattributes.txt |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

-- 
1.7.6.8.gd2879
