From: Dave Jones <davej@redhat.com>
Subject: git-applymbox fails to extract patch.
Date: Fri, 10 Mar 2006 00:04:46 -0500
Message-ID: <20060310050446.GA20764@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Mar 10 06:05:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHZoG-0004kf-D4
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 06:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbWCJFFA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 00:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWCJFFA
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 00:05:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26047 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751604AbWCJFE7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Mar 2006 00:04:59 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k2A54vr1007509
	for <git@vger.kernel.org>; Fri, 10 Mar 2006 00:04:57 -0500
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k2A54l110762
	for <git@vger.kernel.org>; Fri, 10 Mar 2006 00:04:47 -0500
Received: from devserv.devel.redhat.com (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id k2A54kD2021989
	for <git@vger.kernel.org>; Fri, 10 Mar 2006 00:04:46 -0500
Received: (from davej@localhost)
	by devserv.devel.redhat.com (8.12.11/8.12.11/Submit) id k2A54ke5021987
	for git@vger.kernel.org; Fri, 10 Mar 2006 00:04:46 -0500
X-Authentication-Warning: devserv.devel.redhat.com: davej set sender to davej@redhat.com using -f
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17453>

Since my munged versions of Linus' original apply-mbox scripts
no longer work on current git, I figured I'd try and use the
ones provided with it.

I'm totally confused as to what's going on here.

Here's what I'm trying to apply..
http://userweb.kernel.org/~davej/mbox.txt

And here's what happens..

(04:59:42:davej@hera:cpufreq)$ git-applymbox -k ~/Mail/mbox
1 patch(es) to process.

Applying ''

fatal: No changes


What am I missing ?

		Dave
