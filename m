From: Daniel <friedan@muon.rutgers.edu>
Subject: 'git commit --short' without touching index?
Date: Sat, 3 Jul 2010 08:30:31 +0000 (UTC)
Message-ID: <loom.20100703T102242-536@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 03 10:35:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUyBt-0006ny-BD
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 10:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab0GCIfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 04:35:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:33359 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000Ab0GCIfF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 04:35:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OUyBj-0006hT-Vb
	for git@vger.kernel.org; Sat, 03 Jul 2010 10:35:04 +0200
Received: from 194-144-14-254.du.xdsl.is ([194.144.14.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 10:35:03 +0200
Received: from friedan by 194-144-14-254.du.xdsl.is with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 10:35:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.144.14.254 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.4) Gecko/20100611 Firefox/3.6.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150181>

'git commit --short' touches .git/index ('--short' implies '--dry-run').

Is there any equivalent command that does not touch .git/index?

I'm using 'git commit --short' in a script to check if the repository needs
attention.  At present, it touches .git/index, which causes unnecessary activity
in another script running rsync.

thanks,
Daniel
