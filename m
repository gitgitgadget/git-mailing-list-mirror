From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/5] git-merge-base: follow 'prior' links to find merge bases
Date: Mon, 24 Apr 2006 22:19:56 -0700
Message-ID: <7vlktu2pvn.fsf@assigned-by-dhcp.cox.net>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
	<20060425043106.18382.48165.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 07:20:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYFy0-0006Jt-RZ
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 07:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWDYFUA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 01:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWDYFUA
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 01:20:00 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:15262 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932098AbWDYFUA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 01:20:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060425051959.LEXC24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Apr 2006 01:19:59 -0400
To: Sam Vilain <sam.vilain@catalyst.net.nz>
In-Reply-To: <20060425043106.18382.48165.stgit@localhost.localdomain> (Sam
	Vilain's message of "Tue, 25 Apr 2006 16:31:06 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19130>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> From: Sam Vilain <sam.vilain@catalyst.net.nz>
>
> It is possible that a good merge base may be found looking via "prior"
> links as well.  We follow them where possible.

You need to define what "prior" means before making decision
like that.  If "prior" can mean cherry-picked one from unrelated
line of development, the above reasoning does not apply.
