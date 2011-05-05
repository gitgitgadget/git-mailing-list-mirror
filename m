From: Valentin Haenel <valentin.haenel@gmx.de>
Subject: [PATCH v3 0/5] better document 'interactive.singlekey' and '--patch'
Date: Thu,  5 May 2011 20:47:51 +0200
Message-ID: <1304621271-17107-1-git-send-email-valentin.haenel@gmx.de>
References: <7vbozjipmp.fsf@alter.siamese.dyndns.org>
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Valentin Haenel <valentin.haenel@gmx.de>
To: Git-List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 20:48:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI3b2-0004mT-ET
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113Ab1EESsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:48:16 -0400
Received: from kudu.in-berlin.de ([192.109.42.123]:54772 "EHLO
	kudu.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab1EESsP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 14:48:15 -0400
Received: from kudu.in-berlin.de (localhost [127.0.0.1])
	by kudu.in-berlin.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p45Im50k017148;
	Thu, 5 May 2011 20:48:05 +0200
Received: (from esc@localhost)
	by kudu.in-berlin.de (8.14.3/8.14.3/Submit) id p45Im4DC017147;
	Thu, 5 May 2011 20:48:04 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vbozjipmp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172869>

This is round 3 of this series. Now improves the documentation of
'--patch' in various manpages in addition to better documenting
'interactive.singlekey' in config.txt and git-add.txt.

First patch brings the documentation in config.txt up-to-date. The
second patch documents the configuration in git-add manpage. The last
three patches improve the documentation for '--patch' in manpages of
git-checkout, git-reset and git-stash. Updating the synopsis in each
one, adding a link to the git-add manpage where the interactive
'--patch'-mode & 'interactive.singlekey' are described, and improving
the description for that option.

Note that the first patch is already included in pu (93556471), but I
included it here again since its part of the series. Is that the right
thing to do, or could I have dropped it?

Thanks to Peff and Junio for comments and advice.

V-

Valentin Haenel (5):
  config.txt: 'interactive.singlekey; is used by...
  git-add.txt: document 'interactive.singlekey'
  git-reset.txt: better docs for '--patch'
  git-stash.txt: better docs for '--patch'
  git-checkout.txt: better docs for '--patch'

 Documentation/config.txt       |    5 +++--
 Documentation/git-add.txt      |    6 +++++-
 Documentation/git-checkout.txt |    7 ++++---
 Documentation/git-reset.txt    |    7 ++++---
 Documentation/git-stash.txt    |    9 +++++----
 5 files changed, 21 insertions(+), 13 deletions(-)
