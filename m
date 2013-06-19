From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 0/4] documentation cleanups for <rev>^{<type>}
Date: Tue, 18 Jun 2013 22:09:36 -0400
Message-ID: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 19 04:10:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up7qi-0008QX-Im
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 04:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933899Ab3FSCKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 22:10:04 -0400
Received: from smtp.bbn.com ([128.33.0.80]:38571 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932998Ab3FSCKD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 22:10:03 -0400
Received: from socket.bbn.com ([192.1.120.102]:40562)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Up7qS-000OQP-Qx; Tue, 18 Jun 2013 22:10:00 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 83B0440153
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228325>

The documentation for the <rev>^{<type>} syntax (e.g.,
v1.8.3.1^{tree}) needed some fixing, and while I was at it I thought
I'd be pedantic about tree-ish.  Oh, and let's welcome "committish" to
the party!

-Richard


Richard Hansen (4):
  glossary: add 'treeish' as a synonym for 'tree-ish'
  glossary: define committish (a.k.a. commit-ish)
  glossary: more precise definition of tree-ish (a.k.a. treeish)
  revisions.txt: fix and clarify <rev>^{<type>}

 Documentation/glossary-content.txt | 29 +++++++++++++++++++++++++----
 Documentation/revisions.txt        | 12 ++++++++----
 2 files changed, 33 insertions(+), 8 deletions(-)

-- 
1.8.3.1
