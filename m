From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 00/11 v4] More consistant terminology
Date: Sat, 30 Oct 2010 06:10:08 +0200
Message-ID: <1288411819-24462-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Oct 30 06:10:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC2mC-00022F-38
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 06:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818Ab0J3EKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 00:10:39 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60029 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752Ab0J3EKh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 00:10:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9U43tQ2022072
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 30 Oct 2010 06:03:55 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PC2ly-0007od-7V; Sat, 30 Oct 2010 06:10:30 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PC2ly-0006OZ-5N; Sat, 30 Oct 2010 06:10:30 +0200
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 30 Oct 2010 06:03:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9U43tQ2022072
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1289016238.51944@dPQAgzPoeXEy7G+a6odceA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160374>

One more version, after Jonathan''s remarks.

I've splitted the everyday.txt hunk in a separate patch, reworded one
comment and fixed some grammar in user-manual.txt (see corresponding
discussions in thread for v3).

Jonathan Nieder (1):
  user-manual: remote-tracking can be checked out, with detached HEAD

Matthieu Moy (10):
  Better "Changed but not updated" message in git-status
  Replace "remote tracking" with "remote-tracking"
  Change remote tracking to remote-tracking in non-trivial places
  everyday.txt: change "tracking branch" to "remote-tracking branch"
  Change "tracking branch" to "remote-tracking branch"
  Change incorrect uses of "remote branch" meaning "remote-tracking"
  Change incorrect "remote branch" to "remote tracking branch" in C
    code
  Use 'remote-tracking branch' in generated merge messages
  user-manual.txt: explain better the remote(-tracking) branch terms
  git-branch.txt: mention --set-upstream as a way to change upstream
    configuration

 Documentation/config.txt               |   13 +++++-----
 Documentation/everyday.txt             |    6 ++--
 Documentation/fetch-options.txt        |    2 +-
 Documentation/git-branch.txt           |   14 ++++++-----
 Documentation/git-checkout.txt         |    2 +-
 Documentation/git-clone.txt            |    2 +-
 Documentation/git-describe.txt         |    2 +-
 Documentation/git-fetch.txt            |    2 +-
 Documentation/git-gc.txt               |    6 ++--
 Documentation/git-log.txt              |    2 +-
 Documentation/git-pull.txt             |    8 +++---
 Documentation/git-remote.txt           |    6 ++--
 Documentation/git-tag.txt              |    4 +-
 Documentation/gittutorial-2.txt        |    2 +-
 Documentation/gittutorial.txt          |    6 ++--
 Documentation/glossary-content.txt     |   20 ++++++++--------
 Documentation/rev-list-options.txt     |    2 +-
 Documentation/user-manual.txt          |   39 +++++++++++++++++++++++---------
 branch.h                               |    4 +-
 builtin/checkout.c                     |    4 +-
 builtin/fetch.c                        |    6 ++--
 builtin/fmt-merge-msg.c                |    6 ++--
 builtin/merge.c                        |    2 +-
 builtin/remote.c                       |    6 ++--
 contrib/examples/builtin-fetch--tool.c |    2 +-
 remote.c                               |    2 +-
 t/t1507-rev-parse-upstream.sh          |    2 +-
 t/t3409-rebase-preserve-merges.sh      |    2 +-
 t/t5400-send-pack.sh                   |    2 +-
 t/t5505-remote.sh                      |    8 ++++--
 t/t5513-fetch-track.sh                 |    2 +-
 t/t7508-status.sh                      |   34 ++++++++++++++--------------
 t/t7608-merge-messages.sh              |    4 +-
 wt-status.c                            |    2 +-
 34 files changed, 124 insertions(+), 102 deletions(-)

-- 
1.7.3.2.183.g2e7b0
