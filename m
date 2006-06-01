From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svnimport: Improved detection of merges.
Date: Thu, 01 Jun 2006 00:12:51 -0700
Message-ID: <7vlkshs618.fsf@assigned-by-dhcp.cox.net>
References: <11490715283626-git-send-email-octo@verplant.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Forster <octo@verplant.org>
X-From: git-owner@vger.kernel.org Thu Jun 01 09:13:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlhMZ-0002KF-PK
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 09:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWFAHMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 03:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWFAHMx
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 03:12:53 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:42131 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750747AbWFAHMw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 03:12:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060601071252.ZZQS18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Jun 2006 03:12:52 -0400
To: git@vger.kernel.org
In-Reply-To: <11490715283626-git-send-email-octo@verplant.org> (Florian
	Forster's message of "Wed, 31 May 2006 12:32:08 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21105>

Florian Forster <octo@verplant.org> writes:

> The regexes detecting merges (while still relying on the commit messages,
> though) have been improved to catch saner (and hopefully more) messages. The
> old regex was so generic that it often matched something else and missed the
> actual merge-message.

> Also, the regex given with the `-M' commandline-option is checked first:
> Explicitely given regexes should be considered better than the builtin ones,
> and should therefore be given a chance to match a message first.

The latter part sounds immensely sane.  The former I am not a
good judge, since I do not interact with subversion repositories
myself.  Opinions from real svn users?


BTW, did anybody received the latest "What's in git.git" I sent
out about 20 minutes ago?
