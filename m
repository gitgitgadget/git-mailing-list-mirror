From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Thu, 09 Feb 2006 16:46:32 -0800
Message-ID: <7vvevo3us7.fsf@assigned-by-dhcp.cox.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05AA1FB3@scsmsx401.amr.corp.intel.com>
	<20060210004040.GB2866@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 01:46:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7MQn-0004B2-At
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 01:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWBJAqf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 19:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWBJAqe
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 19:46:34 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:10231 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750902AbWBJAqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 19:46:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210004342.JDRN17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 19:43:42 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060210004040.GB2866@mythryan2.michonline.com> (Ryan Anderson's
	message of "Thu, 9 Feb 2006 19:40:40 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15849>

Ryan Anderson <ryan@michonline.com> writes:

> Note that I don't believe there is any need to combine the hunks, just
> stick them there in order and it *should* do the right thing.

Probably not.  I suspect it would not like two pieces of diffs
touching the same path in a batch.

Feeding one at a time is OK, though.
