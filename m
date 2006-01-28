From: Junio C Hamano <junkio@cox.net>
Subject: Re: Notes on Subproject Support
Date: Sat, 28 Jan 2006 13:43:30 -0800
Message-ID: <7vfyn8t4e5.fsf@assigned-by-dhcp.cox.net>
References: <200601280455.k0S4tx6N003251@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jan 28 22:43:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2xr7-0005tG-3N
	for gcvg-git@gmane.org; Sat, 28 Jan 2006 22:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWA1Vnd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jan 2006 16:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWA1Vnd
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jan 2006 16:43:33 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:63434 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750761AbWA1Vnc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2006 16:43:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060128214055.UUKK17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 Jan 2006 16:40:55 -0500
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200601280455.k0S4tx6N003251@laptop11.inf.utfsm.cl> (Horst von
	Brand's message of "Sat, 28 Jan 2006 01:55:59 -0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15201>

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> One thing that has bugged me from the beginning of this, and which does
> come out of your example: Why only project/subproject? In your example, you
> have the kernel (OK(ish)) and "rest of the world",...

Because I presented the example badly, perhaps?

There is nothing that prevents you from having more "bind" lines
than the example showed, to have one project that works with N
subprojects.  In fact, the examples in earlier threads used a
project with the kernel and gcc subprojects -- I just felt it
was so obvious you can do N subprojects instead of just one, so
used just one subproject in the latest round of example for the
sake of brevity.

And there is nothing that prevents you from having "bind" lines
in the subproject commit objects, either.

The structure the lower level objects support with the "bound
commit" extension is not about "project vs subproject".  You can
express "project that has subprojects each of which has
subsubprojects".

Now, it is totally a separate issue that anybody sane would want
to keep track of such structure, or we would be better off
leaving it to build infrastructure specific to each toplevel
project, as argued by some earlier.
