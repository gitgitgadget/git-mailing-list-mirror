From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/4] Server-side support for user-relative paths.
Date: Wed, 02 Nov 2005 01:47:13 -0800
Message-ID: <7vll07tm8u.fsf@assigned-by-dhcp.cox.net>
References: <20051101225921.3835C5BF73@nox.op5.se>
	<7vek5z6h3f.fsf@assigned-by-dhcp.cox.net> <43687914.6080906@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 10:47:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXFDL-0000n5-9s
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 10:47:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbVKBJrQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 04:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbVKBJrQ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 04:47:16 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:48073 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932696AbVKBJrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 04:47:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102094632.EOGY776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Nov 2005 04:46:32 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43687914.6080906@op5.se> (Andreas Ericsson's message of "Wed, 02
	Nov 2005 09:30:12 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11019>

Andreas Ericsson <ae@op5.se> writes:

> I went with this implementation because...
> Perhaps it should be enter_repo() or some such? Optionally with 
> is_git_repo() as a separate function?

I agree with you that splitting this into three separate
functions does not make much sense.  I was just unsure about
that name; enter_repo() sounds more sensible.
