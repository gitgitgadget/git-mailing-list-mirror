From: Kai Schlamp <schlamp@gmx.de>
Subject: Re: Beginner problem with .gitignore
Date: Tue, 21 Apr 2009 11:57:30 +0200
Message-ID: <49ED988A.6030504@gmx.de>
References: <gsid27$p1$1@ger.gmane.org> <49ED8914.9090808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 12:00:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwClr-0000TV-Sg
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 12:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbZDUJ6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 05:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754548AbZDUJ6I
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 05:58:08 -0400
Received: from main.gmane.org ([80.91.229.2]:57723 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155AbZDUJ6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 05:58:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LwCjq-0006V6-90
	for git@vger.kernel.org; Tue, 21 Apr 2009 09:58:02 +0000
Received: from p54a8c166.dip.t-dialin.net ([84.168.193.102])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 09:58:02 +0000
Received: from schlamp by p54a8c166.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 09:58:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p54a8c166.dip.t-dialin.net
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <49ED8914.9090808@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117120>

Michael, thanks for the help. Comments below.

> By "is ignored", do you mean that git status doesn't show it? 

Yes, that is what I meant.

> git status does not recurse into subdirectories by default unless there 
> is at least one tracked file inside.

Ok. I justed tested this a bit. Let's say I have the following directory 
structure: "/a_dir/b_dir/c_dir"

And have a .gitignore with:
/a_dir
!/a_dir/b_dir/c_dir/

Now i put a file "a_file" in "c_dir".
And add the a_file with "git add /a_dir/b_dir/c_dir/a_file". Yes, a_file 
is tracked now.

I would have expected (after your information above) that if I create 
another file "b_file" in "c_dir" and check "git status" that this file 
is on the untracked file list now.
But it doesn't show up.
And this makes it quite hard to exclude a whole folder, but only include 
one of it's subfolders. I use git gui for commits. And I like it that 
newly added files show up as untracked files.
But in this case those files in those subdiretories won't.

Best regards,
Kai
