From: Martin <html-kurs@gmx.de>
Subject: error: unlink(.git/refs/remotes/origin/testbranch) failed: was  remote
 does not support deleting refs
Date: Sun, 06 Jul 2008 02:20:18 +0200
Message-ID: <48700FC2.8080307@gmx.de>
References: <486FE602.3060301@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 02:21:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFI0G-0000Yt-K6
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 02:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbYGFAUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 20:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbYGFAUV
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 20:20:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:34990 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753057AbYGFAUU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 20:20:20 -0400
Received: (qmail invoked by alias); 06 Jul 2008 00:20:17 -0000
Received: from p54B213DF.dip0.t-ipconnect.de (EHLO [192.168.0.116]) [84.178.19.223]
  by mail.gmx.net (mp040) with SMTP; 06 Jul 2008 02:20:18 +0200
X-Authenticated: #4107867
X-Provags-ID: V01U2FsdGVkX1+LRwBpCcSL2+iFphvGbhjH5VxWz9ytX9SI+3oD3d
	+KlFMKRykRBKGp
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <486FE602.3060301@gmx.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87475>

Hi,

it seems that an old verison on the remote site was the problem:
On debian/etch git seems to be too old. I upgraded git to the testing 
version and now I can delete remote branches.

But I get another error:
$ git push origin :testbranch
To ssh://myserver.com/my/path/to/repository
  - [deleted]         testbranch
error: unlink(.git/refs/remotes/origin/testbranch) failed: No such file 
or directory
error: Failed to delete

Any idea?

Thanks,
Martin

Martin schrieb:
> Hi,
> 
> I tried to setup a central git repository. Access is via ssh.
> How do I delete a remote branch? If I try it using
>  > git branch -d -r origin/testbranch
>  > git push origin :refs/heads/testbranch
> I get the error
> 
> To ssh://myserver.com/my/path/to/repository
>  ! [rejected]        testbranch (remote does not support deleting refs)
> error: failed to push some refs to 
> 'ssh://myserver.com/my/path/to/repository'
> 
> So how do I setup my remote repository to allow deleting remote branches?
> 
> Thanks,
> Martin
> -- 
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
