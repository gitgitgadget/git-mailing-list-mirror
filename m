From: Junio C Hamano <junkio@cox.net>
Subject: Re: Errors when updating an old git.git repository
Date: Tue, 26 Dec 2006 16:58:58 -0800
Message-ID: <7vwt4eb1d9.fsf@assigned-by-dhcp.cox.net>
References: <87d566ww3r.fsf@trews52.bothi.fi>
	<8c5c35580612260737vae2669dkac6a81fe863484d4@mail.gmail.com>
	<87ac1awjh0.fsf@trews52.bothi.fi>
	<Pine.LNX.4.63.0612262350070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<877iwew4iw.fsf@trews52.bothi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 27 01:59:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzN8J-0002if-Gb
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 01:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932854AbWL0A7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 19:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932878AbWL0A7A
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 19:59:00 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:36915 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932854AbWL0A67 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 19:58:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227005859.MXNB7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Dec 2006 19:58:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3czC1W00P1kojtg0000000; Tue, 26 Dec 2006 19:59:12 -0500
To: Hannu Koivisto <azure@iki.fi>
In-Reply-To: <877iwew4iw.fsf@trews52.bothi.fi> (Hannu Koivisto's message of
	"Wed, 27 Dec 2006 02:45:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35441>

Hannu Koivisto <azure@iki.fi> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> ...
>> So, you _asked_ git to fetch these three branches!
>
> Well, that's true from a technical standpoint, but I didn't add
> those lines to .git/remotes/origin, git did when I cloned the
> repository.  When one updates tracking branches and a branch has
> been deleted in the remote repository, I think it wouldn't be
> insane to expect git also to remove the line (if not the actual
> branch).  If that is not desired, I'd rather the message wasn't an
> error but something along the lines of "note: remote branch jc/bind
> no longer exists, please update .git/remotes/origin".  It's bit odd
> to get errors in a situation that (given the assumption) isn't
> erroneous.

I would be a bit reluctant to remove tracking automagically, but
I fully agree that a comment like that would be needed.

Patches?
