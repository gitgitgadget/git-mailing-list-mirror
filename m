From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svnimport: Parse log message for Signed-off-by: lines
Date: Tue, 05 Sep 2006 16:26:40 -0700
Message-ID: <7v8xkxc2tr.fsf@assigned-by-dhcp.cox.net>
References: <20060905184611.GB14732@sashak.voltaire.com>
	<7v1wqqc8dh.fsf@assigned-by-dhcp.cox.net>
	<20060905221754.GI14732@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 01:27:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKkJZ-0004kv-HC
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 01:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWIEX0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 19:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWIEX0m
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 19:26:42 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:12987 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932137AbWIEX0l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 19:26:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060905232641.XDUG12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Sep 2006 19:26:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JnSh1V00X1kojtg0000000
	Tue, 05 Sep 2006 19:26:42 -0400
To: Sasha Khapyorsky <sashak@voltaire.com>
In-Reply-To: <20060905221754.GI14732@sashak.voltaire.com> (Sasha Khapyorsky's
	message of "Wed, 6 Sep 2006 01:17:54 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26497>

Sasha Khapyorsky <sashak@voltaire.com> writes:

> BTW, what about to importing subdirectories, like this:
>
>  <trunk>/path/to/subdir
>  <branches>/path/to/subdir
>
> Is this could be improvement?

I somehow had an impression that svnimport dealt with the
reversed layout already, although $project/{trunk,branches,tags}
layout is assumed by default; maybe I was mistaken.

If the tool can automatically detect the layout the remote
project employs, and adjust the default accordingly, I would
imagine that would be a useful addition.
