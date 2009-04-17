From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git & ssh on F10 server
Date: Fri, 17 Apr 2009 17:19:04 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0904171716150.8346@reaper.quantumfyre.co.uk>
References: <489CF11BD65F439998B6CF3FCC610576@HPLAPTOP>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 18:21:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Luqox-0000Dw-BQ
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 18:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758813AbZDQQUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 12:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758809AbZDQQUF
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 12:20:05 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:42201 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757095AbZDQQUE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2009 12:20:04 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id CB752132859
	for <git@vger.kernel.org>; Fri, 17 Apr 2009 17:20:02 +0100 (BST)
Received: (qmail 23429 invoked by uid 103); 17 Apr 2009 17:19:04 +0100
Received: from darkphoton.datavampyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9248. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.036791 secs); 17 Apr 2009 16:19:04 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 17 Apr 2009 17:19:04 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <489CF11BD65F439998B6CF3FCC610576@HPLAPTOP>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116753>

On Fri, 17 Apr 2009, Aaron Gray wrote:

> Hi,
>
> we have a Fedora 10 server in SELinux enforcing mode setup running git-deamon 
> and gitweb (with home grown SElinux policy).
>
> Anyway now we find out you cannot do a 'push' over the basic git protocol, 
> back to the server repository.

You can push over git://, but you get no authentication mechanism so it's 
disabled by default.  It's only really useful if you trust everyone who 
has IP access to the server.

> So now am trying to get git to work over ssh. The repositories are located 
> /pub/git/*/.git
>
> Basic attempts using BerliOS'es instructions for client end failed.
>
>   http://developer.berlios.de/docman/display_doc.php?docid=1812&group_id=2
>
> Could someone please help us with this.
>
> Aaron

You haven't said what commands you tried, nor what the errors you received 
were, so it's a bit hard to say what went wrong ...

-- 
Julian

  ---
10.0 times 0.1 is hardly ever 1.0.
