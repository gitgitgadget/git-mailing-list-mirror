From: RIceball LEE <snowyu.lee@gmail.com>
Subject: Re: git svn problem, probably a regression
Date: Wed, 20 Feb 2013 22:13:54 +0000 (UTC)
Message-ID: <loom.20130220T231216-271@post.gmane.org>
References: <36370AA5-4BB9-4D36-95A7-BB3DA315C9E6@googlemail.com> <20121108180657.GM15560@sigill.intra.peff.net> <loom.20121109T143454-821@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 00:30:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8fai-0000T0-Qx
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 00:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755502Ab3BUX3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 18:29:52 -0500
Received: from plane.gmane.org ([80.91.229.3]:55085 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755464Ab3BUX3v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 18:29:51 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U8faW-0000Hz-Qe
	for git@vger.kernel.org; Fri, 22 Feb 2013 00:30:04 +0100
Received: from 113.205.12.176 ([113.205.12.176])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 00:30:04 +0100
Received: from snowyu.lee by 113.205.12.176 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 00:30:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 113.205.12.176 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.57 Safari/537.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216807>

Joseph Crowell <joseph.w.crowell <at> gmail.com> writes:

> 
> > > Use of uninitialized value $u in substitution (s///) at
> /usr/local/Cellar/git/1.8.0/lib/Git/SVN.pm
> > line 106.
> > > Use of uninitialized value $u in concatenation (.) or string at
> > /usr/local/Cellar/git/1.8.0/lib/Git/SVN.pm line 106.
> > > refs/remotes/svn/asset-manager-redesign: 'svn+ssh://<IP address>' not found
> in ''
> 
> > 
> > If you have time and can reproduce the bug at will, it would be very
> > helpful to use "git-bisect" to pinpoint the exact commit that causes the
> > breakage.
> > 
> > -Peff
> > 
> 
> I just encountered the exact same issue while converting an svn repo to git on
> Windows through Git Bash. Same error.
> 
> 


me too:

git svn fetch
Found possible branch point: 
https://amanda.svn.sourceforge.net/svnroot/amanda/amanda/branches/amanda-260 => 
https://amanda.svn.sourceforge.net/svnroot/amanda/amanda/tags/amanda260p1, 1022
Use of uninitialized value $u in substitution (s///) at 
/usr/local/Cellar/git/1.8.1.3/lib/Git/SVN.pm 
line 106.
Use of uninitialized value $u in concatenation (.) or string at 
/usr/local/Cellar/git/1.8.1.3/lib/Git/SVN.pm line 106.
refs/remotes/svn/amanda-260: 'https://amanda.svn.sourceforge.net/svnroot/amanda' 
not found 
in ''
