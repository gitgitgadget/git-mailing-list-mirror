From: Ted Ts'o <tytso@mit.edu>
Subject: jk/tag-contains: stalled
Date: Wed, 4 Aug 2010 20:16:29 -0400
Message-ID: <20100805001629.GC2901@thunk.org>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 02:16:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogo8a-0007qT-Ma
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 02:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759522Ab0HEAQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 20:16:36 -0400
Received: from THUNK.ORG ([69.25.196.29]:58805 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758389Ab0HEAQc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 20:16:32 -0400
Received: from root (helo=tytso-glaptop)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1Ogo8N-0000qo-NV; Wed, 04 Aug 2010 20:16:31 -0400
Received: from tytso by tytso-glaptop with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1Ogo8M-0004F6-1U; Wed, 04 Aug 2010 20:16:30 -0400
Content-Disposition: inline
In-Reply-To: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152614>

On Wed, Aug 04, 2010 at 03:24:23PM -0700, Junio C Hamano wrote:
> 
> * jk/tag-contains (2010-07-05) 4 commits
>  - Why is "git tag --contains" so slow?
>  - default core.clockskew variable to one day
>  - limit "contains" traversals based on commit timestamp
>  - tag: speed up --contains calculation

What needs to be fixed up before this effort can graduate?  I find the
fixups here to be really helpful, even without the automated skew
detection that has been proposed.  And even if we fix the root problem
with some new all-singing pack format, I suspect that may be a ways
out, so it would be nice if these patches could get included for now....

     	   	    	    	  	  	- Ted
