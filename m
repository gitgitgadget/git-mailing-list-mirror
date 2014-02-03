From: Max Kirillov <max@max630.net>
Subject: [PATCH 0/3] gitk: show latest change to region
Date: Tue, 4 Feb 2014 00:34:01 +0200
Message-ID: <20140203223346.GA14202@wheezy.local>
References: <20140203205352.GA5136@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 23:41:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WASCX-0006wN-2e
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 23:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbaBCWk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 17:40:59 -0500
Received: from m1plsmtpa01-08.prod.mesa1.secureserver.net ([64.202.165.187]:40882
	"EHLO m1plsmtpa01-08.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796AbaBCWk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 17:40:57 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Feb 2014 17:40:57 EST
Received: from wheezy.local ([89.27.29.195])
	by m1plsmtpa01-08.prod.mesa1.secureserver.net with 
	id MyaD1n0084CavkR01yaJay; Mon, 03 Feb 2014 15:34:21 -0700
Content-Disposition: inline
In-Reply-To: <20140203205352.GA5136@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241483>

Hi!

I quite like the "Show origin of this line" feature of the
gitk. It is more convenient than blame, because it
directly answers the question which is usually addressed to
blame.

But, sometimes there is no "key" line which one could blame.
Instead there is a function, block, or some other region of
code. So I need a similar feature, but for several lines
rather than for a single one.

The series of patches implements the feature. It consists of
3 patches:

* gitk: refactor: separate generic hunk parsing out of find_hunk_blamespecs{}
* gitk: refactor: separate io from logic in the searching origin of line
* gitk: pick selection for region blame

It also requires the "gitk: use single blamestuff for all
show_line_source{} calls" patch, which it replies to.

-- 
Max
