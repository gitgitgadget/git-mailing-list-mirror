From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Start search from HEAD
Date: Tue, 20 Jun 2006 05:31:43 -0700
Message-ID: <7v64iw80uo.fsf@assigned-by-dhcp.cox.net>
References: <20060620152515.23e59396.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 14:31:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsfOW-0001JD-4U
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 14:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWFTMbp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 08:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWFTMbp
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 08:31:45 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:2552 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030233AbWFTMbp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 08:31:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060620123144.JIAY554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Jun 2006 08:31:44 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060620152515.23e59396.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Tue, 20 Jun 2006 15:25:15 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22199>

Timo Hirvonen <tihirvon@gmail.com> writes:

> Starting search from whatever the current "h" parameter points to is
> wrong.  Sometimes it doesn't give all the expected results or may even
> fail if h points to an object which is not a commit.

If h is not a commit, perhaps, but wouldn't you expect it to
find things from "next" branch if "h" points at it?
