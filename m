From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2 0/2] git-svn multi-glob fix and extension
Date: Fri, 8 Aug 2008 01:40:25 -0700
Message-ID: <20080808084025.GA8718@untitled>
References: <20080807090008.GA9161@untitled> <1218123242-26260-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Fri Aug 08 10:41:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRNXN-0000v4-Lv
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 10:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbYHHIk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 04:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbYHHIk1
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 04:40:27 -0400
Received: from hand.yhbt.net ([66.150.188.102]:56509 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073AbYHHIk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 04:40:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id BAB3F2DC01B;
	Fri,  8 Aug 2008 01:40:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1218123242-26260-1-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91635>

Marcus Griep <marcus@griep.us> wrote:
> 
> This patch series fixes and extends globs for branches and tags.
> 
> The first patch fixes the assertion that protects git-svn from allowing
> multi-globs in branch names, whereas the second removes that restriction
> altogether, allowing up to one multi-glob set in defining a branch hierarchy.
> 
> Also, patches are now under 80 chars wide except for a couple of echos in the
> test cases.

Thanks.  At least I can apply the patches now :)
I've made couple of fixups which will be replies to this message.

Eric Wong (1):
      git-svn: wrap long lines in a few places

Marcus Griep (2):
      Fix multi-glob assertion in git-svn
      git-svn: Allow deep branch names by supporting multi-globs

---
 git-svn.perl                               |   67 +++++++++---
 t/t9108-git-svn-glob.sh                    |   24 ++++-
 t/t9108-git-svn-multi-glob.sh              |  157 ++++++++++++++++++++++++++++
 t/t9125-git-svn-multi-glob-branch-names.sh |   37 +++++++
 4 files changed, 267 insertions(+), 18 deletions(-)

-- 
Eric Wong
