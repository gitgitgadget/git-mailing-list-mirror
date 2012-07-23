From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 0/4] Various merge / diff tool related minor clean-ups and
 improvements
Date: Mon, 23 Jul 2012 09:10:06 +0200
Message-ID: <500CF8CE.90906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 09:10:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StCmj-0005Q7-Nh
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 09:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678Ab2GWHKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 03:10:25 -0400
Received: from plane.gmane.org ([80.91.229.3]:40028 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156Ab2GWHKY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 03:10:24 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1StCmd-0005Hq-8S
	for git@vger.kernel.org; Mon, 23 Jul 2012 09:10:23 +0200
Received: from p5ddb0653.dip0.t-ipconnect.de ([93.219.6.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 09:10:23 +0200
Received: from sschuberth by p5ddb0653.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 09:10:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p5ddb0653.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201913>

This series introduce various minor clean-ups and improvements to the merge / diff tool scripts and documentation.

Sebastian Schuberth (4):
  Use variables for the lists of tools that support merging / diffing
  Explicitly list all valid diff tools and document --tool-help as an
    option
  Make sure to use Araxis' "compare" and not e.g. ImageMagick's
  Add a few more code comments and blank lines in guess_merge_tool

 Documentation/git-difftool.txt         |  9 ++++++---
 contrib/completion/git-completion.bash | 11 +++++++++--
 git-mergetool--lib.sh                  |  6 ++++++
 mergetools/araxis                      |  8 +++++++-
 4 files changed, 28 insertions(+), 6 deletions(-)

-- 
1.7.11.msysgit.2
