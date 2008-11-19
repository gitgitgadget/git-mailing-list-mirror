From: Miles Bader <miles@gnu.org>
Subject: Re: Git commit won't add an untracked file given on the command line
Date: Wed, 19 Nov 2008 10:21:19 +0900
Message-ID: <87tza41pf4.fsf@catnip.gol.com>
References: <20081118211237.234d8035@crow>
	<200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow>
	<alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Burton <markb@ordern.com>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:39:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2c2l-00051l-WB
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 02:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbYKSBie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 20:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbYKSBid
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 20:38:33 -0500
Received: from smtp11.dentaku.gol.com ([203.216.5.73]:35591 "EHLO
	smtp11.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbYKSBid (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 20:38:33 -0500
X-Greylist: delayed 1022 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Nov 2008 20:38:33 EST
Received: from 218.231.109.191.eo.eaccess.ne.jp ([218.231.109.191] helo=catnip.gol.com)
	by smtp11.dentaku.gol.com with esmtpa (Dentaku)
	id 1L2bkw-0005bo-IN; Wed, 19 Nov 2008 10:21:22 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id DE41FDFC7; Wed, 19 Nov 2008 10:21:19 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
	(Johannes Schindelin's message of "Wed, 19 Nov 2008 02:07:41 +0100
	(CET)")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101302>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> It may be a traditional wart, but a helpful one.  Remember, you can also 
> say:
>
> 	git commit that/directory/
>
> I do _not_ want Git to add all untracked (and unignored) files in that 
> directory automatically.

I agree, but it would kinda handy to have an exception for files
explicitly named on the command line.

-Miles

-- 
Apologize, v. To lay the foundation for a future offense.
