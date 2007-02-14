From: Junio C Hamano <junkio@cox.net>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 09:15:08 -0800
Message-ID: <7vhctor78j.fsf@assigned-by-dhcp.cox.net>
References: <17875.13564.622087.63653@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 18:15:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNis-0006bK-BH
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbXBNRPK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbXBNRPK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:15:10 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:33095 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbXBNRPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:15:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214171508.SNOI1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 12:15:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PVF81W00H1kojtg0000000; Wed, 14 Feb 2007 12:15:08 -0500
In-Reply-To: <17875.13564.622087.63653@lisa.zopyra.com> (Bill Lear's message
	of "Wed, 14 Feb 2007 10:12:44 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39692>

Bill Lear <rael@zopyra.com> writes:

> I then did a commit, and something went wrong:
>
> % git commit -a -m "Nuke CVS Id strings"
> error: Could not read ab66b31e390889e6bcbb2002111e2803c51f42b5
> error: unable to read tree object HEAD
> # On branch master
> error: Could not read ab66b31e390889e6bcbb2002111e2803c51f42b5
> error: unable to read tree object HEAD

Does 1.4.4 find that object?  What's in HEAD (cat .git/HEAD)?
What does "git fsck-objects --full" report?
