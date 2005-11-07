From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Support for passing path to custom map in git-shortlog.perl
Date: Mon, 07 Nov 2005 14:44:25 -0800
Message-ID: <7vr79sqdrq.fsf@assigned-by-dhcp.cox.net>
References: <20051106230757.24941.19267.stgit@machine.or.cz>
	<7vek5twc3u.fsf@assigned-by-dhcp.cox.net>
	<20051107215412.GU1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 23:47:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZFjt-0005Wb-Tz
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 23:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965577AbVKGWo3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 17:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965584AbVKGWo2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 17:44:28 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:43944 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965586AbVKGWo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 17:44:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051107224343.ULMQ29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Nov 2005 17:43:43 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051107215412.GU1431@pasky.or.cz> (Petr Baudis's message of
	"Mon, 7 Nov 2005 22:54:12 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11286>

Petr Baudis <pasky@suse.cz> writes:

> ... I think it can be useful - either when you
> want to work on readonly tree, or when you want to support custom
> mailmap in addition to the default project's one without interference...

Ah, that sort of makes sense.  On the other hand you could run
git-shortlog in a separate directory right now by piping the
git-log output to "(cd somewhere && git-shortlog)", so...

Come to think of it, why not make git-shortlog take the same set
of parameters as git-log takes (perhaps except --pretty)?  Then 
the issues you raised starts to make sense and we would
certainly want -m MAPFILE option there.
