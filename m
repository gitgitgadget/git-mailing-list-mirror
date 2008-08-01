From: Theodore Tso <tytso@mit.edu>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 18:15:39 -0400
Message-ID: <20080801221539.GA8617@mit.edu>
References: <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <20080801124550.26b9efc0.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org> <20080801131127.20b3acfd.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org> <20080801132415.0b0314e4.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org> <20080801135421.5ca0f6af.akpm@linux-foundation.org> <7vvdykqub6.fsf@gitster.siamese.dyndns.org> <20080801145804.85041bbd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:17:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP2w2-0004vR-JA
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 00:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbYHAWQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 18:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753623AbYHAWQQ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 18:16:16 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:57896 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753319AbYHAWQP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 18:16:15 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KP2uS-0006QJ-LC; Fri, 01 Aug 2008 18:15:40 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KP2uR-0002j6-Rg; Fri, 01 Aug 2008 18:15:39 -0400
Content-Disposition: inline
In-Reply-To: <20080801145804.85041bbd.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91108>

On Fri, Aug 01, 2008 at 02:58:04PM -0700, Andrew Morton wrote:
> 
> I preserve the quotes (when present) in signoffs for this exact reason.
> 

Heh.  I include quotes in my Signed-off-by:

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Because I assumed the format of the DCO was an RFC-822 compliant
header format.  It otherwise *looks* like an RFC-822 format, so I
assumed it should follow all of the rules, including the ones about
quoting.

How about this as a compromise?  Git continues to store the names in
its internal format as it always does, but there is a configuration
option which controls whether the various Author: and Committer:
fields when displayd by git-log are in RFC-822 format or not.  

       	    	     		       	       - Ted
