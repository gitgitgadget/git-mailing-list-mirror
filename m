From: Junio C Hamano <junkio@cox.net>
Subject: Re: dumb transports not being welcomed..
Date: Tue, 13 Sep 2005 15:23:57 -0700
Message-ID: <7vek7swqrm.fsf@assigned-by-dhcp.cox.net>
References: <200509132203.j8DM3foH008451@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 00:38:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFJC6-0005DD-EW
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 00:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbVIMWYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 18:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVIMWYA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 18:24:00 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:54702 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932537AbVIMWX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 18:23:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050913222359.VHVH7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Sep 2005 18:23:59 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200509132203.j8DM3foH008451@laptop11.inf.utfsm.cl> (Horst von
	Brand's message of "Tue, 13 Sep 2005 18:03:41 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8501>

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>
> [...]
>
>> Using cogito is not a problem at all.  The mechanism to prepare
>> trees to serve wider audience not being used widely is.
>
> It isn't really documented...

True.  The existing documentation might be sketchy.  We only
have the following documentation pages right now.  Clarification
patches are welcome.

http://www.kernel.org/pub/software/scm/git/docs/tutorial.html
    Look for "Publishing your work" section, and
    "Working with Others section, "project lead" and "subsystem
    maintainer" subsections, both bullet point #2.

http://www.kernel.org/pub/software/scm/git/docs/git-update-server-info.html
    The above sections in the tutorial repeatedly mentions this
    command.

http://www.kernel.org/pub/software/scm/git/docs/repository-layout.html
    And git-update-server-info documentation refers to this page.
    Look for "objects/info/packs" and "info/refs".
