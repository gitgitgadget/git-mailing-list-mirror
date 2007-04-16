From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -q option to "git rm" to suppress output when there aren't errors.
Date: Sun, 15 Apr 2007 18:14:06 -0700
Message-ID: <7vps65yvc1.fsf@assigned-by-dhcp.cox.net>
References: <20070416000408.GA19107@midwinter.com>
	<7v4pnh18hr.fsf@assigned-by-dhcp.cox.net>
	<4622C0AC.8090904@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 03:14:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdFnI-0002ds-M5
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 03:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbXDPBOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 21:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754254AbXDPBOJ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 21:14:09 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42915 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbXDPBOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 21:14:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416011407.NJFV1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 21:14:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ndE61W00g1kojtg0000000; Sun, 15 Apr 2007 21:14:07 -0400
In-Reply-To: <4622C0AC.8090904@midwinter.com> (Steven Grimm's message of "Sun,
	15 Apr 2007 17:17:48 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44559>

Steven Grimm <koreth@midwinter.com> writes:

> Junio C Hamano wrote:
>
>> Suppressing output is understandable and probably is a useful
>> thing to do, but I do not see a justification to tie that
>> quietness to making the status unuable...
>
> The status is unusable as is, actually, for the particular use case of
> cg-admin-rewritehist. If you try to use git-rm as an index filter,
> cg-admin-rewritehist will stop running as soon as you hit a revision
> that doesn't contain the file you're looking to filter out. (If the
> file doesn't exist in the first revision in your repo, that means it
> will do no work at all.)

Probably "git-grep foo" wouldn't be suitable as the index filter
for admin-rewritehist, either, nor "git-fsck", nor many other
things.

What does it have to do with anything?

Saying "git rm --quiet foo" from the command line, wishing to
supress the output, is very understandable.

Saying "git rm --ignore-unmatch foo bar baz", wishing to remove
bar (which exists) even when foo does not exist, is also very
understandable.

I think they are pretty much independent options.
