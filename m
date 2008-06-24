From: Olivier Galibert <galibert@pobox.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 14:21:22 +0200
Message-ID: <20080624122122.GA57848@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 14:32:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB7hE-0007MV-JK
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 14:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbYFXMbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 08:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbYFXMbb
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 08:31:31 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:1192 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbYFXMba (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 08:31:30 -0400
X-Greylist: delayed 606 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jun 2008 08:31:30 EDT
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id E1009A4656; Tue, 24 Jun 2008 14:21:22 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86045>

On Tue, Jun 24, 2008 at 11:29:43AM -0000, David Jeske wrote:
> -- Jakub Narebski wrote:
> > If they are using '-f', i.e. force, they should know and be sure what
> > they are doing; it is not much different from 'rm -f *'.
> 
> Sure, no problem. I don't want the ability to "rm -f *". I'm raising my hand
> and saying "I don't want the power to do these things, so just turn off all the
> git commands that could be destructive and give me an alternate way to do the
> workflows I need to do". Just like a normal user on a unix machine doesn't run
> around with the power to rm -f /etc all the time, even though they may be able
> to su to root.

But you still have the power to /bin/rm -rf ~, which tends to have
worse results.  The root/user separation just tries to protect the
system's integrity from the user.  This is similar to git, whch tries
to protect the repository's integrity, which is not the same thing as
the contents.

--force exists because it is sometimes useful.  It you block it behind
some config setting, whoever is concerned will just change the config
when he needs the command and never change it back.  And windows, fsck
and other things of the kind pretty much ruined the efficiency of
confirmations before dangerous/destructive operations.  So there isn't
much left beside engaging your brain before using --force on a
command.

  OG.
