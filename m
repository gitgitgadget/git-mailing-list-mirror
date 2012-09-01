From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/6] Fix Tap parse error etc.
Date: Sat, 01 Sep 2012 19:06:47 +0100
Message-ID: <50424EB7.6010607@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 20:28:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7sQa-0004DP-50
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 20:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab2IAS2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 14:28:01 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:44495 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751854Ab2IAS1z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 14:27:55 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 2D4FB128078;
	Sat,  1 Sep 2012 19:27:54 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 80557128075;	Sat,  1 Sep 2012 19:27:53 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Sat,  1 Sep 2012 19:27:52 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204643>

Hi Junio,

I have several branches that I've been meaning to "finish up" for some
time. Here, for example, I had intended to add some more patches to
merge the TABS_IN_FILENAMES and FUNNYNAMES test prerequisites and
then define a single "lazy" prerequisite in test-lib.sh. But I just
haven't found the time ...

[BTW, the pu branch is *very* broken on cygwin (it's the v5 index
branch). I have a patch to fix it up; I just need to write it up.]

Ramsay Jones (6):
  t3300-*.sh: Fix a TAP parse error
  t3902-*.sh: Skip all tests rather than each test
  t4016-*.sh: Skip all tests rather than each test
  test-lib.sh: Fix some shell coding style violations
  test-lib.sh: Add check for invalid use of 'skip_all' facility
  test-lib.sh: Suppress the "passed all ..." message if no tests run

 t/t3300-funny-names.sh | 24 ++++++++----------
 t/t3902-quoted.sh      | 31 +++++++++++------------
 t/t4016-diff-quote.sh  | 20 +++++++--------
 t/test-lib.sh          | 69 +++++++++++++++++++++++++++++++++-----------------
 4 files changed, 81 insertions(+), 63 deletions(-)

-- 
1.7.12
