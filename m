From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Sun, 7 Oct 2007 23:38:17 +0200
Message-ID: <20071007213817.GJ31659@planck.djpig.de>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 23:38:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iedpr-0006NX-MS
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 23:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbXJGVik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 17:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753492AbXJGVik
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 17:38:40 -0400
Received: from planck.djpig.de ([85.10.192.180]:1623 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295AbXJGVij (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 17:38:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id C8D1288231;
	Sun,  7 Oct 2007 23:38:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1pB5QR6xxJMN; Sun,  7 Oct 2007 23:38:29 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id BE41288232; Sun,  7 Oct 2007 23:38:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60222>

On Sun, Oct 07, 2007 at 03:23:59PM -0600, Elijah Newren wrote:
> The following set of instructions will duplicate my problem with a
> smaller repo; why is the local git repository bigger after running
> git-filter-branch rather than smaller as I'd expect?  I'm probably
> missing something obvious, but I have no idea what it is.

The usual suspect would be the reflog.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
