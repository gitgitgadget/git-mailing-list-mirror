From: Maaartin <grajcar1@seznam.cz>
Subject: Alternate .gitignore
Date: Fri, 8 Oct 2010 12:31:32 +0000 (UTC)
Message-ID: <loom.20101008T141929-221@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 08 14:31:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4C73-00065T-0f
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 14:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848Ab0JHMbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 08:31:43 -0400
Received: from lo.gmane.org ([80.91.229.12]:48265 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277Ab0JHMbm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 08:31:42 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P4C6v-00062r-Jm
	for git@vger.kernel.org; Fri, 08 Oct 2010 14:31:41 +0200
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 14:31:41 +0200
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 14:31:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.62)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158498>

I'm using git for a project, where I'd like to store not only the sources but 
some quite large generated files, too. However, I'd like to keep them separated, 
so my source depository doesn't grow too much. The problem could be solved 
nicely if there was a possibility to use .gitignore for the source tree and let 
say .gitignore2 for the extended tree. I'd use two depositories: .git and .git2.

The content if .gitignore2 could be a subset of the content of .gitignore, so 
the extended tree would contain the sources as well, which is not really a 
problem. Or maybe I could make the depositories disjoint, I'm not sure now.

Is something like this possible or is it too strange requirement?
