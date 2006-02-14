From: Junio C Hamano <junkio@cox.net>
Subject: Re: diffstat wierdness with 'git format-patch' output
Date: Mon, 13 Feb 2006 23:10:18 -0800
Message-ID: <7vhd72v2jp.fsf@assigned-by-dhcp.cox.net>
References: <20060214055425.GA32261@kroah.com>
	<20060214055648.GA592@kroah.com>
	<7vveviv5d1.fsf@assigned-by-dhcp.cox.net>
	<20060214063420.GA11851@kroah.com> <20060214064256.GA19667@kroah.com>
	<20060214065224.GA20541@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 08:10:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8uKt-0001uF-FE
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 08:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWBNHKk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 02:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWBNHKk
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 02:10:40 -0500
Received: from [68.230.241.34] ([68.230.241.34]:34251 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030360AbWBNHKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 02:10:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214070751.HJBV17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 02:07:51 -0500
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060214065224.GA20541@kroah.com> (Greg KH's message of "Mon, 13
	Feb 2006 22:52:24 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16126>

Greg KH <greg@kroah.com> writes:

> Hm, git-send-email doesn't see this, so it doesn't get sent out if you
> use that tool.

And people are very likely to remove it by hand.

Another possibility would be to use "git apply --numstat" and
add numbers up in your script, but that would not give you a
nice graph output either X-<.

I'd say if you really care we should just remove those two
lines, and remember I am _very_ receptive from such suggestion
from prominent kernel people.
