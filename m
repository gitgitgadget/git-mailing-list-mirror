From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Call extended-semantics commands through variables.
Date: Sat, 11 Feb 2006 16:36:22 -0800
Message-ID: <7vzmkxjtvd.fsf@assigned-by-dhcp.cox.net>
References: <7vwtg2mmx5.fsf@assigned-by-dhcp.cox.net>
	<4230.1139699411@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 01:36:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F85ED-0001nO-FD
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 01:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWBLAg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 19:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWBLAg2
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 19:36:28 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:21459 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750918AbWBLAg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 19:36:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212003631.MSLH25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 19:36:31 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <4230.1139699411@lotus.CS.Berkeley.EDU> (Jason Riedy's message of
	"Sat, 11 Feb 2006 15:10:11 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15967>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> Is there a better way of grabbing all the tags now?  I haven't
> kept track, as I haven't had to do that in a while.

Recent 'git-fetch' automatically follows tags that are attached
to commits you slurp (following example set by Cogito), to
reduce the need to grab all tags to begin with.  That would not
help tags that are attached to objects that are not part of
branches you are tracking; you can use 'git-fetch --tags' for
them.
