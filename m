From: Pavel Roskin <proski@gnu.org>
Subject: Re: StGIT refreshes all added files - limitation of git-write-tree?
Date: Wed, 15 Feb 2006 04:06:17 -0500
Message-ID: <1139994377.5796.30.camel@dv>
References: <1139978528.28292.41.camel@dv>
	 <7vacctnnx4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 10:06:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9IcF-0006Ef-9E
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 10:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423056AbWBOJGW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 04:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423057AbWBOJGW
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 04:06:22 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:42645 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1423056AbWBOJGV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 04:06:21 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1F9Ic7-0001IJ-PU
	for git@vger.kernel.org; Wed, 15 Feb 2006 04:06:19 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1F9Ic5-00079s-Ka; Wed, 15 Feb 2006 04:06:18 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacctnnx4.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16224>

On Tue, 2006-02-14 at 22:20 -0800, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > Or maybe git-write-tree and other utilities could be changed to work on
> > a copy of the index file?  I would prefer not to move the
> > actual .git/index away, but to make a copy for the current "stg refresh"
> > operation.
> 
> There is no need to change the core side.  
> 
> 	GIT_INDEX_FILE=temporary-index git-write-tree
> 
> would do the job.  See the current round of git-commit and how
> it handles "git commit --only these files" case.

Thank you!  It's comforting to know that the issue is not unique to
StGIT.

-- 
Regards,
Pavel Roskin
