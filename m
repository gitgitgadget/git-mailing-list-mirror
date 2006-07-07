From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach --text option to diff
Date: Fri, 07 Jul 2006 04:06:23 -0700
Message-ID: <7v64i91xow.fsf@assigned-by-dhcp.cox.net>
References: <11522684373987-git-send-email-sf@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 13:06:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyoAI-0003oI-DD
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 13:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWGGLG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 07:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWGGLG1
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 07:06:27 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:29618 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932128AbWGGLG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 07:06:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707110626.PBVK6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 07:06:26 -0400
To: Stephan Feder <sf@b-i-t.de>
In-Reply-To: <11522684373987-git-send-email-sf@b-i-t.de> (Stephan Feder's
	message of "Fri, 07 Jul 2006 12:33:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23426>

Stephan Feder <sf@b-i-t.de> writes:

> I have to send patches of binary data to a customer but the builtin diff
> was no help in this case.

Given the previous patch, and also your point #2 below, I would
have expected you to introduce an option to force files to be
treated as binary even when they are otherwise misidentified as
text, but this patch is going the other way.

Interesting.

> 1. The shorthand -a for --text is not implemented. Is there a conflicting
> shorthand?

I do not think of one offhand, but it's the responsibility for
the party to propose such an enhancement to do the study ;-)

> 2. For diffstat --text is ignored. It seems pointless because binary
> patch data is not for human consumption anyway.

> 3. No documentation yet. If the patch is accepted I will add a short
> description. To Documentation/diff-options.txt?

Most likely that would be the place.
