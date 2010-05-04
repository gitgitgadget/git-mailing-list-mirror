From: magnuspalmer <magnus.palmer@jayway.com>
Subject: Re: Migrating from subversion via git svn contains log entry, but
 not  the file change in the branch.
Date: Tue, 4 May 2010 08:20:59 -0700 (PDT)
Message-ID: <1272986459810-5003868.post@n2.nabble.com>
References: <1272889536578-4997493.post@n2.nabble.com> <4BDEC3AE.90409@drmicha.warpmail.net> <p2g86ecb3c71005030552odafaa805ob43f7f0c8a9be0b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 17:21:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Jvo-0004FF-CN
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 17:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933023Ab0EDPVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 11:21:00 -0400
Received: from kuber.nabble.com ([216.139.236.158]:38495 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491Ab0EDPVA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 11:21:00 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <magnus.palmer@jayway.com>)
	id 1O9Jvf-0001kd-QL
	for git@vger.kernel.org; Tue, 04 May 2010 08:20:59 -0700
In-Reply-To: <p2g86ecb3c71005030552odafaa805ob43f7f0c8a9be0b8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146316>



Dmitrijs Ledkovs-2 wrote:
> 
> 
> I've actually just edited .git/config and then did git svn init URL.
> Found this easier for complex layouts, cause then you can control
> everything that is happening.
> 
> [svn-remote "svn"]
>         url = http://mingw-w64.svn.sourceforge.net/svnroot/mingw-w64
>         fetch = trunk:refs/remotes/trunk
>         branches = {experimental,web}:refs/remotes/*
>         tags = branches/releases/*:refs/remotes/releases/*
>         fetch = :refs/remotes/git-svn
> 
> 

Tried this, produced different result though, but not a successful one.
-- 
View this message in context: http://git.661346.n2.nabble.com/Migrating-from-subversion-via-git-svn-contains-log-entry-but-not-the-file-change-in-the-branch-tp4997493p5003868.html
Sent from the git mailing list archive at Nabble.com.
