From: Jeff Brown <jeff@jeffandbetsy.net>
Subject: problems syncing with svn
Date: Fri, 27 Mar 2009 09:17:00 -0400
Message-ID: <bbd12f0f0903270617m3c2233b2g6c6e8c3d9a9b50a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 14:18:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnBxH-0002id-Js
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 14:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbZC0NRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 09:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbZC0NRF
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 09:17:05 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:44972 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbZC0NRD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 09:17:03 -0400
Received: by fxm2 with SMTP id 2so1019194fxm.37
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 06:17:00 -0700 (PDT)
Received: by 10.204.119.79 with SMTP id y15mr698110bkq.155.1238159820443; Fri, 
	27 Mar 2009 06:17:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114887>

I have found numerous folks having a similar problem but have not
found a solution that works for me.  This is what I have:

I have svn clone'd a repo.  I have added a git remote to the project.
I have pulled from the git repo.  When I attempt to "svn dcommit", the
commit fails with...

Unable to extract revision information from commit
26c8e90f67d40d9193fe276f3bcbfdd4e9161730~1

What I really want to do is move our primary development support to
git (github in particular right now).  I want to setup a job that will
periodically grab the latest code from github and push those changes
to our svn repo.  These will be the only commits made to svn.
Developers will no longer be committing to svn.  We need the svn repo
kept up to date for a few reasons but do not want to do development
against svn directly.

Any advice would be much appreciated.

Thanks in advance.



jeff
-- 
Jeff Brown
SpringSource
http://www.springsource.com/

Autism Strikes 1 in 166
Find The Cause ~ Find The Cure
http://www.autismspeaks.org/
