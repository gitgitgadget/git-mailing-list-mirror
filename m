From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How to have multiple working copy directories use the same repository?
Date: Thu, 11 Oct 2007 21:00:25 +0200
Message-ID: <20071011190025.GC2804@steel.home>
References: <744844.82514.qm@web55015.mail.re4.yahoo.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Priest <priestwilliaml@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 21:00:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig3Gy-0000CT-6g
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 21:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379AbXJKTAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 15:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbXJKTAa
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 15:00:30 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:33487 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbXJKTAa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 15:00:30 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (fruni mo40) (RZmta 13.4)
	with ESMTP id L02dedj9BIwhSh ; Thu, 11 Oct 2007 21:00:25 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 44C4B277AE;
	Thu, 11 Oct 2007 21:00:25 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1B3C6C50A; Thu, 11 Oct 2007 21:00:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <744844.82514.qm@web55015.mail.re4.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60624>

Bill Priest, Thu, Oct 11, 2007 20:10:50 +0200:
>   I've looked at the "git for CVS users" section in
> the docs and this appears to create two repositories. 
> Is there a way to have two working directories that
> utilize the same repository?

Look for "alternates" in git's documentation. But read all the
warnings regarding git-gc and git-prune. Make a note of ".keep" files.

>   I'm betting that I'm just trying to push my workflow
> style onto git instead of adapting to the git way of
> doing things; but thought I would ask.

Git is flexible enough to accomodate almost any existing workflow.
Just some of them work better.
