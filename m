From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] builtin-log: respect diff configuration options
Date: Fri, 07 Jul 2006 03:43:40 -0700
Message-ID: <7vy7v51yqr.fsf@assigned-by-dhcp.cox.net>
References: <11522670452824-git-send-email-normalperson@yhbt.net>
	<11522670473116-git-send-email-normalperson@yhbt.net>
	<11522670482020-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 12:43:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FynoH-0008HX-7Z
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 12:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWGGKnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 06:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWGGKnm
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 06:43:42 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:56266 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750999AbWGGKnm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 06:43:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707104341.FIWF18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 06:43:41 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11522670482020-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Fri, 07 Jul 2006 03:10:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23423>

Eric Wong <normalperson@yhbt.net> writes:

> The log commands are all capable of generating diffs, so we
> should respect those configuration options for diffs here.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>

Makes sense.  This makes "git log -p" more colorful ;-).
