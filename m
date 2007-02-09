From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git rescue mission
Date: Thu, 08 Feb 2007 20:38:50 -0800
Message-ID: <7vps8kueqt.fsf@assigned-by-dhcp.cox.net>
References: <17866.27739.701406.722074@lisa.zopyra.com>
	<Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
	<17867.40122.51865.575762@lisa.zopyra.com>
	<Pine.LNX.4.64.0702081408140.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 09 05:38:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFNXC-00014O-PG
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 05:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946100AbXBIEiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 23:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946097AbXBIEiw
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 23:38:52 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:65217 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946100AbXBIEiv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 23:38:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070209043852.QHIJ4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Feb 2007 23:38:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MGeq1W0061kojtg0000000; Thu, 08 Feb 2007 23:38:50 -0500
In-Reply-To: <Pine.LNX.4.64.0702081408140.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 8 Feb 2007 14:13:47 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39154>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Considering how stable the -rc kernels are (and actually, git "master" in 
> general), there's really very little reason to wait for the real release. 
> Junio has been very careful, and I think a lot of the delay in 1.5 has 
> been about trying to get all the new stuff that changes semantics subtly 
> in before the release, so that Junio will not have to do any real user- 
> visible changes later.

Heh, I do not work on kernels ;-)

Seriously, I think you are giving me a bit too much credit, but
I do agree that the tip of "master" tends to be very stable most
of the time.  This is especially true since some tagged releases
were followed up with immediate corrections for "oops, brown
paper bag" bugs in the past X-<.

But the tip of "master" contains dubious change from time to
time (for example, I still haven't sorted out your "log -z"
stuff, which is already in my tree).
