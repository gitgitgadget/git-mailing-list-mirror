From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: revamp the git-commit semantics.
Date: Tue, 07 Feb 2006 21:41:37 -0800
Message-ID: <7vbqxiquem.fsf@assigned-by-dhcp.cox.net>
References: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550602050536j73f1091dq9afae232f574d0b4@mail.gmail.com>
	<7v64ntindq.fsf@assigned-by-dhcp.cox.net> <43E67745.2080302@gmail.com>
	<7voe1le71b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602071135110.5397@localhost.localdomain>
	<7vfymvvz1r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602071304160.5397@localhost.localdomain>
	<Pine.LNX.4.64.0602071412390.5397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 06:41:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6i5O-0004Kj-Dc
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 06:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030525AbWBHFls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 00:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030535AbWBHFlr
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 00:41:47 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:17627 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030525AbWBHFlr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2006 00:41:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060208053904.NTZJ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Feb 2006 00:39:04 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602071412390.5397@localhost.localdomain> (Nicolas
	Pitre's message of "Tue, 07 Feb 2006 14:18:39 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15732>

Nicolas Pitre <nico@cam.org> writes:

> As someone refreshed my memory in private, there is no "unstable" branch 
> like Linux used to have.  But hopefully you all understood what I meant 
> i.e. in the main branch after the stable 1.2.0 branch is forked.

Yes I understood what you meant.  Eventually we ship with --only
as the default and the best timing is between 1.2.0 and 1.3.0.

I am just worried if it might turn out to be like shipping a
bicycle with training wheels welded onto it (so it cannot be
easily removed).  That is where my reluctance comes from.

But I do not have to be convinced 100% myself in order to set it
to the default, as long as the more important users are happy.
