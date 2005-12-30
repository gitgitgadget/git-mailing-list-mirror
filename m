From: John Ellson <ellson@research.att.com>
Subject: Re: [PATCH] Make GIT-VERSION-GEN tolerate missing git describe command
Date: Fri, 30 Dec 2005 14:31:56 -0500
Message-ID: <dp41ve$v7r$1@sea.gmane.org>
References: <dp3mtp$rfm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 30 20:32:55 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsPzU-0001jc-Tr
	for gcvg-git@gmane.org; Fri, 30 Dec 2005 20:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVL3Tcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Dec 2005 14:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVL3Tcb
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Dec 2005 14:32:31 -0500
Received: from main.gmane.org ([80.91.229.2]:36046 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751295AbVL3TcO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Dec 2005 14:32:14 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EsPz0-0001bQ-HJ
	for git@vger.kernel.org; Fri, 30 Dec 2005 20:32:11 +0100
Received: from h-135-207-24-103.research.att.com ([135.207.24.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Dec 2005 20:32:10 +0100
Received: from ellson by h-135-207-24-103.research.att.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Dec 2005 20:32:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: h-135-207-24-103.research.att.com
User-Agent: Mail/News 1.5 (X11/20051129)
In-Reply-To: <dp3mtp$rfm$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14117>

John Ellson wrote:
> I think it is probably a bug that "git non_existent_command"
> returns its error message to stdout without an error, where
> "git-non_existent_command" behaves differently and does return an
> error.

BTW.  Its the old shell-script version of "git" that fails to return an error on 
non_existent_commands.    The newer C version of "git" correctly returns an 
error code.

The reason that this is a sufficiently serious problem to require a fix is that 
the broken version of "git" is in the git-core-0.99.9a-2.fc5.i386.rpm that is 
currently in Fedora Core Extras development.

John
