From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk - fails to highlight commits
Date: Wed, 4 Jul 2007 22:02:46 +1000
Message-ID: <18059.35942.150086.936853@cargo.ozlabs.ibm.com>
References: <468AED7C.5040507@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Wed Jul 04 14:03:01 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I63ZU-0003dS-IP
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 14:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759448AbXGDMC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 08:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759339AbXGDMC4
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 08:02:56 -0400
Received: from ozlabs.org ([203.10.76.45]:39004 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759248AbXGDMCz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 08:02:55 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id C7CA5DDE45; Wed,  4 Jul 2007 22:02:49 +1000 (EST)
In-Reply-To: <468AED7C.5040507@verizon.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51600>

Mark Levedahl writes:

> Using gitk on master (281404ca1db4c921ac162f3c0 in the gitk) gitk's 
> highlighting is sporadic. Running gitk from a gitk sandbox and typing 
> 'gitk' into the 'Highlight Commits' box shows nothing highlighted, but 
> all commits should be highlighted. After doing this, many of the commits 
> revealed by scrolling down the list are highlighted, just not the ones 
> visisble at the top nor the first few below.

This is fixed by a commit I just pushed out ("gitk: Fix the find and
highlight functions").

Paul.
