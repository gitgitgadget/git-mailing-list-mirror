From: John <jbeaulau@cisco.com>
Subject: Running git server from NAS
Date: Fri, 28 Aug 2009 16:31:12 +0000 (UTC)
Message-ID: <loom.20090828T181016-972@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 18:35:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh4Pz-0006Ug-FZ
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 18:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbZH1QfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 12:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbZH1QfC
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 12:35:02 -0400
Received: from lo.gmane.org ([80.91.229.12]:45392 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835AbZH1QfB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 12:35:01 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1Mh4Pm-0006RR-QF
	for git@vger.kernel.org; Fri, 28 Aug 2009 18:35:03 +0200
Received: from dhcp-171-71-25-215.cisco.com ([171.71.25.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 18:35:02 +0200
Received: from jbeaulau by dhcp-171-71-25-215.cisco.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 18:35:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 171.71.25.215 (Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; .NET CLR 3.0.04506; InfoPath.2))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127313>

Hello,

I need to have a git server available for multiple users, but I want the git
home directory and repositories on NAS due to data backup, and minimal down 
time if the Linux host goes down I can start another host pointing to the git 
home directory on the NAS. 

What would be the best way to configure this?

Thanks
-John 
