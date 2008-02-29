From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Google Summer of Code 2008
Date: Fri, 29 Feb 2008 12:47:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0802291241400.18516@reaper.quantumfyre.co.uk>
References: <200802262356.28971.jnareb@gmail.com> <20080228063621.GR8410@spearce.org>
 <alpine.LSU.1.00.0802281021070.22527@racer.site> <200802291304.16026.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org, John Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 14:23:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV5Cp-0001jO-AZ
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 14:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbYB2NWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 08:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbYB2NWm
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 08:22:42 -0500
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:42868 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753139AbYB2NWm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Feb 2008 08:22:42 -0500
X-Greylist: delayed 2060 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Feb 2008 08:22:41 EST
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 309EFEF7F5
	for <git@vger.kernel.org>; Fri, 29 Feb 2008 12:48:20 +0000 (GMT)
Received: (qmail 10343 invoked by uid 103); 29 Feb 2008 12:47:34 +0000
Received: from 212.159.54.234 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.029615 secs); 29 Feb 2008 12:47:34 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.datavampyre.co.uk with SMTP; 29 Feb 2008 12:47:34 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <200802291304.16026.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75535>

On Fri, 29 Feb 2008, Jakub Narebski wrote:

> * Git / Subversion Interoperability
>
>  The idea here is implement something in Git that speaks the Subversion
>  protocol on the wire, but uses Git as the backend storage. (This would
>  be like the existing git-cvsserver.)
>
>  There are two potential approaches:
>
>   1. git-svnserver
>   2. write a backend for Subversion
>
>  Goal: To be able to access git repository, at minimum read-only, from
>  a Subversion client, at least svn CLI.
>  Language: Open for proposal.
>  Suggested mentors:
>    Eric Wong (git-svn author)
>    Matthias Urlichs (git-svnimport author)
>  Notes: I don't think we could pass it as Subversion SoC project, but
>  I guess that we could ask for co-mentor for the Subversion protocol,
>  or Subversion backend part of this task.

FWIW: I have a partially implemented python git-svnserver that speaks the 
svn:// protocol ... so far I can checkout from a git repos using the svn 
client, and not much else.  It's been on the backburner for a while, but I 
had recently thought about revisiting it - but getting someone else to do 
the implementation works too ;)

-- 
Julian

  ---
"It's men like him that give the Y chromosome a bad name."
