From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add merge-subtree back
Date: Sun, 24 Feb 2008 01:19:55 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802240040010.19024@iabervon.org>
References: <7vprun32m2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 07:20:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTADz-0001wK-5X
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 07:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbYBXGT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 01:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbYBXGT5
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 01:19:57 -0500
Received: from iabervon.org ([66.92.72.58]:47301 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbYBXGT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 01:19:56 -0500
Received: (qmail 26282 invoked by uid 1000); 24 Feb 2008 06:19:55 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Feb 2008 06:19:55 -0000
In-Reply-To: <7vprun32m2.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74903>

On Sat, 23 Feb 2008, Junio C Hamano wrote:

> An earlier commit e1b3a2c (Build-in merge-recursive) made the
> subtree merge strategy backend unavailable.  This resurrects
> it.

That's really quite subtle. I think there should probably be a 
cmd_merge_subtree that shares almost everything with cmd_merge_recursive, 
but is a different function.

Or maybe there should be a "--subtree" option to merge that has that 
effect with arbitrary stratgeies by changing what gets sent to the 
strategy.

But restoring access to the strategy for now is obviously fine.

	-Daniel
*This .sig left intentionally blank*
