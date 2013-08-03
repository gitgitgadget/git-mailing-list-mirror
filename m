From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Don't print status output with submodule.<name>.ignore=all
Date: Sat,  3 Aug 2013 17:14:18 +0000
Message-ID: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net>
Cc: judge.packham@gmail.com, iveqy@iveqy.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 03 19:14:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5fPc-0003iD-7R
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 19:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389Ab3HCROg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 13:14:36 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:45632 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752106Ab3HCROf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Aug 2013 13:14:35 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1136628073;
	Sat,  3 Aug 2013 17:14:34 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231610>

There are configuration options for each submodule that specify under what
circumstances git status should display output for that submodule.
Unfortunately, these settings were not being respected, and as such the tests
were marked TODO.

This patch series consists of two patches: the first is a fix for a confusing
variable name, and the latter actually makes git status not output the submodule
information.  The tests have been updated accordingly.

 git-submodule.sh  | 10 ++++++----
 t/t7508-status.sh |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)
