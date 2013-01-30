From: Jason Wenger <jcwenger@gmail.com>
Subject: Files excluded but not ignored
Date: Wed, 30 Jan 2013 15:34:42 +0000 (UTC)
Message-ID: <loom.20130130T161911-66@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 16:40:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Zlk-0007n5-0Q
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 16:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab3A3Pjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 10:39:49 -0500
Received: from plane.gmane.org ([80.91.229.3]:39901 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398Ab3A3Pjs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 10:39:48 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U0Zlc-0007gR-N9
	for git@vger.kernel.org; Wed, 30 Jan 2013 16:40:05 +0100
Received: from oproxy2.rockwellcollins.com ([205.175.225.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 16:40:04 +0100
Received: from jcwenger by oproxy2.rockwellcollins.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 16:40:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 205.175.225.22 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.56 Safari/537.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215025>

I prefer to not add core.* files to my ignore listings because I find it helpful 
to see them in git status -- It helps me notice and clean them up periodically.  
Not having them ignored is also good ,because it allows git clean to care of 
core.*  files.

The problem is that git add -A, git stash -u, etc, remain interested in the core 
files.

Trying to start up discussion of whether there would be merit to a "half-
ignored" state -- Files which are excluded from tracking, but which still 
show in git status, and which are removed by git clean.

Not trying to propose yet how .git/exclude or .gitignore would be formatted 
or anything like that.  Just looking for opinions on whether such a state 
would be considered by the community as a good thing and merit the added 
complexity in the code.
