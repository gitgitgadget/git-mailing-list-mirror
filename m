From: Junio C Hamano <junkio@cox.net>
Subject: Re: diffstat wierdness with 'git format-patch' output
Date: Mon, 13 Feb 2006 22:37:59 -0800
Message-ID: <7vlkwev41k.fsf@assigned-by-dhcp.cox.net>
References: <20060214055425.GA32261@kroah.com>
	<20060214055648.GA592@kroah.com>
	<7vveviv5d1.fsf@assigned-by-dhcp.cox.net>
	<20060214063420.GA11851@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 07:38:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8tp9-0004uC-B7
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 07:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWBNGiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 01:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbWBNGiD
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 01:38:03 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:20152 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030381AbWBNGiB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 01:38:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214063447.FRHG17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 01:34:47 -0500
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060214063420.GA11851@kroah.com> (Greg KH's message of "Mon, 13
	Feb 2006 22:34:20 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16121>

Greg KH <greg@kroah.com> writes:

>> Have you tried "git apply --stat" instead?
>
> How would that work after I've allready applied the patches to a branch?

Sorry I was unclear.  By "instead", I meant "instead of running
diffstat -p1".
