From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: git-svn-import or CVS import from local HD rather than remote.
Date: Thu, 12 Jun 2008 13:20:40 -0600
Message-ID: <Pine.LNX.4.64.0806121315540.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806121214210.18454@xenau.zenez.com>
 <20080612185545.GN29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 21:21:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6sMa-0008Ge-1Y
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 21:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753AbYFLTUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 15:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754080AbYFLTUm
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 15:20:42 -0400
Received: from zenez.com ([166.70.62.2]:28939 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754075AbYFLTUl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 15:20:41 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id D29DAE7F89; Thu, 12 Jun 2008 13:20:40 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id BFED3E7E17;
	Thu, 12 Jun 2008 13:20:40 -0600 (MDT)
In-Reply-To: <20080612185545.GN29404@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84774>

On Thu, 12 Jun 2008, Miklos Vajna wrote:
> On Thu, Jun 12, 2008 at 12:36:43PM -0600, Boyd Lynn Gerber 
> <gerberb@zenez.com> wrote:
> > git-svnimport -C /working/git/project /master/svn/pub-svn/category/project
> 
> From RelNotes-1.5.4.txt:
> 
>  * "git svnimport" was removed in favor of "git svn".  It is still there
>    in the source tree (contrib/examples) but unsupported.
> 
> Try using git-svn.

Thanks, I was not sure which I should use,  I had tried both with similar 
results.  Here is what I used with git-svn

> git-svn clone /working/svn/networking/wireshark .
Initialized empty Git repository in .git/
Bad URL passed to RA layer: Unrecognized URL scheme for 
'/working/svn/networking/wireshark' at /usr/bin/git-svn line 934

It appears I am unable to use local repo's unless I have the setup to use 
via http.  I really would rather just take from my local working svn to 
git.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
