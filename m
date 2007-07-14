From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: mtimes of working files
Date: Sat, 14 Jul 2007 23:36:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707142331380.14090@beast.quantumfyre.co.uk>
References: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com>
 <Pine.LNX.4.64.0707111940080.4516@racer.site> <20070711202615.GE3069@efreet.light.src>
 <200707120857.53090.andyparkins@gmail.com> <1184261246.31598.139.camel@pmac.infradead.org>
 <20070713003700.GA21304@thunk.org> <1184367619.2785.58.camel@shinybook.infradead.org>
 <alpine.LFD.0.999.0707131617270.20061@woody.linux-foundation.org>
 <1184370414.2785.79.camel@shinybook.infradead.org> <20070714222221.GB3678@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jul 15 00:36:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9qDq-0003Sx-OQ
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 00:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758905AbXGNWgG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 18:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754965AbXGNWgF
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 18:36:05 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:35807 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753509AbXGNWgE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jul 2007 18:36:04 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 6FF01C6108
	for <git@vger.kernel.org>; Sat, 14 Jul 2007 23:36:01 +0100 (BST)
Received: (qmail 27170 invoked by uid 103); 14 Jul 2007 23:36:01 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.3/3665. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.03287 secs); 14 Jul 2007 22:36:01 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 14 Jul 2007 23:36:00 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070714222221.GB3678@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52514>

On Sun, 15 Jul 2007, Jan Hudec wrote:

> I would like, if git could have something like "checkouts". The idea is, that
> a checkout would contain the working tree, .git/HEAD saying what revision it
> is at and .git/index and everything else would be linked from the repository
> it is checked out from. That would allow you to have different branches
> checked out at different places, while not only sharing all the data, but
> also all of them available in all the checkouts and commands like pull
> updating it in all of them.
>
> It would be IMHO possible to symlink all the stuff in .git except HEAD and
> index, except for one problem. This is if you have two checkouts from the
> same branch and check out of them, the other one needs to know, that it's
> head should now be detached to stay where it was.

You basically just described what the git-new-workdir script in 
contrib/workdir does ... it doesn't address the issue of reference 
updating.

-- 
Julian

  ---
Most people's favorite way to end a game is by winning.
