From: Corey Mitchell <cmitchell@cctus.com>
Subject: master-master server setup
Date: Wed, 24 Aug 2011 17:14:18 +0000 (UTC)
Message-ID: <loom.20110824T191218-282@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 19:20:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwH7d-0004SQ-NS
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 19:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab1HXRUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 13:20:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:41275 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850Ab1HXRUH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 13:20:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QwH7V-0004Oj-Mq
	for git@vger.kernel.org; Wed, 24 Aug 2011 19:20:06 +0200
Received: from 209-253-83-218.ip.mcleodusa.net ([209.253.83.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 19:20:05 +0200
Received: from cmitchell by 209-253-83-218.ip.mcleodusa.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 19:20:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 209.253.83.218 (Mozilla/5.0 (Windows NT 5.1; rv:6.0) Gecko/20100101 Firefox/6.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180018>

Hello Git team,
 
We have a distributed team (US and Japan).  We are thinking about migrating from
subversion to git because it better suits our distributed team.  Due to network
latency, we want to setup 2 git servers hosting the same repository.  We want
developers to be able to download and publish branches to their local server and
then have those changes replicated to the other site.  Is this possible?  Can
someone please explain how this setup is done?  If not, can someone please
explain the closest alternative and how it is setup? 
 
Thanks a lot,
Corey
