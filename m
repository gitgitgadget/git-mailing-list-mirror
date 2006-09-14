From: Dave Jones <davej@redhat.com>
Subject: Re: nightly tarballs of git
Date: Thu, 14 Sep 2006 13:51:16 -0400
Message-ID: <20060914175116.GB22279@redhat.com>
References: <20060914172754.GF8013@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 14 19:51:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNvMw-0005Z8-NI
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 19:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWINRvU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 13:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWINRvT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 13:51:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45975 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750834AbWINRvT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 13:51:19 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8EHpHpL028356;
	Thu, 14 Sep 2006 13:51:17 -0400
Received: from pressure.kernelslacker.org (vpn-248-2.boston.redhat.com [10.13.248.2])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8EHpGe2030133;
	Thu, 14 Sep 2006 13:51:16 -0400
Received: from pressure.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by pressure.kernelslacker.org (8.13.8/8.13.8) with ESMTP id k8EHpGii024895;
	Thu, 14 Sep 2006 13:51:16 -0400
Received: (from davej@localhost)
	by pressure.kernelslacker.org (8.13.8/8.13.8/Submit) id k8EHpG5a024894;
	Thu, 14 Sep 2006 13:51:16 -0400
X-Authentication-Warning: pressure.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: Nishanth Aravamudan <nacc@us.ibm.com>
Content-Disposition: inline
In-Reply-To: <20060914172754.GF8013@us.ibm.com>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27022>

On Thu, Sep 14, 2006 at 10:27:54AM -0700, Nishanth Aravamudan wrote:
 > Hi Dave,
 > 
 > For simplicities sake when I was running Debian Sarge on a server here,
 > I was using your nightly tarballs of git to build a fresh up-to-date
 > version on a regular basis. I noticed though, that the tarballs result
 > in gits with a version of 1.3.GIT, while the git repository is at
 > 1.4.2.1. Is that expected?

No, it isn't. (at least by me).
What the snapshotting script does when cron runs it is just a 'git pull'
on a repo that was cloned a while back when I first set up the snapshotting
script.  I could change it to do a fresh clone each time it runs, but
that seems somewhat wasteful when most of the time there's nothing new to pull.

gitsters, any ideas what could be going wrong here ?
The original clone of the repo was just a straight clone of git://git.kernel.org/pub/scm/git/git.git

	Dave 
