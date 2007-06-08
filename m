From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: git-svn removes merge
Date: Fri, 08 Jun 2007 15:52:21 +0200
Organization: Transmode AB
Message-ID: <1181310741.30670.92.camel@gentoo-jocke.transmode.se>
References: <1181236096.30670.66.camel@gentoo-jocke.transmode.se>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 15:52:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwet7-0006u9-9I
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 15:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967291AbXFHNwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 09:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966579AbXFHNwY
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 09:52:24 -0400
Received: from mail.transmode.se ([83.241.175.147]:39862 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966403AbXFHNwX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 09:52:23 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 08 Jun 2007 15:52:21 +0200
In-Reply-To: <1181236096.30670.66.camel@gentoo-jocke.transmode.se>
X-Mailer: Evolution 2.8.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49477>

On Thu, 2007-06-07 at 19:08 +0200, Joakim Tjernlund wrote:
> If I do this:
> 
> git checkout --track -b svn remotes/trunk
> git checkout -b merge
> git-am ../mbox
> git checkout svn
> #edit Makefile and commit
> git-svn dcommit #Note 1
> git pull . merge
> git-svn dcommit
> 
> then git-svn dcommit removes the merge beteen svn and merge.
> git log svn..merge shows all the commits that git-am ../mbox added.
> 
> How do I avoid this?
> 
>  Jocke
> 
> Note 1:
>   If I skip this step then the last git-svn dcommit fails, why is that?
     Forgot to mention the error msg I get here:
Transaction is out of date: Out of date: '/trunk/board/tmcu/of-tmtu.dts'
in transaction '101-1' at /usr/bin/git-svn line 405

 Jocke
