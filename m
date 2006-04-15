From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and Author files question
Date: Sat, 15 Apr 2006 14:58:50 -0700
Message-ID: <20060415215850.GB20468@hand.yhbt.net>
References: <m21wvzx5e6.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 23:58:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUsn8-000603-TW
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 23:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbWDOV6v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 17:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWDOV6v
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 17:58:51 -0400
Received: from hand.yhbt.net ([66.150.188.102]:24295 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S965160AbWDOV6v (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Apr 2006 17:58:51 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 9C5432DC01A; Sat, 15 Apr 2006 14:58:50 -0700 (PDT)
To: Seth Falcon <sethfalcon@gmail.com>
Content-Disposition: inline
In-Reply-To: <m21wvzx5e6.fsf@ziti.fhcrc.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18767>

Seth Falcon <sethfalcon@gmail.com> wrote:
> Hi all,
> 
> I've been using git to manually track changes to a project that uses
> svn as its primary SCM.
> 
> git-svn looks like it can help me streamline my workflow, but I'm
> getting stuck with the following:
> 
>     mkdir foo
>     cd foo
>     git-svn init $URL  <--- the svn URL
>     git-svn fetch
>     Author: dfcimm3 not defined in  file
> 
> :-(
> 
> Can someone point me to the file and the place that describes what I
> should put in it?  There are many committers to the svn project.  I'm
> hoping that I will not have to enumerate all of their names in some
> file.
> 
> I'm using git version 1.3.0.rc1.g40e9, and BTW, enjoying it very much.

There were some embarassing bugs between the git-svn in rc1 and rc2.
Current versions should work.  Rutger was right about the file format,
same as the other importers.

Sorry about so long to reply to questions this week, left hand/wrist is
wrecked.

@Pavel, Junio: I should have doc updates coming in hopefully in the next
few days, unless anybody wants to help :)

-- 
Eric Wong
