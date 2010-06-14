From: "Chris.Cheney" <chris.cheney.nospam@tesco.net>
Subject: git mergetool documentation oversight?
Date: Mon, 14 Jun 2010 08:01:35 +0000 (UTC)
Message-ID: <Xns9D975C4C1419DChrisCheneytesconet@80.91.229.10>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 10:01:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO4cD-0004Ig-AO
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 10:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab0FNIBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 04:01:46 -0400
Received: from lo.gmane.org ([80.91.229.12]:53452 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438Ab0FNIBq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 04:01:46 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OO4c5-0004GG-3s
	for git@vger.kernel.org; Mon, 14 Jun 2010 10:01:45 +0200
Received: from 81.100.120.234 ([81.100.120.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 10:01:45 +0200
Received: from chris.cheney.nospam by 81.100.120.234 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 10:01:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 81.100.120.234
User-Agent: Xnews/5.04.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149085>

Having just tripped over this, it would be helpful if the fact that git 
mergetool saves the merge-conflict version of the file with a .orig suffix 
and that the file should be deleted before adding and committing the merge 
(as described at 
http://gitguru.com/2009/02/22/integrating-git-with-a-visual-merge-tool/) 
were documented on the git-mergetool page.

Chris
