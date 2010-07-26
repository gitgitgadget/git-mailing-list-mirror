From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: Potential bug in gitweb 1.7.2
Date: Mon, 26 Jul 2010 05:27:54 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1007260508290.14251@dr-wily.mit.edu>
References: <4C4D152A.7050505@gmail.com> <20100726050849.GA16858@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: julio.lajara@alum.rpi.edu, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 11:33:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdK3Y-0008Bw-4H
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 11:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab0GZJc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 05:32:59 -0400
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:52352 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751755Ab0GZJc6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 05:32:58 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2010 05:32:58 EDT
X-AuditID: 1209190c-b7c0dae000000a0c-e0-4c4d551e98bb
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Brightmail Gateway) with SMTP id CD.77.02572.E155D4C4; Mon, 26 Jul 2010 05:27:58 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o6Q9RuxD020484;
	Mon, 26 Jul 2010 05:27:56 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6Q9RsxR021555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 26 Jul 2010 05:27:55 -0400 (EDT)
In-Reply-To: <20100726050849.GA16858@burratino>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Brightmail-Tracker: AAAAARVG8/s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151821>

On Mon, 26 Jul 2010, Jonathan Nieder wrote:
> Indeed, the rules for installation have changed with v1.7.2, so the 
> packaging may need to be adjusted[1] to match (see gitweb/INSTALL).  
> Please report this to the Ubuntu git team.
> 
> [1] e.g. http://repo.or.cz/w/debian-git/jrn.git/commit/ff41c31c5

Thanks for the report.  But, the 1.7.2-0ppa1 package in the git-core PPA 
was constructed by merging your jrn/for-gerrit branch (1.7.2~rc3-0.1, 
commit f84e1eb) with upstream v1.7.2, and updating 
debian/versions.upstream and debian/changelog.upstream.  It already 
includes that commit.

Indeed, when I install the gitweb 1.7.2-0ppa1 package, put some 
repositories into /var/cache/git, and go to http://localhost/gitweb/ , it 
works correctly for me.

The error that Julio originally posted:

> > [Sat Jul 24 23:11:41 2010] [error] [client 192.168.1.100] Can't call 
> > method "http" on an undefined value at /usr/share/gitweb/index.cgi 
> > line 3401., referer: http://192.168.1.142/gitweb/

looks very strange, and does not seem like it would result from just a 
packaging problem.

Anders
