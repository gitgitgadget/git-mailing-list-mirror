From: jeffpc@josefsipek.net (Josef "Jeff" Sipek)
Subject: Re: Simple UI question...
Date: Sun, 7 Jan 2007 06:06:48 -0500
Message-ID: <20070107110648.GA20091@josefsipek.net>
References: <204011cb0701070302y54837c5bp967e2cddd3fb655d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 07 12:41:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3WP7-0007L5-VK
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbXAGLlb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbXAGLlb
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:41:31 -0500
Received: from mrs.stonybrook.edu ([129.49.1.206]:40805 "EHLO
	mrs.stonybrook.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932514AbXAGLla (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 06:41:30 -0500
X-Greylist: delayed 2077 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jan 2007 06:41:30 EST
Received: from relay1.stonybrook.edu (relay1 [172.30.255.13])
	by mrs.stonybrook.edu (8.13.8/8.13.6) with SMTP id l07B6ojk025255;
	Sun, 7 Jan 2007 06:06:50 -0500 (EST)
Received: from mailrelay.stonybrook.edu ([172.30.255.13])
 by relay1.stonybrook.edu (SMSSMTP 4.1.14.46) with SMTP id M2007010706065002196
 ; Sun, 07 Jan 2007 06:06:50 -0500
Received: from josefsipek.net (turing.ams.sunysb.edu [129.49.108.158])
	by mailrelay.stonybrook.edu (8.13.8/8.13.8) with ESMTP id l07B6mY6025252;
	Sun, 7 Jan 2007 06:06:50 -0500 (EST)
Received: by josefsipek.net (Postfix, from userid 1000)
	id DDC3E1C00EC6; Sun,  7 Jan 2007 06:06:48 -0500 (EST)
To: Chris Lee <clee@kde.org>
Content-Disposition: inline
In-Reply-To: <204011cb0701070302y54837c5bp967e2cddd3fb655d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36165>

On Sun, Jan 07, 2007 at 03:02:59AM -0800, Chris Lee wrote:
> Hey guys,
> 
> So I'm trying to figure out the best way to pull out a checkout of the
> entire tree as of a given revision ID. I have a whole bunch of
> revision IDs, and I'd like to know what the git equivalent of (say)
> the following is:
> 
> svn co -r280600 file:///path/to/svn/repo
> 
> For the sake of argument, let's say that r280600 imported as
> 07058310db903317faa300b93004a5a2e0fc2dcc into my git tree.
> 
> How do I get a pristine checkout in my working copy of the entire tree
> as the repository saw it at 07058310db903317faa300b93004a5a2e0fc2dcc?

I have great success with:

git-reset --hard $hash

Jeff.

-- 
#endif /* NO LIFE */
