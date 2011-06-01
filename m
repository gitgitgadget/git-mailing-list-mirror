From: Randy Brandenburg <randy.brandenburg@woh.rr.com>
Subject: Unable to fork off sideband demultiplexer
Date: Wed, 1 Jun 2011 14:16:32 +0000 (UTC)
Message-ID: <loom.20110601T161508-689@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 16:16:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRmED-0003fd-5E
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 16:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732Ab1FAOQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 10:16:52 -0400
Received: from lo.gmane.org ([80.91.229.12]:53499 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247Ab1FAOQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 10:16:51 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QRmE4-0003cF-Db
	for git@vger.kernel.org; Wed, 01 Jun 2011 16:16:50 +0200
Received: from pm2-users.caci.com ([204.194.77.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 16:16:48 +0200
Received: from randy.brandenburg by pm2-users.caci.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 16:16:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 204.194.77.3 (Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; InfoPath.2; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; MS-RTC LM 8))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174868>

I have searched high and low to find a resolution to this error I am seeing 
when attempting to push or pull from a repository (either remote or on the same 
machine).  The error reported is as follows: 

# git push
error: cannot create thread: Unknown error 
fatal: fetch-pack: Unable to fork off sideband demultiplexer 
Broken pipe 

# git pull
error: cannot create thread: Unknown error 
fatal: receive-pack: Unable to fork off sideband demultiplexer 
Broken pipe 

This is a Solaris 9 installation (git-1.7.5-sol9-sparc-local.gz obtained from 
Sunfreeware.com) including all of the required package dependencies listed. 
I followed the same install on a Solaris 10 box and have no issues. Not sure if 
this is a permissions issue or something not configured 
correctly.
 
Any help is greatly appreciated. 
