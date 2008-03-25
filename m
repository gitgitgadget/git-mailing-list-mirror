From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Hand-rolling migration to Git
Date: Tue, 25 Mar 2008 11:39:19 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803251137580.10660@wbgn129.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0803251056570.8472@ds9.cixit.se> <200803251114.55673.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Mar 25 11:40:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je6Zp-0007xq-VD
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 11:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbYCYKjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 06:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753966AbYCYKjW
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 06:39:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:36272 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752375AbYCYKjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 06:39:21 -0400
Received: (qmail invoked by alias); 25 Mar 2008 10:39:20 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp018) with SMTP; 25 Mar 2008 11:39:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18E8St4F1QEJQTuXsmQHKh1AcBb55lSeXF/u+FqVR
	78M2wd63q3b/qv
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <200803251114.55673.johan@herland.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78174>

Hi,

On Tue, 25 Mar 2008, Johan Herland wrote:

> On Tuesday 25 March 2008, Peter Karlsson wrote:
> 
> > I am looking for documentation on how to hand-roll a conversion to 
> > Git, but I keep getting lost in the maze of similar-looking man pages. 
> > Is there a tutorial, howto, or perhaps even just a list of recommended 
> > man pages to read on importing project changes to Git?
> > 
> > I have projects of two different kinds that I need to import:
> > 
> > 1. The "make a copy of the source code directory and edit the new 
> >    copy"  source management system. I need to be able to import one 
> >    directory at a time, each describing a version controlled state. 
> >    The date stamp on the commits should probably be the most recent 
> >    file in each directory.
> > 
> > 2. A piece of software using PVCS (a RCS-like version control system 
> >    with added support for parallel development (using a locking 
> >    model)). I have a complete "trail file" which lists all commits 
> >    done to the repository in chronological order since the repository 
> >    was created, and can use that as a base. Since it has no concept of 
> >    an atomic commit, I need to semi-manually join commits by walking 
> >    the trail file and comparing lock sets, time stamps, commit 
> >    messages and authors.
> > 
> > I can probably make the output from (2) look like from (1), so I 
> > basically just need to find a pointer to information on how to 
> > (re-)create the history with Git.
> 
> Take a look at git-fast-import. It should be relatively easy to write a 
> small script that converts from either (1) or (2) to a stream of 
> git-fast-import commands.

Yeah.  To get inspiration how the scripts should look like, read 
contrib/fast-import/import-tars.perl, or look at 
http://repo.or.cz/w/fast-export.git

Hth,
Dscho
