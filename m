From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fmt-patch: understand old <his> notation
Date: Sat, 06 May 2006 18:28:38 -0700
Message-ID: <7vd5eqr5bt.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0605062252530.4155@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viroirfur.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0605062358280.6357@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 03:28:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcY4k-0004wV-Al
	for gcvg-git@gmane.org; Sun, 07 May 2006 03:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWEGB2k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 21:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWEGB2k
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 21:28:40 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:64152 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751159AbWEGB2j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 21:28:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060507012839.NSMA25692.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 May 2006 21:28:39 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605062358280.6357@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 7 May 2006 00:01:16 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19686>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> No, it is not too late. I did this patch only to prevent cluttering my 
> directory with millions of patches, only because I forgot _again_ to type 
> the two dots.

I did that as well, and the thing is, this is _so_ fast that
when I noticed and typed ^C, it already has done 400 or so
commits starting from the epoch (which was empty by the way).

I am already working on adjusting in-tree format-patch users not
to use <his> syntax but to use <his>.. syntax, so this should not
be a problem either way.

>> Also we probably would want to default the diff options to show
>> the root commit diff (rev.show_root_diff).

> I gather this is needed for git-am/git-rebase to continue working?

No, but people want to export the whole history sometimes.
