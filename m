From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Use git-difftool for external diffs
Date: Thu, 19 Nov 2009 20:03:31 +1100
Message-ID: <19205.2531.205062.980468@cargo.ozlabs.ibm.com>
References: <1258341126-2108-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 10:07:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB2yy-0006j1-JC
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 10:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbZKSJHC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 04:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbZKSJHC
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 04:07:02 -0500
Received: from ozlabs.org ([203.10.76.45]:43262 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbZKSJHA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 04:07:00 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 6C5A21007D3; Thu, 19 Nov 2009 20:07:06 +1100 (EST)
In-Reply-To: <1258341126-2108-1-git-send-email-davvid@gmail.com>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133218>

David Aguilar writes:

> This teaches gitk about git-difftool.  A benefit of this change is
> that gitk's external diff now works with read-only repositories.

What version of git does git difftool first appear in?  I prefer not
to introduce hard requirements on very recent versions of git into
gitk.

Paul.
