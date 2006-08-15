From: Junio C Hamano <junkio@cox.net>
Subject: Re: external static var initialization
Date: Tue, 15 Aug 2006 00:14:21 -0700
Message-ID: <7vhd0ea2sy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608142309030.23498@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 09:14:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCt8R-0004gC-Q9
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 09:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbWHOHOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 03:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965270AbWHOHOo
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 03:14:44 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:50628 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965222AbWHOHOo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 03:14:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060815071422.ILZT29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Aug 2006 03:14:22 -0400
To: David Rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608142309030.23498@chino.corp.google.com> (David
	Rientjes's message of "Mon, 14 Aug 2006 23:10:44 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25440>

David Rientjes <rientjes@google.com> writes:

> Is there a plan to eliminate the ~100 unnecessary external static variable 
> initializations to 0 that occur in the code base?

No plan but there is no big patch pending that would conflict
with such so it probably is a good time to do so if you are
inclined to.
