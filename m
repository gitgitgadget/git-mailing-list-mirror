From: Jakub Narebski <jnareb@gmail.com>
Subject: Strange output of 'git diff <revision1>:<file> <revision2>:<file>'
Date: Sat, 15 Jul 2006 12:20:15 +0200
Organization: At home
Message-ID: <e9aff7$nk1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jul 15 12:19:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1hFL-00031a-KC
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 12:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWGOKT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Jul 2006 06:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWGOKT1
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Jul 2006 06:19:27 -0400
Received: from main.gmane.org ([80.91.229.2]:23763 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932492AbWGOKT0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Jul 2006 06:19:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G1hF5-0002za-Sq
	for git@vger.kernel.org; Sat, 15 Jul 2006 12:19:23 +0200
Received: from host-81-190-20-193.torun.mm.pl ([81.190.20.193])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Jul 2006 12:19:23 +0200
Received: from jnareb by host-81-190-20-193.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Jul 2006 12:19:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-193.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23931>

git diff output for files specified by revision is somewhat unexpected. 

  $ git diff <revision_1>:<file> <revision_2>:<file>

outputs the following diff metainfo

  diff --git a/<revision_2>:<file> b/<revision_2>:<file>
  index 5eabe06..2e87de4 100644
  --- a/<revision_2>:<file>
  +++ b/<revision_2>:<file>

Is it intended, or is it a bug? Looks like a bug to me...

git 1.4.0 (git-core-1.4.0-1.fc4 by Fedora Project).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
