From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/4] add xmktime() function that always accounts for the TZ env
Date: Sat, 24 Dec 2005 11:18:56 -0800
Message-ID: <7vy82aqp5r.fsf@assigned-by-dhcp.cox.net>
References: <20051224121007.GA19136@mail.yhbt.net>
	<20051224121339.GB3963@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 24 20:19:27 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqEvN-00077v-3w
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 20:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVLXTS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 14:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVLXTS6
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 14:18:58 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:3456 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932289AbVLXTS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2005 14:18:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051224191705.FJFY17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Dec 2005 14:17:05 -0500
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051224121339.GB3963@mail.yhbt.net> (Eric Wong's message of
	"Sat, 24 Dec 2005 04:13:39 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14031>

Eric Wong <normalperson@yhbt.net> writes:

> This function was added because mktime in dietlibc doesn't seem to
> account for the TZ env.  Also, xmktime() now shares the same
> always-summer bug TZ parsing elsewhere,

Where elsewhere?
