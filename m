From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitview 0.3
Date: Thu, 02 Feb 2006 21:03:13 -0800
Message-ID: <7vzml9kp9q.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590602012033w41b49b2ao4423707702086739@mail.gmail.com>
	<7vzmlauw35.fsf@assigned-by-dhcp.cox.net>
	<cc723f590602020803u72bdff2ek95fba2ea30970170@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 06:03:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4t6M-00086Z-EM
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 06:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWBCFDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 00:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWBCFDQ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 00:03:16 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:4994 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751036AbWBCFDP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 00:03:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060203050200.YIYY20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 00:02:00 -0500
To: Aneesh Kumar <aneesh.kumar@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15524>

Aneesh Kumar <aneesh.kumar@gmail.com> writes:

> ... Can you get the gitview added git repository so that next
> time onwards i need to send only the diff.

We _could_ make a contrib/gitview directory to keep it there,
and as somebody else comes up with a new interesting git
application, add a new directory in contrib/ to expand that
area.

But personally I am not enthused about keeping other peoples'
projects in git.git tree [*1*].  I'd rather see you start your
own public repository, propagate your changes from there, and
run it as your own project.

Even though it is currently a single file 'project', you will
want to add more stuff, maybe splitting the code to use your own
*.py module to import into the main program, and add *.c files
to interface with the lower level and Makefile to describe the
build rules once we start libifying git.  I suspect we are all
better off if we keep separate projects separate in the long
run.

Somebody (I think it was Sean Estabrooks but I may be mistaken)
once offered to host git projects at a site he controls.  I
wonder if you can get him interested...


[Footnote]

*1* I was not too happy to see gitk merged in with "the coolest
merge ever" myself, but that was done before my time.  "Not too
happy" does not necessarily mean I object to it.  All things
considered I think it was a good thing: (1) as a showcase of how
cool a merge can be, it was a good demonstration; (2) coming
with a repository browser usable out-of-box with minimum
dependencies was a good thing (tcl/tk is pretty much available
universally for easy install); (3) it is a good example program
of how a repository browser can be done.
