From: Joseph Crowell <joseph.w.crowell@gmail.com>
Subject: Re: git svn problem, probably a regression
Date: Fri, 9 Nov 2012 13:39:33 +0000 (UTC)
Message-ID: <loom.20121109T143454-821@post.gmane.org>
References: <36370AA5-4BB9-4D36-95A7-BB3DA315C9E6@googlemail.com> <20121108180657.GM15560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 14:45:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWotU-0007Su-0U
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 14:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244Ab2KINo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 08:44:58 -0500
Received: from plane.gmane.org ([80.91.229.3]:55854 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723Ab2KINo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 08:44:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TWotM-0007KV-2N
	for git@vger.kernel.org; Fri, 09 Nov 2012 14:45:04 +0100
Received: from 122.150.67.220 ([122.150.67.220])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 14:45:04 +0100
Received: from joseph.w.crowell by 122.150.67.220 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 14:45:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 122.150.67.220 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20100101 Firefox/16.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209217>

> > Use of uninitialized value $u in substitution (s///) at
/usr/local/Cellar/git/1.8.0/lib/Git/SVN.pm
> line 106.
> > Use of uninitialized value $u in concatenation (.) or string at
> /usr/local/Cellar/git/1.8.0/lib/Git/SVN.pm line 106.
> > refs/remotes/svn/asset-manager-redesign: 'svn+ssh://<IP address>' not found
in ''

> 
> If you have time and can reproduce the bug at will, it would be very
> helpful to use "git-bisect" to pinpoint the exact commit that causes the
> breakage.
> 
> -Peff
> 

I just encountered the exact same issue while converting an svn repo to git on
Windows through Git Bash. Same error.
