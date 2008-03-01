From: Sam Vilain <sam@vilain.net>
Subject: Re: Google Summer of Code 2008
Date: Sat, 01 Mar 2008 18:07:02 +1300
Message-ID: <47C8E476.7070105@vilain.net>
References: <200802262356.28971.jnareb@gmail.com> <20080228063621.GR8410@spearce.org> <alpine.LSU.1.00.0802281021070.22527@racer.site> <200802291304.16026.jnareb@gmail.com> <47C8A3D5.9050309@vilain.net> <alpine.LSU.1.00.0803010102000.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org, John Hawley <warthog9@kernel.org>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 01 06:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVJv1-00019k-DB
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 06:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbYCAFEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 00:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbYCAFEv
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 00:04:51 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:58739 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbYCAFEu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 00:04:50 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id 44E3221D21E; Sat,  1 Mar 2008 18:04:44 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id D279E21D21A;
	Sat,  1 Mar 2008 18:04:39 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <alpine.LSU.1.00.0803010102000.22527@racer.site>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75610>

Johannes Schindelin wrote:
>> Funnily enough, I'm actually a possible /student/ this year - I'm
>> studying full-time this year - not in Computer Science, but hey that's
>> not a requirement ;-), and perhaps finishing my GitTorrent
>> implementation in my breaks would be a nice way to earn US$5k.
> 
> You have my vote.  If this works out, I will be your mentor.  As you know, 
> I will not be easy to work with, but the outcome will be pleasing to you 
> _and_ me.
> 
> I think GitTorrent is a really interesting project.  And since I do not 
> have time to do it myself, I would really appreciate this to be a GSoC 
> project, preferably a successful one (which is the reason I am willing to 
> mentor it).

Excellent, well that was going to be the next question - who would be
the mentor, and what would they do?

I guess I could re-work this RFP to be a proposal to complete it;

  http://utsl.gen.nz/git/gittorrent-rfp.txt

So far, the first two milestones on the plan are basically nailed, so
that's something of a head start.  The test script fires up two nodes
that connect to each other, sends a choke message and then shuts down.
I'm quite happy with the stack being used (Moose - which is CLOS for
Perl, and Coro - coroutines, similar to stackless python).  How about I
brush that up and we can take this discussion off-list.

Sam.
