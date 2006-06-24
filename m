From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Fri, 23 Jun 2006 17:39:37 -0700
Message-ID: <7vlkrn75fa.fsf@assigned-by-dhcp.cox.net>
References: <7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
	<20060623011205.GJ21864@pasky.or.cz>
	<7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
	<m1k678yt6m.fsf@ebiederm.dsl.xmission.com>
	<20060622220201.19132.67536.stgit@machine.or.cz>
	<7vlkrohj9p.fsf@assigned-by-dhcp.cox.net>
	<20060622235017.GH21864@pasky.or.cz>
	<7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
	<20060623011205.GJ21864@pasky.or.cz>
	<7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
	<20060623123904.GL21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 02:39:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtwBh-0007tb-98
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 02:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbWFXAjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 20:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWFXAjj
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 20:39:39 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41151 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932743AbWFXAji (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 20:39:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624003938.OJSZ19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 20:39:38 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060623123904.GL21864@pasky.or.cz> (Petr Baudis's message of
	"Fri, 23 Jun 2006 14:39:04 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22461>

Petr Baudis <pasky@suse.cz> writes:

> There's a patch to build libgit.so, would you take it as an excuse to
> always compile with -fPIC? ;-)

The only benerit we might gain from libgit.so in the current
shape, aside from making it easier to do .xs, is that multiple
git processes would share it in core, and the disk consumption
by 100+ little git commands are reduced -- which largely has
become non-issue with the recent spurt of making everything
built-ins.  But that "aside from" is in itself a big plus, so,
well, I am torn. 
