From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] git-reset <tree> -- <path> restores absense of <path> in <tree>
Date: Fri, 05 Jan 2007 03:09:20 -0800
Message-ID: <7v3b6phgrj.fsf@assigned-by-dhcp.cox.net>
References: <7vmz4xiz6t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701051128120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 12:09:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2mwv-0000nk-Di
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 12:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbXAELJW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 06:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbXAELJW
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 06:09:22 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36184 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161059AbXAELJW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 06:09:22 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105110921.DPMV29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Fri, 5 Jan 2007 06:09:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7P9c1W0051kojtg0000000; Fri, 05 Jan 2007 06:09:36 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701051128120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 5 Jan 2007 11:29:24 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35994>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Fri, 5 Jan 2007, Junio C Hamano wrote:
>
>>  * By the way, I noticed that "git log --diff-filter=A --
>>    t/t5401-update-hooks.sh" does not find the commit that
>>    introduced the path.  v1.4.1.1 seems to work but v1.4.2.4
>>    does not.  I haven't bisected it yet...
>
> It is this commit:
>
> 1798562: "log --raw: Don't descend into subdirectories by default"
>
> And sure enough,
>
> $ git log next -r --diff-filter=A -- t/t5401-update-hooks.sh
>
> works.

Soon after I accepted the patch, I had this exact reaction and
then after some digging I realized the workaround you showed
above.  And I forgot all of them X-<.  Silly me.
