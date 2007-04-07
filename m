From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/5] t1000: fix case table.
Date: Sat, 7 Apr 2007 14:01:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704071400190.27922@iabervon.org>
References: <7vbqi0ckpn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 20:26:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaFET-000369-BU
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 20:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966197AbXDGSBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 14:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966217AbXDGSBq
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 14:01:46 -0400
Received: from iabervon.org ([66.92.72.58]:2270 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966197AbXDGSBp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 14:01:45 -0400
Received: (qmail 25142 invoked by uid 1000); 7 Apr 2007 18:01:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Apr 2007 18:01:45 -0000
In-Reply-To: <7vbqi0ckpn.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43979>

On Sat, 7 Apr 2007, Junio C Hamano wrote:

> Case #10 is not handled with unpack-trees.c:threeway_merge()
> internally, unless under the agressive rule, and it is not a
> bug.  As the test expects, ND (one side did not do anything,
> other side deleted) case was meant to be handled by the caller's
> policy (e.g. git-merge-one-file or git-merge-recursive).

Looks like I neglected to update (or remove) that table; 
Documentation/technical/trivial-merge.txt agrees with your change.

	-Daniel
*This .sig left intentionally blank*
