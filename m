From: Michel Jouvin <jouvin@lal.in2p3.fr>
Subject: Re: svn:externals using git submodules
Date: Wed, 20 Jan 2010 13:58:18 +0000 (UTC)
Message-ID: <loom.20100120T145348-193@post.gmane.org>
References: <200705011121.17172.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 14:58:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXb56-0004FJ-0f
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 14:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab0ATN6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 08:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922Ab0ATN6o
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 08:58:44 -0500
Received: from lo.gmane.org ([80.91.229.12]:44297 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220Ab0ATN6n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 08:58:43 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NXb4y-0004Bd-89
	for git@vger.kernel.org; Wed, 20 Jan 2010 14:58:40 +0100
Received: from pc-88066.lal.in2p3.fr ([134.158.88.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 14:58:40 +0100
Received: from jouvin by pc-88066.lal.in2p3.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 14:58:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 134.158.88.66 (Opera/9.80 (Windows NT 6.0; U; fr) Presto/2.2.15 Version/10.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137550>

Andy Parkins <andyparkins <at> gmail.com> writes:

> 
> Hello,
> 
> I've done this by hand as a proof of concept I suspect it would need loads of 
> work in git-svn to do it properly.  However, I thought I'd mention as part of 
> my "success with submodules" reports.
> 
> ... 
> Now we want that clone to be even more strongly linked to the parent - to the 
> extent that they share the same refs, etc:
> 
>  $ cd libswscale
>  $ rm -rf .git/refs .git/logs .git/info description config
>  $ ln -s ../../.git/refs .git/refs
>  $ ln -s ../../.git/logs .git/logs
>  $ ln -s ../../.git/info .git/info
>  $ ln -s ../../.git/config .git/config
>  $ ln -s ../../.git/description .git/description
> 
> ...
> Andy

I don't know if it's a good idea to follow-up on such an old entry... but I 
used your trick, Andy, and it works pretty well. With one exception: I am using 
Git on Windows and there is no symlinks on this OS. That means that you need to 
basically "recreate" the symlinks everytime you want to update the submodules. 
Not very handy but acceptable as they are not updated very often.

I have to check the list if there has been some new ways to achieve this. But 
I'm clearly in the case of svn:externals not tighten to a particular revision, 
which seems the difficult case for Git.

Cheers,

Michel
