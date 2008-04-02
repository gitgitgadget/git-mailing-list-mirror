From: Stephen Bannasch <stephen.bannasch@deanbrook.org>
Subject: Can I switch a git-svn clone from a file => http url?
Date: Wed, 2 Apr 2008 10:38:34 -0400
Message-ID: <p06240804c41942f6276e@[192.168.1.114]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 02 16:45:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh4D1-00010S-Ao
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 16:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733AbYDBOoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 10:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756794AbYDBOoN
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 10:44:13 -0400
Received: from deanbrook.org ([66.160.189.173]:35465 "HELO deanbrook.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755516AbYDBOoM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 10:44:12 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Apr 2008 10:44:12 EDT
Received: from 72.173.30.166 ([72.173.30.166]) by deanbrook.org for <git@vger.kernel.org>; Wed, 2 Apr 2008 07:38:49 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78694>

I've just created a git-svn clone from a svn repo accessed locally 
with a file:/// path.

Unfortunately the local svn repo is just a copy of the main svn repo 
normally accessed with http or https (served through Apache). I was 
having problems cloning the main svn repository (more details below) 
so I archived the remote svn repository and copied it to my local 
hard drive.

Is there an operation I can now do to switch the base url from:

   file:///Path/to/svn/repository/projects

to

   https://svn.concord.org/svn/projects

Here's more details about the problem that got me to this spot:

The svn repo is about 1GB.

I tried several times on a 1000baseT network to git-svn clone the 
repo. There are about 13000 revisions but the clone process would 
randomly stop without an error somewhere between revision 400 and 
1200.

This was the command I was using:

git svn clone https://svn.concord.org/svn/projects

I'm running git version 1.5.4.4 (installed via ports) on MacOS 10.5.2.
