From: Junio C Hamano <junkio@cox.net>
Subject: Re: merging initial part of a branch?
Date: Wed, 11 Jan 2006 16:24:32 -0800
Message-ID: <7vu0cai98f.fsf@assigned-by-dhcp.cox.net>
References: <20060111230451.GH8618@fieldses.org>
	<7vek3epbs9.fsf@assigned-by-dhcp.cox.net> <43C59FB6.20803@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Jan 12 01:24:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwqGl-0007sB-RX
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 01:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbWALAYf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 19:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932674AbWALAYe
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 19:24:34 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:39086 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932675AbWALAYd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 19:24:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112002243.KHUX17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 19:22:43 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C59FB6.20803@op5.se> (Andreas Ericsson's message of "Thu, 12
	Jan 2006 01:15:50 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14538>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>
>> I haven't tried this for some time, but I presume
>> 	$ git pull linus tag v2.6.15
>> would do what you want.
>
> If it doesn't you might be able to do
>
> $ git format-patch -m -k v2.6.14..v2.6.15 --stdout > mega-mbox-patch
> $ git checkout our-own-branch
> $ git am -3 -k mega-mbox-patch
>
> That'll take some time though, so be sure to have a six-pack or two handy.

I do not think that should be done.  You will create an
alternate history that way, not the true v2.6.15 history.
