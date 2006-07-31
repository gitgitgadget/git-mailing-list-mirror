From: Jakub Narebski <jnareb@gmail.com>
Subject: git-diff between /dev/null and blob
Date: Mon, 31 Jul 2006 03:07:51 +0200
Organization: At home
Message-ID: <eajl4r$b7o$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 31 03:07:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7MG7-0006wi-SC
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 03:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWGaBHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 21:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWGaBHr
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 21:07:47 -0400
Received: from main.gmane.org ([80.91.229.2]:49350 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932507AbWGaBHq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 21:07:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7MG0-0006vO-3S
	for git@vger.kernel.org; Mon, 31 Jul 2006 03:07:44 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 03:07:44 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 03:07:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24485>

Currently, due to artifact of git-diff argument parsing you can get diff 
of two arbitrary blobs given by their sha1 id, e.g.
  git diff ab8050ceb4e43522e858768cc2c02fcb91839370 fd05278808d458602587bb024a48726018d30926
but you cannot use git-diff to create diff between two files, or a file
and blob. 

In particular, I couldn't make "creation" patch, i.e. patch between 
/dev/null and specified blob. If it would be possible, we could lose
gitweb.cgi dependency on diff.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
