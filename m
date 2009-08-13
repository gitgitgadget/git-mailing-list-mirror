From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] gitk: parse arbitrary commit-ish in SHA1 field
Date: Thu, 13 Aug 2009 21:54:40 +1000
Message-ID: <19075.65280.288895.139503@cargo.ozlabs.ibm.com>
References: <7vtz0fndak.fsf@alter.siamese.dyndns.org>
	<c3c4afa39354da6df5a0b17ee43eb4e8dfcfb099.1250148240.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 13 13:55:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbYtx-00029A-BK
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 13:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbZHMLzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 07:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753589AbZHMLzO
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 07:55:14 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:47111 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbZHMLzK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 07:55:10 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id 1151EB7067; Thu, 13 Aug 2009 21:55:08 +1000 (EST)
In-Reply-To: <c3c4afa39354da6df5a0b17ee43eb4e8dfcfb099.1250148240.git.trast@student.ethz.ch>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125805>

Thomas Rast writes:

> We only accepted either SHA1s or heads/tags that have been read.  This
> meant the user could not, e.g., enter HEAD to go back to the current
> commit.
> 
> Add code to call out to git rev-parse --verify with the string entered
> if all other methods of interpreting it failed.  (git-rev-parse alone
> is not enough as we really want a single revision.)
> 
> The error paths change slighly, because we now know from the rev-parse
> invocation whether the expression was valid at all.  The previous
> "unknown" path is now only triggered if the revision does exist, but
> is not in the current view display.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Thanks, applied.

Paul.
