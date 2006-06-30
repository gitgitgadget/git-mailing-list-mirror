From: Junio C Hamano <junkio@cox.net>
Subject: Re: Prepare "git-merge-tree" for future work
Date: Thu, 29 Jun 2006 19:04:20 -0700
Message-ID: <7vejx7mmaj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606281054470.3782@g5.osdl.org>
	<Pine.LNX.4.64.0606281401540.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 04:04:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw8Ms-0003vL-0I
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 04:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933140AbWF3CEX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 22:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWF3CEW
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 22:04:22 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:23452 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750787AbWF3CEW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 22:04:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630020421.EAPP8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 22:04:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606281401540.12404@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 28 Jun 2006 14:09:54 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22944>

Linus Torvalds <torvalds@osdl.org> writes:

> I punted on trying to use the proper git diff interfaces (they are very 
> tightly tied into the "diff_filespec" model - Junio, it might be nice if 
> there was some way to use them in a setting where that isn't necessarily 
> as natural).

I am not quite sure what you mean.  You have a sets of
filepairs, each of which is a pair of filespec, each of which
describes the blob.  And diff is about comparing them, possibly
after running rename detection, pickaxe filtering and such.  If
the merge-tree's internal representation for each blob is more
efficient or easier to use we could switch to use it as an
improved implementation of filespec but I do not think that is
what you meant, because I suspect that approach does not break
diff from the "model".  Care to elaborate a bit more please?
