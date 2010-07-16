From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 0/5] git-reset documentation changes
Date: Fri, 16 Jul 2010 11:44:37 +0200
Message-ID: <cover.1279273256.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 16 11:44:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZhTM-0008WI-2i
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 11:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832Ab0GPJon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 05:44:43 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:10874 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964795Ab0GPJom (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 05:44:42 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 16 Jul
 2010 11:44:41 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 16 Jul
 2010 11:44:42 +0200
X-Mailer: git-send-email 1.7.2.rc3.259.g43154
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151138>

I wrote this on the bus travelling to France, and haven't got around
to sending it out since then.

The main goal was the first patch, which redoes the 'description'
section in the style pioneered by b831ded (Documentation/checkout:
clarify description, 2010-06-01) in git-checkout(1).

The rest are just various ideas that I'm tossing around.  I also would
like to shorten the 'examples' section significantly if anyone sees a
way to do that without a huge loss of explanations.  I think the
chances that users consult the current version aren't exactly great
because of its length.

Thomas Rast (5):
  Documentation/git-reset: reorder modes for soft-mixed-hard
    progression
  Documentation/reset: separate options by mode
  Documentation/reset: promote 'examples' one section up
  Documentation/reset: reorder examples to match description
  Documentation/reset: move "undo permanently" example behind "make
    topic"

 Documentation/git-reset.txt |  346 ++++++++++++++++++++++---------------------
 1 files changed, 177 insertions(+), 169 deletions(-)

-- 
1.7.2.rc3.259.g43154
