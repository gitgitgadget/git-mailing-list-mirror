From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.11
Date: Sun, 4 May 2008 21:02:04 +0200
Message-ID: <20080504190204.GA25329@diku.dk>
References: <20080406200533.GA20537@diku.dk> <481CD4E9.3080709@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Mon May 05 15:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt0zD-00033A-0j
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 15:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758489AbYEENnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 09:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755982AbYEENnW
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 09:43:22 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:33453 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758489AbYEENnU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 09:43:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 0552652C45D;
	Mon,  5 May 2008 15:43:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q1oKUfMVpOb7; Mon,  5 May 2008 15:43:17 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id A0B3052C328;
	Mon,  5 May 2008 14:51:13 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 3588B70F09B; Sun,  4 May 2008 21:00:01 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id ABB3F1DCDCF; Sun,  4 May 2008 21:02:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <481CD4E9.3080709@obry.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81281>

Hello Pascal,

Pascal Obry <pascal@obry.net> wrote Sat, May 03, 2008:
> I see that the '@' key can now move from chunk to chunk. This is nice but 
> it would be more user friendly if after staging a hunk the cursor was not 
> moved to the first line! I think it would be better to have the cursor on 
> top of the next hunk.

Great that you noticed.

About your suggestion, Jeff suggested something similar for the blame
view when jumping to parents ealier in this thread. I will put in the
TODO list an entry about adding a general mechanism for saving and
restoring states across reloads and refreshes.  The status and tree
views already have something like this and the stage and blame view are
good candidates as well. When the main view will support refreshing
there will be one more potential user.

-- 
Jonas Fonseca
