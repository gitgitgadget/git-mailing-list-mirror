From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 0/2] fix 'git show -s' to not add extra terminator after
 merge commit
Date: Tue, 13 May 2014 02:09:43 +0300
Message-ID: <20140512230943.GC32316@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 01:09:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjzLz-0004Vq-Ln
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 01:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbaELXJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 19:09:47 -0400
Received: from p3plsmtpa08-09.prod.phx3.secureserver.net ([173.201.193.110]:48910
	"EHLO p3plsmtpa08-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751071AbaELXJq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 19:09:46 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa08-09.prod.phx3.secureserver.net with 
	id 1B9i1o0073gsSd601B9kRu; Mon, 12 May 2014 16:09:46 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248740>

Since v1:
* add Signed-off-by
* remove notion about '--format=%s' - found it in the
  documentation

Since RFC:
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
