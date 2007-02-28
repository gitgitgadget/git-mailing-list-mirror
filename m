From: Paolo Bonzini <bonzini@gnu.org>
Subject: defaults for where to merge from
Date: Wed, 28 Feb 2007 15:53:03 +0100
Message-ID: <es450f$d58$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 15:54:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQC0-0002g1-SE
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 15:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbXB1OyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 09:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932928AbXB1OyG
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 09:54:06 -0500
Received: from main.gmane.org ([80.91.229.2]:59482 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932929AbXB1OyE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 09:54:04 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HMQBN-0006zF-Em
	for git@vger.kernel.org; Wed, 28 Feb 2007 15:53:29 +0100
Received: from usilu-ge.ti-edu.ch ([195.176.176.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 15:53:29 +0100
Received: from bonzini by usilu-ge.ti-edu.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 15:53:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: usilu-ge.ti-edu.ch
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40929>

As can be seen from my other messages, I'm experimenting a little with 
git and trying to understand how its workflow compares with arch.  Right 
now, my procedure for branching off a remote archive is:

   git checkout -b branchname remote/upstreambranch
   git config --add branch.branchname.remote remote
   git config --add branch.branchname.merge refs/heads/upstreambranch

Is there a reason why "git branch" and "git checkout -b" should not 
automatically do the two "git-config --add"s when the source branch is 
remote?

In case the source branch is not remote, would "origin" be a good choice 
for the "branch.branchname.remote" variable?

Paolo
