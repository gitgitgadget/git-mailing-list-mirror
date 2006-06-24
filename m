From: Dave Jones <davej@redhat.com>
Subject: commit triggers.
Date: Fri, 23 Jun 2006 23:29:08 -0400
Message-ID: <20060624032908.GH19461@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jun 24 05:29:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftypo-0004L2-JK
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 05:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWFXD3K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 23:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWFXD3K
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 23:29:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58088 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932148AbWFXD3J (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 23:29:09 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5O3T95i020496
	for <git@vger.kernel.org>; Fri, 23 Jun 2006 23:29:09 -0400
Received: from nwo.kernelslacker.org (vpn83-123.boston.redhat.com [172.16.83.123])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5O3T8Om017777
	for <git@vger.kernel.org>; Fri, 23 Jun 2006 23:29:08 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.7/8.13.5) with ESMTP id k5O3T8d7010477
	for <git@vger.kernel.org>; Fri, 23 Jun 2006 23:29:08 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.7/8.13.7/Submit) id k5O3T86E010476
	for git@vger.kernel.org; Fri, 23 Jun 2006 23:29:08 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22483>

I've grepped around, and come up with nothing, so hopefully
I'm not overlooking some already-implemented feature
(though it'd be great if I am).  How much work is involved in
creating a mechanism where some scripts living in say .git/triggers/
get executed on commits ?

The idea behind this stems from some scripts I've been running
periodically against an mbox of the daily kernel commits, which
greps for common bugs; kmalloc(GFP, size) instead of kmalloc(size,GFP),
memsets with reversed 2nd/3rd args etc etc.

It'd be useful I think to have a way to hook up such a script
to git's commit process that aborts a commit if a script returns
a hit, forcing the user to fix up the mistake before committing
it to the world.

thoughts ?

		Dave

-- 
http://www.codemonkey.org.uk
