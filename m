From: mwolfe38 <mwolfe38@gmail.com>
Subject: Re: ignoring files/directories in git
Date: Sun, 21 Sep 2008 17:06:54 -0700 (PDT)
Message-ID: <19599905.post@talk.nabble.com>
References: <19596152.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 22 02:08:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhYyD-0005W4-Ay
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 02:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbYIVAG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 20:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbYIVAG4
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 20:06:56 -0400
Received: from kuber.nabble.com ([216.139.236.158]:35412 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbYIVAGz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 20:06:55 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1KhYx4-0005ji-TK
	for git@vger.kernel.org; Sun, 21 Sep 2008 17:06:54 -0700
In-Reply-To: <19596152.post@talk.nabble.com>
X-Nabble-From: mwolfe38@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96446>


I just thought that I would add that the reason is a bug in the 1.5.4.3
version that I am using which is the ubuntu 8.04 repository version.
According to some developers, the current version should fix this issue.


mwolfe38 wrote:
> 
> I'm working on a project by myself and using git mostly just to learn
> about it.
> In my project I have several directories I want to have git ignore. One of
> them being
> cache/ and the other log/
> I've added them to the .gitignore file which I have in the initial
> directory of the repository
> The contents of my gitignore are:
> 
> .settings
> .cache
> cache/
> log/
> .project
> 
> However, if I do 
> git add .
> It will add the files from cache and log anyways.
> I know git add . will add anything that hasn't been added but shouldn't it
> ignore files in .gitignore?
> If not, what is the point, I would just ignore them manually anyways. 
> The main reason i like doing git add .
> is because i'm using symfony php framework which makes good use of scripts
> which generates lots if initial files for you and thus adding one at a
> time would be a pain.
> 
> Any idea what might be going on here?  I thought maybe I had added those
> directories before putting them in .gitignore so i used git rm -r to
> remove them but they still show back up with doing git add .
> 
> Thanks in advance
> 

-- 
View this message in context: http://www.nabble.com/ignoring-files-directories-in-git-tp19596152p19599905.html
Sent from the git mailing list archive at Nabble.com.
