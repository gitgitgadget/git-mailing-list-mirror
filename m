From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 07 Feb 2007 15:36:47 -0800
Message-ID: <7vtzxx4k1c.fsf@assigned-by-dhcp.cox.net>
References: <17866.20355.744025.133326@lisa.zopyra.com>
	<Pine.LNX.4.64.0702071441160.8424@woody.linux-foundation.org>
	<7vd54l60gg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702071525270.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 00:36:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwLL-00082P-Oo
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 00:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161321AbXBGXgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 18:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161416AbXBGXgs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 18:36:48 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:63190 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161321AbXBGXgs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 18:36:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207233648.WWHX1302.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 18:36:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Lncn1W00N1kojtg0000000; Wed, 07 Feb 2007 18:36:47 -0500
In-Reply-To: <Pine.LNX.4.64.0702071525270.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 7 Feb 2007 15:26:01 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39001>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 7 Feb 2007, Junio C Hamano wrote:
>> >
>> > Of course, we should probably just have a
>> >
>> > 	git reflog show
>> >
>> > command for this to make it prettier.
>> 
>> 	$ git log -g?
>
> You think that is *prettier*?
>
> No, I think that if I want a log, I'll just do the "less", thank you very 
> much ;)

Heh, I do not care if you find "log -g" pretty, since I do not
particularly find it pretty ("log --pretty=o --abbrev-commit -g"
is probably prettier than "less").

I usually use "show-branch -g" myself while rewinding and
rebuilding for a release, but my rewinds are lot more controlled
than "oops, made a mistake" recovery schenario that triggered
this discussion; for large logs (more than 25 entries) it is not
very useful.
