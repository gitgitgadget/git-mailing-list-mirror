From: Wolfram Gloger <wmglo@dent.med.uni-muenchen.de>
Subject: Re: Something is broken in repack
Date: 14 Dec 2007 16:59:37 -0000
Message-ID: <20071214165937.6405.qmail@md.dent.med.uni-muenchen.de>
References: <alpine.LFD.0.9999.0712120826440.25032@woody.linux-foundation.org>
	<20071214161236.3080.qmail@md.dent.med.uni-muenchen.de> <85r6hptecs.fsf@lola.goethe.zz>
Cc: wmglo@dent.med.uni-muenchen.de, torvalds@linux-foundation.org,
	nico@cam.org, jonsmirl@gmail.com, gitster@pobox.com,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: dak@gnu.org
X-From: git-owner@vger.kernel.org Fri Dec 14 18:00:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3DtQ-0000s2-DH
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 18:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761288AbXLNQ7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 11:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758375AbXLNQ7k
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 11:59:40 -0500
Received: from md.dent.med.uni-muenchen.de ([138.245.179.2]:56404 "HELO
	md.dent.med.uni-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757623AbXLNQ7j (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 11:59:39 -0500
Received: (qmail 6406 invoked by uid 211); 14 Dec 2007 16:59:37 -0000
In-reply-to: <85r6hptecs.fsf@lola.goethe.zz> (message from David Kastrup on
	Fri, 14 Dec 2007 17:45:07 +0100)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68319>

Hi,

> Uh what?  Someone crank out his copy of "The Art of Computer
> Programming", I think volume 1.  Best fit is known (analyzed and proven
> and documented decades ago) to be one of the worst strategies for memory
> allocation.  Exactly because it leads to huge fragmentation problems.

Well, quoting http://gee.cs.oswego.edu/dl/html/malloc.html:

"As shown by Wilson et al, best-fit schemes (of various kinds and
approximations) tend to produce the least fragmentation on real loads
compared to other general approaches such as first-fit."

See [Wilson 1995] ftp://ftp.cs.utexas.edu/pub/garbage/allocsrv.ps for
more details and references.

Regards,
Wolfram.
