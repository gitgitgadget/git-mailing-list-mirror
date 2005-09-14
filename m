From: Junio C Hamano <junkio@cox.net>
Subject: Re: dumb transports not being welcomed..
Date: Wed, 14 Sep 2005 12:00:23 -0700
Message-ID: <7vk6hjiiew.fsf@assigned-by-dhcp.cox.net>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net>
	<20050913211444.GA27029@mars.ravnborg.org>
	<7vacig1wrb.fsf@assigned-by-dhcp.cox.net>
	<7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
	<1126707016.14036.14.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 21:02:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFcUe-0001Lm-K6
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 21:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVINTA0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 15:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbVINTAZ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 15:00:25 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38120 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932552AbVINTAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 15:00:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914190024.NXJZ24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 15:00:24 -0400
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1126707016.14036.14.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Wed, 14 Sep 2005 09:10:16 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8554>

Jon Loeliger <jdl@freescale.com> writes:

> Well, that is sort of just it, too.  Why not make the
> default, obvious, common repo prep mechanism do all
> the necessary steps for proper presentation?  Having
> to remember to do 6 steps just begs for an additional
> layer of scripting.

Fair enough.  My excuse is that Linus did not want the
update-server-info hook enabled by default.  He does not believe
in dumb transports anyway, but aside from that, it still is a
valid attitude because it is not necessary when you do not
intend to publish your repository over dumb transport at all but
still want to push into it.  And another excuse is I do not
in general think enabling hooks by default is a good idea.

Even if you built your repository with older git tools, you
should be always able to say 'GIT_DIR=that-repository
git-init-db' without damaging its existing contents to install
the disabled hooks in its hooks/ directory.

> I confess, I've been using rsync as it is what appears
> to be able to reliably get a repository that works.

And I thought rsync was a reliable way too, until I saw a
message from Tony Luck this morning X-<.
