From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK)] gitk: Make line origin search update the busy status.
Date: Fri, 14 Nov 2008 09:00:38 +1100
Message-ID: <18716.41862.32019.303080@cargo.ozlabs.ibm.com>
References: <200811132343.13910.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 23:02:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0kGK-0003Cf-0A
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 23:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbYKMWAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 17:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbYKMWAt
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 17:00:49 -0500
Received: from ozlabs.org ([203.10.76.45]:49149 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595AbYKMWAs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 17:00:48 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 9F85CDDDE0; Fri, 14 Nov 2008 09:00:46 +1100 (EST)
In-Reply-To: <200811132343.13910.angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100919>

Alexander Gavrilov writes:

> Currently the 'show origin of this line' feature does
> not update the status field of the gitk window, so it
> is not evident that any processing is going on. It may
> seem at first that clicking the item had no effect.
> 
> This commit adds calls to set and clear the busy
> status with an appropriate title, similar to other
> search commands.

I have been meaning to do this myself.  I want to find something
better than "Blaming" to put in the status field, though, since
"blaming" is jargon in this context.  Actually, "Searching" would
probably do.

Paul.
