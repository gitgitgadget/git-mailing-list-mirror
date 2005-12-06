From: Junio C Hamano <junkio@cox.net>
Subject: Re: announce: git browser
Date: Tue, 06 Dec 2005 12:23:35 -0800
Message-ID: <7v1x0q2cvs.fsf@assigned-by-dhcp.cox.net>
References: <40b2b7d90512041623g1e22fecai9470ffcb94f40a58@mail.gmail.com>
	<20051205004238.GE22159@pasky.or.cz>
	<40b2b7d90512041720i65f63ee1pcfe32d2c0c3c357b@mail.gmail.com>
	<20051205232626.GH22159@pasky.or.cz>
	<40b2b7d90512052240t778f1c8kf182ff065687068c@mail.gmail.com>
	<7voe3u67ik.fsf@assigned-by-dhcp.cox.net>
	<40b2b7d90512052331s22adb055y9f99b8cafe20c0c3@mail.gmail.com>
	<7vd5ka653t.fsf@assigned-by-dhcp.cox.net>
	<40b2b7d90512060013j23345bf3o2021080edcfbd9c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 21:28:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjjM6-0004Id-Cr
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 21:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbVLFUXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 15:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbVLFUXi
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 15:23:38 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:7149 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932635AbVLFUXh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 15:23:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206202221.NHOX17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 15:22:21 -0500
To: Artem Khodush <greenkaa@gmail.com>
In-Reply-To: <40b2b7d90512060013j23345bf3o2021080edcfbd9c0@mail.gmail.com>
	(Artem Khodush's message of "Tue, 6 Dec 2005 11:13:29 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13288>

Artem Khodush <greenkaa@gmail.com> writes:

> And the reason why special NNTP server is needed is, I guess,
> that plain NNTP server will not be able to cope with all the diffs
> stored in message database? Well, but then, the newsgroups
> will not be distributable..
>
> Or is there any other reason?

Actually, the real reason was I was stupid (I am always stupid
but I was more stupid than I usually am in this case).  We could
just inject new patches into appropriate newsgroups as they come
along, either from a cron job or from the post-update hook.
