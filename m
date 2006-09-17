From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: use correct mime type even if filename has multiple dots.
Date: Sun, 17 Sep 2006 02:07:25 -0700
Message-ID: <7vvenm6euq.fsf@assigned-by-dhcp.cox.net>
References: <20060916210933.GX17042@admingilde.org>
	<eehr7e$5i0$1@sea.gmane.org> <20060917075157.GY17042@admingilde.org>
	<7vejua7um3.fsf@assigned-by-dhcp.cox.net> <eej2i1$97c$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 11:07:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOscd-00078e-68
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 11:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWIQJH2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 05:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWIQJH2
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 05:07:28 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:64714 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932386AbWIQJH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 05:07:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917090726.DENG22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 05:07:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PM7E1V0051kojtg0000000
	Sun, 17 Sep 2006 05:07:14 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eej2i1$97c$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	17 Sep 2006 10:56:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27173>

Jakub Narebski <jnareb@gmail.com> writes:

> Is it really useful? Usually the suffix in mime.types doesn't contain dot
> itself. Besides, to be said we need correct mimetype only for files which
> can be displayed in browser (HTML, XHTML, images: png, gif, jpeg, perhaps
> XML). All other can get generic mimetype, i.e. application/octet-stream for
> binary files (to be saved) and text/plain for text file (to be displayer
> as-is in browser).

Sorry, I do not think that is quite correct.  The browser can
launch an appropriate application on the downloaded file, as
long as you send the data labelled with proper mimetype.  If you
send out application/octet-stream, of course that would not work.

Having said that, I am not sure what special things Martin
wanted to do with x.8.html that is different from y.html, so
maybe discussing the patch does not have merit at all.
