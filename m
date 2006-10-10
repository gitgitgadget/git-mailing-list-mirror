From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why gitweb commitdiff NO diff output ?
Date: Tue, 10 Oct 2006 10:42:38 -0700
Message-ID: <7viris2hkh.fsf@assigned-by-dhcp.cox.net>
References: <4b3406f0609280032y77cb5961i220b3cfd741ebfd4@mail.gmail.com>
	<20061003095250.GJ2871@admingilde.org>
	<7vwt7hnvsk.fsf@assigned-by-dhcp.cox.net>
	<4b3406f0610080122r17a10ea4h2c71a399fb8398a@mail.gmail.com>
	<7v64et9fjq.fsf@assigned-by-dhcp.cox.net>
	<4b3406f0610091851i593f3e53v5d5fef891edb6d48@mail.gmail.com>
	<7v1wpgapew.fsf@assigned-by-dhcp.cox.net>
	<7viris9a6g.fsf@assigned-by-dhcp.cox.net>
	<4b3406f0610092336v5ab58134i280f64223a272b0b@mail.gmail.com>
	<7vy7ro64pq.fsf@assigned-by-dhcp.cox.net>
	<4b3406f0610100346v16f1f2f6i305963bc1b398dac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 19:42:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXLcp-0003KE-Mm
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 19:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWJJRmk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 13:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWJJRmk
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 13:42:40 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:10625 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751068AbWJJRmj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 13:42:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010174239.BIZX13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 13:42:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Yhih1V00f1kojtg0000000
	Tue, 10 Oct 2006 13:42:42 -0400
To: "Dongsheng Song" <dongsheng.song@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28641>

"Dongsheng Song" <dongsheng.song@gmail.com> writes:

> Thanks, now that's OK.
>
>> I am not sure what version of gitweb your distribution packages,
>> but it used to be that commitdiff page wanted to create
>> temporary file somewhere on the filesystem (the variable was
>> $git_temp and by default it was set to "/tmp/gitweb", I think).
>> Your other pages such as commit and log page seem to be working,
>> so perhaps your gitweb has trouble writing there only on that
>> machine?

Care to share your experience to help others?

If it was /tmp/gitweb permission problem then the newer gitweb
shouldn't have that issue so it would be a moot point, but if
the pitfall still applies to the current software we might want
to add a "common pitfals" section to gitweb/README.
