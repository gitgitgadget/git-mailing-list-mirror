From: Brian Hetro <whee@smaertness.net>
Subject: [PATCH 0/5] git_config_string janitorial conversions.
Date: Sat,  5 Jul 2008 01:24:39 -0400
Message-ID: <cover.1215234749.git.whee@smaertness.net>
Cc: gitster@pobox.com, Brian Hetro <whee@smaertness.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 07:26:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF0Ha-0003MG-1x
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 07:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbYGEFYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 01:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbYGEFYz
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 01:24:55 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:63558 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbYGEFYy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 01:24:54 -0400
Received: by yw-out-2324.google.com with SMTP id 9so646404ywe.1
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 22:24:53 -0700 (PDT)
Received: by 10.151.112.1 with SMTP id p1mr3317822ybm.141.1215235493529;
        Fri, 04 Jul 2008 22:24:53 -0700 (PDT)
Received: from localhost.localdomain ( [74.69.33.95])
        by mx.google.com with ESMTPS id 34sm1794628yxm.0.2008.07.04.22.24.52
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jul 2008 22:24:52 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.1.204.g699135
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87429>

These patches are related to the git_config_string "janitorial" work.

There may be more cleanup possible, but these are the straightforward
changes.

Brian Hetro (5):
  builtin-commit.c: Use 'git_config_string' to get 'commit.template'
  builtin-log.c: Use 'git_config_string' to get 'format.subjectprefix'
    and 'format.suffix'
  convert.c: Use 'git_config_string' to get 'smudge' and 'clean'
  diff.c: Use 'git_config_string' to get 'diff.external'
  http.c: Use 'git_config_string' to clean up SSL config.

 builtin-commit.c |   11 ++++-------
 builtin-log.c    |   16 ++++------------
 convert.c        |   25 +++++++++----------------
 diff.c           |    8 ++------
 http.c           |   36 ++++++++++++------------------------
 5 files changed, 31 insertions(+), 65 deletions(-)
