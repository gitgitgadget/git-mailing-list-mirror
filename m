From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 01:48:13 +0200
Organization: At home
Message-ID: <eh6eft$roe$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<45349162.90001@op5.se>	<453536AE.6060601@utoronto.ca>	<200610172301.27101.jnareb@gmail.com>	<45354AD0.1020107@utoronto.ca>	<BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>	<45355CBB.80108@utoronto.ca>	<BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>	<eh64tk$rug$2@sea.gmane.org> <BAYC1-PASMTP069C473B2E79389E5BFC92AE0F0@CEZ.ICE> <eh6dgr$pu8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Thu Oct 19 01:48:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaL9M-00088A-0s
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 01:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423153AbWJRXsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 19:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423163AbWJRXsh
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 19:48:37 -0400
Received: from main.gmane.org ([80.91.229.2]:29083 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423153AbWJRXsg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 19:48:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GaL98-00085y-Sx
	for git@vger.kernel.org; Thu, 19 Oct 2006 01:48:26 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 01:48:26 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 01:48:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29301>

Charles Duffy wrote:

> Sean wrote:
>> You'll need a better example than that.  Git has supported a version
>> of Cygwin-compatible symlink support on Windows for quite some time.
>> And no plugins were needed.
> 
> The win32-compatible symlink support is not, in and of itself, the point.
> 
> The point is that core, pervasive functionality can be modified at 
> runtime, with no recompilation or installation of tools not included in 
> the bzr package itself, simply by dropping a directory into place. This 
> means that folks who don't have the skillset to merge three branches 
> together (say, upstream plus two different trees adding extra 
> functionality) and run a build can still install a few plugins to 
> enhance their copy of bzr (which was installed by their IT staff, or a 
> shiny click-through idiot-friendly Windows installer, etc).

You don't need plugins for that. Take for example git-svn (perhaps not the
best example, as it is Perl script; but Python although has compiled form
is script language at heart), which went AFAIK from external contribution,
to being in contrib/, to being in mainline (and in git-svn package).

About plugins modifying some core functionality: this is rather sign
of not attracting developers to do it in-core...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
