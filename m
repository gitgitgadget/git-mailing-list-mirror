From: "Pat Notz" <patnotz@gmail.com>
Subject: [PATCH 0/2] Add commit message options for rebase --autosquash
Date: Thu, 16 Sep 2010 19:39:54 -0600
Message-ID: <1284687596-236-1-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 17 03:40:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwPw4-0002NK-Cg
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 03:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304Ab0IQBkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 21:40:11 -0400
Received: from sentry-three.sandia.gov ([132.175.109.17]:57479 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab0IQBkK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 21:40:10 -0400
X-WSS-ID: 0L8VBAX-0C-0WE-02
X-M-MSG: 
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 14FBA5486CB
	for <git@vger.kernel.org>; Thu, 16 Sep 2010 19:40:08 -0600 (MDT)
Received: from [134.253.165.160] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Thu, 16 Sep 2010 19:39:58 -0600
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from sacv8030ib.sandia.gov (134.253.116.6) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.2.254.0; Thu, 16 Sep 2010 19:39:57 -0600
X-Mailer: git-send-email 1.7.2.3
X-TMWD-Spam-Summary: TS=20100917014001; ID=1; SEV=2.3.1;
 DFV=B2010090808; IFV=NA; AIF=B2010090808; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230392E34433932433646312E303137332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAABAKR1FwAAAAAAAAAAAAAAAAAAAH0=
X-MMS-Spam-Filter-ID: B2010090808_5.03.0010
X-WSS-ID: 608C19642JS2822544-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156369>

This change adds new command line options to git-commit to make it
easy to specify messages for commits destined for
'rebase -i --autosquash'.

The first commit adds the new options to git-commit.

The second commit adds tests of the new options.  The tests only look
for properly formed commit messages and expected error conditions.  They
do not test the rebase --autosquash functionality.

Pat Notz (2):
  commit: add message options for rebase --autosquash
  t7500: add tests of commit --fixup/--squash

 Documentation/git-commit.txt |   18 ++++++++++++++----
 builtin/commit.c             |   37 +++++++++++++++++++++++++++++++++----
 t/t7500-commit.sh            |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 8 deletions(-)

-- 
1.7.2.3
