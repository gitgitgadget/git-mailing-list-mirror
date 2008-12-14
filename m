From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Sending a threaded patch series with Evolution
Date: Sat, 13 Dec 2008 21:34:18 -0500
Message-ID: <1229222058.2838.22.camel@mattlaptop2.local>
References: <4ba6b6c3fc183002407f322663d7ab53c1c28a91.1229202740.git.matt@mattmccutchen.net>
	 <1229203007.31181.6.camel@mattlaptop2.local>
	 <m3ljujg2eh.fsf@localhost.localdomain>
	 <m3hc57g28b.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 03:35:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBgpb-00081A-LB
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 03:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbYLNCe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 21:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbYLNCe0
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 21:34:26 -0500
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:60300
	"EHLO jankymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751087AbYLNCe0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Dec 2008 21:34:26 -0500
Received: from [129.2.130.102] (129-2-130-102.wireless.umd.edu [129.2.130.102])
	by jankymail-a4.g.dreamhost.com (Postfix) with ESMTP id 02CE41810FA;
	Sat, 13 Dec 2008 18:34:24 -0800 (PST)
In-Reply-To: <m3hc57g28b.fsf@localhost.localdomain>
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103046>

On Sat, 2008-12-13 at 14:05 -0800, Jakub Narebski wrote: 
> By the way, your message [PATCH 2/2] should be threaded, i.e. be
> response to [PATCH 1/2] (or to cover letter [PATCH 0/2]), to not
> mistake it with other [PATCH 2/2] patches.

I'm using Evolution 2.24 as my mail client, and I have a wrapper script
"git draft-patch" that runs "git format-patch" and loads the patches
into my Evolution Drafts folder so I can look them over in the composer
and add non-commit-message text below the "---" if I wish before
sending.  I did pass --thread, but the composer changed the Message-Id,
breaking the threading.

I'll try to get this right in the future.  I can see two approaches to
doing so:

1. Check over / edit the patches in a text editor before loading them
into Drafts, and then send them by moving them directly to Outbox
(without using the composer) so that the Message-Id won't change.

2. Send the first patch, then manually edit the Message-Id Evolution
assigned it into the second patch, etc.

Neither of these approaches is particularly nice.  Does anyone have a
better idea?

-- 
Matt
