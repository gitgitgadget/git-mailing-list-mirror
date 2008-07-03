From: David Brown <git@davidb.org>
Subject: Re: Cherry picking instead of merges.
Date: Thu, 3 Jul 2008 15:39:49 -0700
Message-ID: <20080703223949.GA23092@old.davidb.org>
References: <20080703182650.GA11166@old.davidb.org> <alpine.LFD.1.10.0807031403380.2815@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 04 00:40:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEXTs-0002Xe-7Y
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 00:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901AbYGCWjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 18:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754884AbYGCWjv
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 18:39:51 -0400
Received: from mail.davidb.org ([66.93.32.219]:34595 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754518AbYGCWju (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 18:39:50 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KEXSv-000667-9K; Thu, 03 Jul 2008 15:39:49 -0700
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0807031403380.2815@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87331>

On Thu, Jul 03, 2008 at 02:18:53PM -0700, Linus Torvalds wrote:

>End result: you have a nice merge with nice history that actually 
>converges at a common point, but you effectively did the merge resolution 
>one commit at a time with cherry-picking (or "git rebase", which is 
>obviously just a convenient shorthand for cherry-picking everything).

I'm still not clear how the one-commit-at-a-time resolution gets recorded
anywhere (except in the cherry-picking branch).

It seems to be that I would need to do multiple merges, one at each point
where there is a conflict that I had to resolved.  I would remember this as
I did each cherry picked change, but after the fact, I would have to
compare the cherry picked change with the one it came from, and figure out
where conflicts had to be resolved.

Thanks,
David
