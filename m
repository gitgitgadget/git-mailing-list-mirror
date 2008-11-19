From: Miles Bader <miles@gnu.org>
Subject: Re: Git commit won't add an untracked file given on the command line
Date: Wed, 19 Nov 2008 12:43:04 +0900
Message-ID: <buomyfwmldj.fsf@dhapc248.dev.necel.com>
References: <20081118211237.234d8035@crow>
	<200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow>
	<alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
	<87tza41pf4.fsf@catnip.gol.com>
	<alpine.DEB.1.00.0811190238360.30769@pacific.mpi-cbg.de>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Burton <markb@ordern.com>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 19 04:44:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2dzh-0007Mx-1S
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 04:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbYKSDnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 22:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbYKSDnX
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 22:43:23 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:63086 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbYKSDnW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 22:43:22 -0500
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id mAJ3guZB023024;
	Wed, 19 Nov 2008 12:43:05 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay11.aps.necel.com with ESMTP; Wed, 19 Nov 2008 12:43:05 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay11.aps.necel.com with ESMTP; Wed, 19 Nov 2008 12:43:05 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 417563BD; Wed, 19 Nov 2008 12:43:05 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <alpine.DEB.1.00.0811190238360.30769@pacific.mpi-cbg.de>
	(Johannes Schindelin's message of "Wed, 19 Nov 2008 02:39:27 +0100
	(CET)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101312>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> I agree, but it would kinda handy to have an exception for files 
>> explicitly named on the command line.
>
> Only if you do not have a clear picture of what the staging area is about, 
> IMHO.

That's such a vague statement, I've not sure how to take it.

I use the staging area a lot, so I think I have a pretty clear idea of what
it's "about", but I also often use "commit FILE" or "commit -a" for simple
cases; even when splitting a change into multiple commits, it's often more
convenient to do "commit FILE..." instead of "add FILE; commit".

I agree that having "commit DIR" add new files would likely be more
annoying than helpful (it's not uncommon to have some temporary files
laying around), but given that "commit FILE" is _explicitly_ naming the new
file, it seems hard to imagine somebody would be surprised if it worked
even when FILE was a new file...

-Miles

-- 
=====
(^o^;
(()))
*This is the cute octopus virus, please copy it into your sig so it can spread.
