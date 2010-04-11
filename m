From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn "error": RA layer request failed: MERGE of [path]: 200
	OK
Date: Sat, 10 Apr 2010 18:04:20 -0700
Message-ID: <20100411010420.GC22778@dcvr.yhbt.net>
References: <D73B7319-8005-4AFD-AEB4-7EF9A446D869@koansys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Shenton <chris@koansys.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 03:04:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0lb8-0005Kk-6d
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 03:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab0DKBEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 21:04:21 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48964 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321Ab0DKBEV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 21:04:21 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA351F689;
	Sun, 11 Apr 2010 01:04:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <D73B7319-8005-4AFD-AEB4-7EF9A446D869@koansys.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144619>

Chris Shenton <chris@koansys.com> wrote:
> I'm using git svn to talk to an SVN repo accessed by https.  When I try to dcommit a change I get something which appears to be an error, but if I understand the reponse code it's talking about, it seems OK:
> 
> > $ git svn dcommit
> > Committing to https://koansys.com/svn/dha/buildout/branches/buildout_xdv ...
> > 	M	buildout.cfg
> > RA layer request failed: MERGE of '/Svn/dha/buildout/branches/buildout_xdv': 200 OK (https://koansys.com) at /usr/local/Cellar/git/1.6.6.1/libexec/git-core/git-svn line 564
> 
> I thought this one had failed, and tried again, but it indicated doing so was a merge conflict:
> > 
> > $ git svn dcommit
> > Committing to https://koansys.com/svn/dha/buildout/branches/buildout_xdv ...
> > Merge conflict during commit: File or directory 'buildout.cfg' is out of date; try updating: resource out of date; try updating at /usr/local/Cellar/git/1.6.6.1/libexec/git-core/git-svn line 564
> 
> Can anyone explain the first message? Is it a git problem, an svn problem, or something else?

Hi Chris,

Did somebody commit a conflicting change to the "buildout.cfg" file?
That looks like what happened.

-- 
Eric Wong
