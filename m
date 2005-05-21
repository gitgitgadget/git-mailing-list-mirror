From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [RFC] git-fsck-cache argument processing
Date: Sat, 21 May 2005 20:49:09 +0200
Message-ID: <20050521184909.GA1729@dspnet.fr.eu.org>
References: <4870.10.10.10.24.1116646732.squirrel@linux1> <20050521150926.GA96606@dspnet.fr.eu.org> <2015.10.10.10.24.1116696150.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:49:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZZ1Y-00071J-9y
	for gcvg-git@gmane.org; Sat, 21 May 2005 20:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVEUStP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 14:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVEUStP
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 14:49:15 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:62212 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261770AbVEUStM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2005 14:49:12 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 33A7C34D22; Sat, 21 May 2005 20:49:09 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <2015.10.10.10.24.1116696150.squirrel@linux1>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, May 21, 2005 at 01:22:30PM -0400, Sean wrote:
> Both of these options are generated automatically by argp.

I see.  Then I'll guess I'll have to put argp in the "crap" pile next
to libtool and automake.


> I'm sure there
> is a way to override them, but i'd rather just leave them as given by
> argp.  For the first case, if you try '-h' on the command line you get:
> 
> $ git-fsck-cache -h
> git-fsck-cache: invalid option -- h
> Try `git-fsck-cache --help' or `git-fsck-cache --usage' for more information.
> 
> So it leads to the proper help message.

How neat.  Of course using the right option under (t)csh gives:

galibert@m62:~ #201 >git-fsck-cache -?
git-fsck-cache: No match.

Importing this windowism is beyond stupid.

  OG.
