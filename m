From: Junio C Hamano <junkio@cox.net>
Subject: Re: Branch relationships
Date: Sun, 14 May 2006 15:19:00 -0700
Message-ID: <7v8xp4ntbf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
	<200605142249.17508.Josef.Weidendorfer@gmx.de>
	<7vr72w2thu.fsf@assigned-by-dhcp.cox.net>
	<200605150001.48548.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 00:19:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfOvg-0005gw-Bt
	for gcvg-git@gmane.org; Mon, 15 May 2006 00:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWENWTD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 18:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWENWTD
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 18:19:03 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:54156 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750749AbWENWTB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 18:19:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514221901.MUSV9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 18:19:01 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200605150001.48548.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Mon, 15 May 2006 00:01:48 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19987>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

>> Exactly.  I would _want_ to push to both with single action when
>> I say "git push ko-private".  Actually I have _never_ felt need
>> to, but Linus wanted it first and I think it makes sense.
>
> Hmmm. Isn't this a solution for a very special use-case?
> You even can not specify different push lines for the 2 URLs.
> I think you want an alias name for a group of remotes here?

Perhaps.  

The "push to multiple places" is mostly for Linus backing things
up, and I tend to agree that your "alias" notation makes things
appear to be more general.  However, I do not think you would
want to push to two different places with different branch
mappings, so I suspect that generality is not buying you much
while making things more easily misconfigured.

> I suppose "branch.<branch name>.origin" is still the way to go for
> specifying the upstream?

Probably "origin" is a better name for it; I was assuming
"branch.<branch name>.remote = foo" refers to a [remote "foo"]
section and means "when on this branch, pull from foo and merge
from it".
