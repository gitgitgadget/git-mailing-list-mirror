From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGit PATCH] IgnoreAction to add to .gitignore files
Date: Fri, 24 Apr 2009 01:08:27 +0200
Message-ID: <200904240108.27610.robin.rosenberg@dewire.com>
References: <20090423115042.743E6D9CDC@apple.int.bandlem.com> <200904232309.28680.robin.rosenberg@dewire.com> <C4403889-A699-4138-9AD5-EE04915657B7@bandlem.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Alex Blewitt <alex@bandlem.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 01:10:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx83l-0005cO-Qw
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 01:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760721AbZDWXIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 19:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759783AbZDWXId
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 19:08:33 -0400
Received: from mail.dewire.com ([83.140.172.130]:24479 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758389AbZDWXIc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 19:08:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B438914927D1;
	Fri, 24 Apr 2009 01:08:30 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wc6pDEdPkL57; Fri, 24 Apr 2009 01:08:30 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 2F36814927C8;
	Fri, 24 Apr 2009 01:08:30 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.27-14-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <C4403889-A699-4138-9AD5-EE04915657B7@bandlem.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117395>

torsdag 23 april 2009 23:12:40 skrev Alex Blewitt <alex@bandlem.com>:
> 
> On 23 Apr 2009, at 22:09, Robin Rosenberg wrote:
> 
> > torsdag 23 april 2009 22:36:49 skrev Alex Blewitt <alex@bandlem.com>:
> >> I don't know of any other SCM that allows you to un-ignore files in
> >> the way that Git does; my guess is that most people wouldn't miss it
> >> if it weren't there. A .gitignore customised editor is probably
> >> overkill too - after all, you can just open it up in a text editor  
> >> and
> >> make changes yourself. I've amended a few .cvsignore files in my time
> >> manually, but I wouldn't want to overcomplicate the menu for that.
> >
> > Why do we want a plugin for git? We have the command line.
> 
> I mean, it's trivial to open up the .gitignore file in Eclipse as a  
> text file. I was doing that to check the implementation worked whilst  
> adding entries to the .gitignore.
> 
> I've seen all manner of bad UIs in applications created because the  
> developer wanted 'total flexibility' and exposed everything via the  
> UI. For something as simple as ignoring a file, which is already a  
> pretty standardised operation across SCMs, I don't see any benefit in  
> making it more complicated than it needs to be.

A bad GUI is worse than no GUI, so we don't want that. We're not that
desperate.

-- robin
