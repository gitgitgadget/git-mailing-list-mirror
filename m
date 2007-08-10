From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Problem with http-repos vs filesys-remote-repos
Date: Fri, 10 Aug 2007 01:04:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708100101570.26697@beast.quantumfyre.co.uk>
References: <428b865e0708091640x715a5950x128da5da493cef2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Evan Carroll <me@evancarroll.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 02:04:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJHzd-00038z-Pe
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 02:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755844AbXHJAEj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 20:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755669AbXHJAEj
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 20:04:39 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:40725 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754762AbXHJAEi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 20:04:38 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 7D4A2103402
	for <git@vger.kernel.org>; Fri, 10 Aug 2007 01:04:36 +0100 (BST)
Received: (qmail 25434 invoked by uid 103); 10 Aug 2007 01:04:36 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3869. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.03109 secs); 10 Aug 2007 00:04:36 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 10 Aug 2007 01:04:36 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <428b865e0708091640x715a5950x128da5da493cef2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55488>

On Thu, 9 Aug 2007, Evan Carroll wrote:

> A disclaimer:: I could have mucked with anything, I will not place the
> blame on git as if I had strictly adhered to the tutorial
> instructions. Anything I did was through the UI, there was no mucking
> with files. Thanks in advance and good luck:
>
> I have one repos located on /var/git/scraper.git, it houses a
> small-inhouse project which I'm trying to use to sell git with.
> Unfortunately, I've had a very difficult time doing everything with
> git. Namely, pulling and pushing. It appears as if I git-clone this
> using the file-system (fs) addressing I get a repos which `git log`
> shows was last modified on Aug 9th. However, if I check this out with
> a git-clone using apache, which is simply hosting
> /var/git/scraper.git, I get a repos which was last updated on aug 7th
> - thus it is missing *a lot* of devel time. Now the 7th was when I
> created the --bare repos from my working directory git. All of the
> gits involved are using the latest stable version 1.5.2.4, they all
> built cleanly. The log is as follows:

Have you enabled the post-update hook on your server (chmod +X 
/var/git/scraper.git/hooks/post-update)?  You need to run "git 
update-server-info" after updating a repo to allow clones via http to work 
properly.  The default post-update hook does this for you.

-- 
Julian

  ---

No, I do not know what the Schadenfreude is.  Please tell me, because
I'm dying to know.

 		-- Homer Simpson
 		   When Flanders Failed
