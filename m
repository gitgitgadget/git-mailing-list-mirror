From: Mikko Oksalahti <mikko@azila.fi>
Subject: Newbie "svn update" question
Date: Tue, 1 Dec 2009 09:25:37 +0000 (UTC)
Message-ID: <loom.20091201T101313-496@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 10:30:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFP3o-0007Mx-Jy
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 10:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbZLAJaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 04:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbZLAJaD
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 04:30:03 -0500
Received: from lo.gmane.org ([80.91.229.12]:51539 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688AbZLAJaB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 04:30:01 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NFP3c-0007JQ-KK
	for git@vger.kernel.org; Tue, 01 Dec 2009 10:30:04 +0100
Received: from xdsl-238-224.nebulazone.fi ([83.145.238.224])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 10:30:04 +0100
Received: from mikko by xdsl-238-224.nebulazone.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 10:30:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.145.238.224 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.33 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134187>

Hi,

I just started using git for my personal projects at home. Basic usage seems 
pretty straight-forward as well as setting up everything. However, I have a 
simple question about how do I mimic an "svn update" command on a locally 
created repository. Here's what I do:

some_existing_project_dir> git init
some_existing_project_dir> git add .

(about 1000 files added...)

some_existing_project_dir> git commit -a -m "initial commit"

(now I edit 10 files and accidentally delete some files that I'm not aware of)

How do I now get the accidentally deleted files back from the repository without 
losing local changes made to 10 files? 

I've tried using: "git checkout HEAD ." but my local changes after last commit 
will be lost.

I've tried using: "git pull ." but the deleted files are not restored.

So I'm looking for an "svn update" equivalent command that would semantically do 
this: "Get the latest version of all files from the repository and merge them 
with any local changes I've made to files."

I know a suitable command is available and I'm just a moron who can't read the 
manual correctly but help me out anyway :P

  Regards,
     Mikko
