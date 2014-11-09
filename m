From: Max Kirillov <max@max630.net>
Subject: [PATCH v3 0/2] gitk: save only changed configuration on exit
Date: Sun,  9 Nov 2014 09:56:59 +0200
Message-ID: <1415519821-30172-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 08:58:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnNNy-0006zQ-4z
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 08:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbaKIH6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 02:58:00 -0500
Received: from p3plsmtpa09-04.prod.phx3.secureserver.net ([173.201.193.233]:57491
	"EHLO p3plsmtpa09-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751138AbaKIH57 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2014 02:57:59 -0500
Received: from wheezy.pp.htv.fi ([82.181.81.240])
	by p3plsmtpa09-04.prod.phx3.secureserver.net with 
	id DKxs1p0045B68XE01KxxQJ; Sun, 09 Nov 2014 00:57:58 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

Used explivit changed flag for views instead of trace. Minor style fixes.

As I said, could not use namespace for older config read because they leak to
globals.

Max Kirillov (2):
  gitk: write only changed configuration variables
  gitk: synchronize config write

 gitk | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 104 insertions(+), 11 deletions(-)

-- 
2.0.1.1697.g73c6810
