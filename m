From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] shared repository settings enhancement.
Date: Fri, 09 Jun 2006 21:19:43 -0700
Message-ID: <7vver9k5gg.fsf@assigned-by-dhcp.cox.net>
References: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com>
	<7virnam435.fsf@assigned-by-dhcp.cox.net>
	<7vver9lu8g.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606091743410.5498@g5.osdl.org>
	<7v8xo5lleo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606092103170.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jun 10 06:20:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Foux3-0003JQ-8v
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 06:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWFJETp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 00:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWFJETp
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 00:19:45 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:5855 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030256AbWFJETo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 00:19:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060610041944.GDNI19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Jun 2006 00:19:44 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606092103170.5498@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 9 Jun 2006 21:08:30 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21596>

Linus Torvalds <torvalds@osdl.org> writes:

> How about making it be
>
> 	[core]
> 		sharedrepository = {umask | user | group | everybody}
>
> and allow the old boolean expression syntax to mean "0/false means umask, 
> 1/true means group".
>
> So you'd have:
>
>  - umask/0/false means "use 0777 permissions with default umask"
>  - user means "use 0500 permissions"
>  - group means "use 0550 permissions"
>  - everybody means "use 0555 permissions"
>
> (where "5" is r-x, and only for directories, and obviously degenerates to 
> just "4" aka r-- for regular files).
>
> That sounds really pretty self-explanatory and obvious, wouldn't you say?

Yes, the user can mistype "gruop", people would start making
noises about having "world" as a synonym for "everybody", and
the parsing becomes somewhat cumbersome, and all that trouble,
but on the other hand that is probably the easiest to explain.
