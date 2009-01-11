From: Andi Kleen <andi@firstfloor.org>
Subject: Re: current git kernel has strange problems during bisect
Date: Sun, 11 Jan 2009 21:29:20 +0100
Message-ID: <87tz85fuxr.fsf@basil.nowhere.org>
References: <200901111602.53082.borntraeger@de.ibm.com>
	<200901111607.59054.borntraeger@de.ibm.com>
	<alpine.DEB.1.00.0901111613250.3586@pacific.mpi-cbg.de>
	<200901111620.03345.borntraeger@de.ibm.com>
	<alpine.LFD.2.00.0901111113150.6528@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 11 21:31:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6xl-0004t3-7r
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbZAKU3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbZAKU3t
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:29:49 -0500
Received: from one.firstfloor.org ([213.235.205.2]:35672 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbZAKU3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:29:48 -0500
Received: from basil.firstfloor.org (p5B3C9021.dip0.t-ipconnect.de [91.60.144.33])
	by one.firstfloor.org (Postfix) with ESMTP id CF5DB1AD0021;
	Sun, 11 Jan 2009 21:44:12 +0100 (CET)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 031A63E6657; Sun, 11 Jan 2009 21:29:20 +0100 (CET)
In-Reply-To: <alpine.LFD.2.00.0901111113150.6528@localhost.localdomain> (Linus Torvalds's message of "Sun, 11 Jan 2009 11:13:30 -0800 (PST)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105221>

Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> For bisect purposes, if you know you're not chasing down a btrfs issue, 
> you can do
>
> 	git bisect good 34353029534a08e41cfb8be647d734b9ce9ebff8

Could you perhaps add some standard tag for that commit? That 
would make it easier than to always find the exact btrfs commit.

Just an idea.

-Andi

-- 
ak@linux.intel.com
