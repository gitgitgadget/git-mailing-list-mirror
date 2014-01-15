From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] provide a Git user-manual man page
Date: Wed, 15 Jan 2014 23:10:51 +0000
Message-ID: <1389827452-3896-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 16 00:10:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3ZbS-0008ER-GB
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 00:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbaAOXK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 18:10:27 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:54051 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752753AbaAOXKZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 18:10:25 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: As0zAM0U11ICYJQD/2dsb2JhbABZgwtIA4EAgW+xIYdJgQYXdIMCO4ECJIgbmEKqcBePNIQJBKo1gy08
X-IPAS-Result: As0zAM0U11ICYJQD/2dsb2JhbABZgwtIA4EAgW+xIYdJgQYXdIMCO4ECJIgbmEKqcBePNIQJBKo1gy08
X-IronPort-AV: E=Sophos;i="4.95,665,1384300800"; 
   d="scan'208";a="452300166"
Received: from host-2-96-148-3.as13285.net (HELO localhost) ([2.96.148.3])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 15 Jan 2014 23:10:23 +0000
X-Mailer: git-send-email 1.8.3.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240486>

The Git User Manual is formatted as a doc book, rather than as
a man page so isn't directly accessible via the 'hit help <guide>'
command.

This patch provides a simple man page with onward links to the true
User-Manual. 

The man page is based directly on a very cut down version of the git(1)
page.

This patch is based on master, so the update to the help.c list of
guides may need a simple merge resolution with the 'git help everyday'
patch currently in pu.

Philip Oakley (1):
  Provide a 'git help user-manual' route to the docbook

 Documentation/Makefile           |  1 +
 Documentation/gituser-manual.txt | 34 ++++++++++++++++++++++++++++++++++
 builtin/help.c                   |  1 +
 3 files changed, 36 insertions(+)
 create mode 100644 Documentation/gituser-manual.txt

-- 
1.8.3.msysgit.0
