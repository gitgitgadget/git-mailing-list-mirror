From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries too.
Date: Mon, 4 Jun 2007 12:56:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706041254230.12665@reaper.quantumfyre.co.uk>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Bryan Childs <godeater@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 13:56:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvBB9-0003PL-Fb
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 13:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbXFDL4p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 07:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbXFDL4p
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 07:56:45 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:47635 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752689AbXFDL4o (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2007 07:56:44 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 032B4C6220
	for <git@vger.kernel.org>; Mon,  4 Jun 2007 12:56:42 +0100 (BST)
Received: (qmail 19147 invoked by uid 103); 4 Jun 2007 12:53:57 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3347. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.035777 secs); 04 Jun 2007 11:53:57 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 4 Jun 2007 12:53:57 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49095>

On Mon, 4 Jun 2007, Bryan Childs wrote:

> 2) Unlike the Linux Kernel, which Linus uses as a prime example of
> something git is very useful for, the Rockbox project has no central
> figurehead for anyone to consider as owning the "master" repository
> from which to build the "current" version of the Rockbox firmware for
> any given target.
>
> 3) With a central repository, for which we have a limited number of
> individuals having commit access, it's easy for us to automate a build
> based on each commit the repository receives.
>
> Given these three points, we wonder how we'd best achieve the same
> using git. As far as we can make out we'd need to appoint someone as a
> maintainer for a master repository whose job it is to co-ordinate
> pulls from people based on when they've made changes we wish to
> include in the latest version of our software. This sounds like a time
> consuming role for a project which is only staffed by volunteers.

You can setup git to work in a centralised style if you wish.

See http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html

-- 
Julian

  ---
If reporters don't know that truth is plural, they ought to be lawyers.
 		-- Tom Wicker
