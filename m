From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Sun, 04 Sep 2005 17:03:07 -0700
Message-ID: <7vmzmsbcuc.fsf@assigned-by-dhcp.cox.net>
References: <200509042143.j84LhDZo020359@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 02:03:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EC4SC-0004Zs-10
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 02:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVIEADL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 20:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVIEADL
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 20:03:11 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:52410 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932226AbVIEADJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 20:03:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050905000309.SGSR7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Sep 2005 20:03:09 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200509042143.j84LhDZo020359@laptop11.inf.utfsm.cl> (Horst von
	Brand's message of "Sun, 04 Sep 2005 17:43:13 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8071>

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

>> 3. Non-binaries are called '*-scripts'.
>> 
>>    In earlier discussions some people seem to like the
>>    distinction between *-script and others; I did not
>>    particularly like it, but I am throwing this in for
>>    discussion.
>
> I for one think this makes the command name dependent on a non-essential
> implementation detail, so -script should go.

I had the same opinion.  The counter-argument people raised when
this topic came up on the list was that it would help grepping
in the source tree.

I'm tempted to suggest doing something along these lines:

 - Rename things that are implemented in shell from *-script to
   *.sh, and perl to *.perl in the source tree;

 - Install them without .{sh,perl} suffix.

Once this is done, the users nor the 'git' wrapper do not have
to deal with *-script.

Comments?
