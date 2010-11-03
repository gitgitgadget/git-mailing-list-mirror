From: Maaartin <grajcar1@seznam.cz>
Subject: Problems switching branches
Date: Wed, 3 Nov 2010 02:37:31 +0000 (UTC)
Message-ID: <loom.20101103T032930-451@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 03:38:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDTEd-0000zw-KZ
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 03:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab0KCChp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 22:37:45 -0400
Received: from lo.gmane.org ([80.91.229.12]:37824 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab0KCChn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 22:37:43 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PDTEM-0000sG-Hl
	for git@vger.kernel.org; Wed, 03 Nov 2010 03:37:42 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 03:37:42 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 03:37:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.63)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160568>

I sometimes run in a problem similar to
http://kerneltrap.org/mailarchive/git/2008/10/15/3667644/thread
There are some ignored files which I want neither track nor throw away; I'm just 
happy to have them and keep them out of version control.

Unfortunately, there weren't ignored in the old branch. I'd be quite happy with 
non-destructive switching like "checkout everything what doesn't overwrite an 
untracked file", so I would end in the old branch with a dirty working tree. Is 
it possible?
