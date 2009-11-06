From: Dave Rodgman <dav1dr@eml.cc>
Subject: question: connecting to multiple remote svn projects
Date: Fri, 6 Nov 2009 17:55:46 +0000 (UTC)
Message-ID: <hd1nv2$79e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 06 19:00:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6T6d-0003UF-80
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 19:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759249AbZKFSAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 13:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759260AbZKFSAA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 13:00:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:38071 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759180AbZKFSAA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 13:00:00 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N6T6S-0003Pg-S3
	for git@vger.kernel.org; Fri, 06 Nov 2009 19:00:04 +0100
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 19:00:04 +0100
Received: from dav1dr by fw-tnat.cambridge.arm.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 19:00:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: fw-tnat.cambridge.arm.com
User-Agent: Pan/0.133 (House of Butterflies)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132317>

Hi,

Given a layout in a single subversion repository like this:

module1/branches/1.0/work
module2/branches/1.0/work

I would like achieve the following layout locally, in git:

module1/work
module2/work

Obviously I can create multiple git repositories in separate directories, 
but I would like them to be in a single repository. I can also get the 
same layout as subversion, but this breaks various bits of build 
infrastructure. I've fiddled with --branches, etc on git svn init
but can't figure out how to achieve this. 

I don't care about tracking the subversion branches in git, or being able
to switch between subversion branches.

Is this possible? How can I do this?

many thanks

Dave
