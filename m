From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Support config-based names
Date: Mon, 11 Jun 2007 22:28:08 -0700
Message-ID: <7vbqfln3mf.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706112244210.5848@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 07:28:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxyva-0007lT-Ly
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 07:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbXFLF2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 01:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbXFLF2L
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 01:28:11 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61669 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbXFLF2K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 01:28:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070612052809.XJWZ6565.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Jun 2007 01:28:09 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AVU81X0081kojtg0000000; Tue, 12 Jun 2007 01:28:09 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49921>

Daniel Barkalow <barkalow@iabervon.org> writes:

> It can be useful to refer to commits in remotes based on their configured 
> relationship to local branches. For example, "git log HEAD^[push]..HEAD" 
> would, when pushing is set up, show what hasn't been pushed yet.

It's not like we will be adding 'push' objects and 'merge'
objects, so I think HEAD^{push} (curly brace, not bracket) is
good enough.

We need to see how useful this would be in practice; we would
not want to add new syntax without a set of convincing use
cases.  At this point, it still feels as if it is a feature that
was implemented only because it could, not because there was a
real need.
