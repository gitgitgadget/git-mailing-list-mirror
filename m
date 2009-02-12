From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Strange branch merging.
Date: Thu, 12 Feb 2009 13:08:07 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngp87pn.50p.sitaramc@sitaramc.homelinux.net>
References: <49940D93.6000204@movency.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 14:10:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXbKF-0002ms-S4
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 14:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448AbZBLNI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 08:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757076AbZBLNI1
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 08:08:27 -0500
Received: from main.gmane.org ([80.91.229.2]:54433 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755870AbZBLNI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 08:08:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LXbIh-00005m-5n
	for git@vger.kernel.org; Thu, 12 Feb 2009 13:08:19 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 13:08:19 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 13:08:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109615>

On 2009-02-12, Adam Panayis <adam@movency.com> wrote:
> I have a local machine, on this I have 2 branches. The master and one 
> named blah. My git repository is in the following location: /git/.git/
>
> I have made changes to a file on the blah branch and committed these 
> changes.
>
> I checkout the master branch and as expected the changes are no longer 
> there. I flip back to blah and I can see my changes. So far so good.
>
> I then, on a remote machine use the pull command, the remote machine 
> shows only the master branch as I have not asked it to pull blah. The 
> command I use is as follows: git pull -v ssh://user@machine one/git/.git/
>
> Once this is done I double check my branches and it shows I still only 
> have the master. Perfect. However, when I check the file I edited on my 
> local machine on the blah branch, the changes are there.

On the remote machine, your current branch was 'master'.
When you did a 'git pull', whatever you did would affect
this branch.  Meanwhile, the currently checked-out branch on
the other side was 'blah', which is what came in.

What you need to do is add the word 'master' to the 'git
pull...' command you used.  This will ensure that,
regardless of what the currently checkedout branch on the
sending side is, you will get the master branch.
