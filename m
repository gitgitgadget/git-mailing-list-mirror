From: Junio C Hamano <junkio@cox.net>
Subject: Re: git /objects directory created 755 by default?
Date: Tue, 20 Dec 2005 21:17:46 -0800
Message-ID: <7vzmmvc9l1.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	<7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
	<7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
	<46a038f90512201828w618a64dexc22a64b8b6bc2b70@mail.gmail.com>
	<7vacevdoti.fsf@assigned-by-dhcp.cox.net>
	<46a038f90512202115o652d8e00v86182302513d1319@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 06:19:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EowMo-0003kj-6V
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 06:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVLUFSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 00:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVLUFSD
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 00:18:03 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:60577 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751117AbVLUFRs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 00:17:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221051657.GPIJ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 00:16:57 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90512202115o652d8e00v86182302513d1319@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 21 Dec 2005 18:15:43 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13867>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Could git-shell also be used by a SourceForge-like project, offering
> per-developer git repositories? If they are using the (BSDish?)
> convention of not having a group per user this could backfire.

Fair enough.  And I realize that the initial umask should be
configurable by the administrator who prepares ssh accounts
somehow (I do not know exactly how though).
