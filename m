From: Lars Noschinski <lars-2008-1@usenet.noschinski.de>
Subject: Re: git cvsimport and deleted files
Date: Sun, 20 Jul 2008 18:04:33 +0000 (UTC)
Message-ID: <20080720180432.GA30285@lars.home.noschinski.de>
References: <18563.10979.379533.580413@cargo.ozlabs.ibm.com> <alpine.DEB.1.00.0807201448020.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 20:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKdI6-0003My-3H
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 20:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757821AbYGTSEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 14:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757866AbYGTSEp
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 14:04:45 -0400
Received: from main.gmane.org ([80.91.229.2]:42347 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757815AbYGTSEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 14:04:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KKdH1-0005r3-2F
	for git@vger.kernel.org; Sun, 20 Jul 2008 18:04:43 +0000
Received: from xdsl-87-78-140-52.netcologne.de ([87.78.140.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 18:04:43 +0000
Received: from lars-2008-1 by xdsl-87-78-140-52.netcologne.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 18:04:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: xdsl-87-78-140-52.netcologne.de
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807201448020.3305@eeepc-johanness>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89204>

* Johannes Schindelin <Johannes.Schindelin@gmx.de> [08-07-20 14:49]:
>> I just tried importing the CVS repository for a long-running project
>> (ppp) into git using git cvsimport.  It looks like git cvsimport
>> doesn't notice when files have been deleted, so files that used to be
>> present and were subsequently deleted are present in the git tree for
>> the most recent commit.
>
>I never had that problem.  See 
>http://repo.or.cz/w/libvncserver.git?a=commit;h=8dead0759febaa7176507e1bde13ebd9d2a30720
>for a commit that was imported with cvsimport.
>
>So your issue must lie somewhere else.

I encountered such an issue some time ago in incremental mode, when
another person did some cvs branch stuff. The error persisted even as I
did a clean checkout, but disappeared, after I deleted all the cvsps
cache files.

I failed to report the error, because I had not much time for debugging
at that time and I would not have been able to publish the repository.

That's when I switched to fromcvs, which seems to work reliably so far (and
much faster), but requires a local repository.
