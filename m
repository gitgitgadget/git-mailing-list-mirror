From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-svn and Author files question
Date: Sat, 15 Apr 2006 19:22:22 -0700
Message-ID: <7vzmimcl9d.fsf@assigned-by-dhcp.cox.net>
References: <m21wvzx5e6.fsf@ziti.fhcrc.org>
	<20060415215850.GB20468@hand.yhbt.net> <m2ejzys2ns.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 16 04:22:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUwuC-0002qh-UP
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 04:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWDPCWY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 22:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWDPCWY
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 22:22:24 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33429 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932172AbWDPCWX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 22:22:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060416022223.YRFB16517.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 22:22:23 -0400
To: git@vger.kernel.org
In-Reply-To: <m2ejzys2ns.fsf@ziti.fhcrc.org> (Seth Falcon's message of "Sat,
	15 Apr 2006 18:57:27 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18773>

Seth Falcon <sethfalcon@gmail.com> writes:

> I'm a bit confused about why I have to do this.  Is there a way around
> this?  Or perhaps a way to force a bogus email address based on svn
> user name?

I think this is a reasonable request.  IIRC, the original
foreign SCM interface (git-cvsimport) did "foobar <foobar>"
if there is no mapping available, so that might be a good
example to follow.
