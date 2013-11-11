From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 0/7] remote-hg, remote-bzr fixes
Date: Sun, 10 Nov 2013 23:05:05 -0500
Message-ID: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 05:07:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfin0-0003n1-Ar
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 05:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018Ab3KKEHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 23:07:46 -0500
Received: from smtp.bbn.com ([128.33.1.81]:33718 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003Ab3KKEHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 23:07:45 -0500
Received: from socket.bbn.com ([192.1.120.102]:44753)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vfimt-000JV1-6P; Sun, 10 Nov 2013 23:07:43 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 2243F3FF72
X-Mailer: git-send-email 1.8.5.rc1.207.gc17dd22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237597>

A handful of fixes for the git-remote-hg and git-remote-bzr remote
helpers and their unit tests.

Richard Hansen (7):
  remote-hg:  don't decode UTF-8 paths into Unicode objects
  test-bzr.sh, test-hg.sh: allow running from any dir
  test-bzr.sh, test-hg.sh: prepare for change to push.default=simple
  test-hg.sh: eliminate 'local' bashism
  test-hg.sh: avoid obsolete 'test' syntax
  test-hg.sh: help user correlate verbose output with email test
  remote-bzr, remote-hg: fix email address regular expression

 contrib/remote-helpers/git-remote-bzr |  7 +++----
 contrib/remote-helpers/git-remote-hg  |  9 ++++-----
 contrib/remote-helpers/test-bzr.sh    |  6 +++++-
 contrib/remote-helpers/test-hg.sh     | 31 ++++++++++++++++++-------------
 4 files changed, 30 insertions(+), 23 deletions(-)

-- 
1.8.5.rc1.207.gc17dd22
