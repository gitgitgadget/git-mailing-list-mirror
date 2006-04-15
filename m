From: Rutger Nijlunsing <rutger@nospam.com>
Subject: Re: git-svn and Author files question
Date: Sat, 15 Apr 2006 11:25:10 +0200
Organization: M38c
Message-ID: <20060415092510.GA4539@nospam.com>
References: <m21wvzx5e6.fsf@ziti.fhcrc.org>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 11:25:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUh1t-0000MU-5W
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 11:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWDOJZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 05:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWDOJZR
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 05:25:17 -0400
Received: from post-23.mail.nl.demon.net ([194.159.73.193]:3033 "EHLO
	post-23.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1751611AbWDOJZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 05:25:16 -0400
Received: from wingding.demon.nl ([82.161.27.36]:58455)
	by post-23.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1FUh1j-000Kkm-Er; Sat, 15 Apr 2006 09:25:11 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.60)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1FUh1i-0002KH-Rn; Sat, 15 Apr 2006 11:25:10 +0200
To: Seth Falcon <sethfalcon@gmail.com>
Content-Disposition: inline
In-Reply-To: <m21wvzx5e6.fsf@ziti.fhcrc.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18736>

On Fri, Apr 14, 2006 at 01:34:57PM -0700, Seth Falcon wrote:
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

I'm not familiar with git-svn, but the $GIT_DIR/svn-authors file used
by git-svnimport.perl and
http://www.wingding.demon.nl/git-svnconvert.rb contains lines like:

svn-author = Full Name <email@domain>

And yes, you've got to enumerate the names you want
transformed. Another option is to give no authors, but then the SVN
author names will be used (with email 'unknown' or something).


-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
