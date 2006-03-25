From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: Effective difference between git-rebase and git-resolve
Date: Sat, 25 Mar 2006 11:08:11 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne2a94r.cp6.mdw@metalzone.distorted.org.uk>
References: <20060325035423.GB31504@buici.com> <Pine.LNX.4.64.0603242014160.15714@g5.osdl.org> <20060325043507.GA14644@buici.com> <7v1wwrys07.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0603251034550.14457@wbgn013.biozentrum.uni-wuerzburg.de>
X-From: git-owner@vger.kernel.org Sat Mar 25 12:08:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN6d4-0004Du-Jr
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 12:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWCYLIO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 06:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWCYLIO
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 06:08:14 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:31560 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751168AbWCYLIO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 06:08:14 -0500
Received: (qmail 19826 invoked by uid 110); 25 Mar 2006 11:08:11 -0000
To: git@vger.kernel.org
Received: (qmail 19813 invoked by uid 9); 25 Mar 2006 11:08:11 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1143284891 18623 172.29.199.2 (25 Mar 2006 11:08:11 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Sat, 25 Mar 2006 11:08:11 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17980>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> I am nowhere near kernel people, but I am using git on a machine where it 
> is too cumbersome to install python. If git-resolve goes, I am without a 
> merge strategy (at least until git-recursive is ported to C... was that 
> not the plan with git-merge-tree? What happened on that front?).

Err... git-resolve isn't the same as git-merge-resolve.  The latter is a
stupid merge strategy which fits into the git-merge/git-pull
infrastructure.  The former is a different program which does merges
badly, and you didn't want to use it even if you don't have Python!

I'd forgotten all about git-resolve until it got mentioned just now.

-- [mdw]
