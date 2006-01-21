From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git push" logic changed?
Date: Fri, 20 Jan 2006 16:59:19 -0800
Message-ID: <7v1wz22y6w.fsf@assigned-by-dhcp.cox.net>
References: <20060120225336.GA29206@kroah.com>
	<7vlkxa30rd.fsf@assigned-by-dhcp.cox.net>
	<20060121001547.GA30712@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 01:59:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F076F-0005nP-5p
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 01:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWAUA7Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 19:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWAUA7Y
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 19:59:24 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:24315 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932263AbWAUA7X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 19:59:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121005822.HLPS15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 20 Jan 2006 19:58:22 -0500
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060121001547.GA30712@kroah.com> (Greg KH's message of "Fri, 20
	Jan 2006 16:15:47 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14983>

Greg KH <greg@kroah.com> writes:

> It would be nicer not to break a previously working command :)

Well the change was not about breaking things but the command's
natural way of "working" (which was fine for you and other
people, me included) was not so helpful to the shared repository
people, and unfortunately I couldn't have it both ways X-<.
