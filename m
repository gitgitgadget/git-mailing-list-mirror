From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/3] git-daemon: plug new upload-tar command
Date: Sat, 02 Sep 2006 03:32:04 -0700
Message-ID: <7vfyfa1rvf.fsf@assigned-by-dhcp.cox.net>
References: <11570277231100-git-send-email-vagabon.xyz@gmail.com>
	<44F72039.3040206@lsrfire.ath.cx>
	<cda58cb80609020114h1e1ee553saf5aa90df8bc3ba0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 12:32:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJSnK-00016h-MW
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 12:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWIBKcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 06:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWIBKcE
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 06:32:04 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:2754 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750983AbWIBKcC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 06:32:02 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060902103201.UEBW2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sat, 2 Sep 2006 06:32:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id HNXw1V00M1kojtg0000000
	Sat, 02 Sep 2006 06:31:57 -0400
To: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80609020114h1e1ee553saf5aa90df8bc3ba0@mail.gmail.com>
	(Franck Bui-Huu's message of "Sat, 2 Sep 2006 10:14:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26327>

"Franck Bui-Huu" <vagabon.xyz@gmail.com> writes:

>> So if you beat me to it, that would be great.  Or if you have a better
>> idea, that would be also great. :-)
>
> Well I'll try to start something, not sure to have a lot of time
> though. Please contact me before starting anything, I would be sad to
> write something for /dev/null again ;)

I do not necessarily think your effort were for /dev/null; for
example, I was hoping you defend [PATCH 3/3].

While it makes sense to make "tar-tree --remote" usable outside
a git managed repository, I think people expect the connection
to obey core.gitproxy if the command is run inside a repository
that has a configuration file.
