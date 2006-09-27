From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 26 Sep 2006 19:40:34 -0700
Message-ID: <7v3baekp5p.fsf@assigned-by-dhcp.cox.net>
References: <20060926053816.54951.qmail@web31815.mail.mud.yahoo.com>
	<efapsl$e65$1@sea.gmane.org> <20060926160729.GH20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 04:40:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSPLk-0002VN-Rq
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 04:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWI0Ckg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 22:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWI0Ckg
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 22:40:36 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:64501 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750858AbWI0Ckg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 22:40:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927024035.VYQG13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 22:40:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TEgY1V00G1kojtg0000000
	Tue, 26 Sep 2006 22:40:32 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27851>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Tue, Sep 26, 2006 at 10:54:49AM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...
>> I'd rather not. The fact that the file name and tree name is link,
>> and the fact that commit title and tag title is link is a _convenience_.
>> Not always it is visible (without mouseover) that it is link.
>> And it is _not_ visible in the case of files!
>
> Then that should be fixed.
>
> And directories should have trailing slash in their name in the tree
> listing, for people with non-UNIX background who don't understand the
> ls -l like output.

I am with you on both counts.  For the latter, people might
actually like mode string to be changed to pretty pictures,
though.
