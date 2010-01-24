From: Russ Paielli <Russ.Paielli@gmail.com>
Subject: basic question about push
Date: Sun, 24 Jan 2010 07:04:59 +0000 (UTC)
Message-ID: <loom.20100124T074722-510@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 08:10:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYwcA-0008Aw-Ff
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 08:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab0AXHKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 02:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538Ab0AXHKO
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 02:10:14 -0500
Received: from lo.gmane.org ([80.91.229.12]:52334 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153Ab0AXHKM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 02:10:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NYwbn-00086M-2j
	for git@vger.kernel.org; Sun, 24 Jan 2010 08:10:07 +0100
Received: from 76-220-47-11.lightspeed.sntcca.sbcglobal.net ([76.220.47.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 08:10:07 +0100
Received: from Russ.Paielli by 76-220-47-11.lightspeed.sntcca.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 08:10:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 76.220.47.11 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7) Gecko/20100106 Ubuntu/9.10 (karmic) Firefox/3.5.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137884>

I am just starting to learn git. I would like to start by using git to work
remotely. My work computer and home computer both run Linux. I can log into my
work computer from home, but not vice versa. For several years, I have been
using ssh (with X forwarding) to login to my work computer from home. I have
been basically using my home computer as an X terminal. I would like to start
actually working locally on my home computer and use git to stay sync'd with my
work computer.

I created a git repository on my work machine, and I cloned it on my home
machine. As a test, I edited a file on my home machine and pushed it to my work
machine. I guess I don't understand how to use push. I got this:

Counting objects: 5, done.    
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 278 bytes, done.
Total 3 (delta 1), reused 0 (delta 0)        
warning: updating the current branch         
warning: Updating the currently checked out branch may cause confusion,
warning: as the index and work tree do not reflect changes that are in HEAD.
warning: As a result, you may see the changes you just pushed into it       
warning: reverted when you run 'git diff' over there, and you may want      
warning: to run 'git reset --hard' before starting to work to recover.      
warning:                                                                    
warning: You can set 'receive.denyCurrentBranch' configuration variable to  
warning: 'refuse' in the remote repository to forbid pushing into its       
warning: current branch.                                                    
warning: To allow pushing into the current branch, you can set it to 'ignore';
warning: but this is not recommended unless you arranged to update its work   
warning: tree to match what you pushed in some other way.                     
warning:                                                                      
warning: To squelch this message, you can set it to 'warn'.                   
warning:                                                                      
warning: Note that the default will change in a future version of git         
warning: to refuse updating the current branch unless you have the            
warning: configuration variable set to either 'ignore' or 'warn'.             
To ssh://localhost:6666/home/paielli/scala                                    
   7ea65c7..c52864c  master -> master


What does this mean in English? And what is the correct way to transfer my
revisions from my home computer to my work computer? Thanks.

Russ P.
