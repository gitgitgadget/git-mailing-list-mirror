From: Max Kirillov <max@max630.net>
Subject: [PATCH 0/2] fix 'git show -s' to not add extra terminator after
 merge commit
Date: Tue, 13 May 2014 01:35:18 +0300
Message-ID: <20140512223517.GA32205@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 00:43:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjywJ-0003of-3u
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 00:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbaELWnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 18:43:15 -0400
Received: from p3plsmtpa08-05.prod.phx3.secureserver.net ([173.201.193.106]:40829
	"EHLO p3plsmtpa08-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751100AbaELWnP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 18:43:15 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa08-05.prod.phx3.secureserver.net with 
	id 1AbG1o0083gsSd601AbMCg; Mon, 12 May 2014 15:35:23 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248738>

* fix the CC issues
* add fixes for existing tests

Max Kirillov (2):
  git-show: fix 'git show -s' to not add extra terminator after merge commit
  t: git-show: adapt tests to fixed 'git show'

 combine-diff.c                |  3 ++-
 t/t1507-rev-parse-upstream.sh |  2 +-
 t/t7007-show.sh               |  8 ++++++--
 t/t7600-merge.sh              | 11 +++++------
 4 files changed, 14 insertions(+), 10 deletions(-)

-- 
1.8.5.2.421.g4cdf8d0
