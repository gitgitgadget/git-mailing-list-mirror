From: Junio C Hamano <junkio@cox.net>
Subject: Re: git repack throws -> error: unrecognized: ??
Date: Fri, 23 Dec 2005 19:16:37 -0800
Message-ID: <7v4q4z4222.fsf@assigned-by-dhcp.cox.net>
References: <43ACAE49.4000902@excelsior-online.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 24 04:17:07 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Epzu0-0001lO-Hl
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 04:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030610AbVLXDQk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Dec 2005 22:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030611AbVLXDQj
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 22:16:39 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:63467 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030610AbVLXDQj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2005 22:16:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051224031447.TLLL17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Dec 2005 22:14:47 -0500
To: duncan@excelsior-online.org
In-Reply-To: <43ACAE49.4000902@excelsior-online.org> (Duncan Mac Leod's
	message of "Sat, 24 Dec 2005 03:11:21 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14006>

Duncan Mac Leod <duncan@excelsior-online.org> writes:

> The last one throws 'error: unrecognized:' - what does this mean?
>
> Under which circumstances is this error message fired?
>
> Did my git repository get corrupted?

No.  But you are running GIT before 1.0.0b.

Namely, this commit is needed to squelch the error message:

    commit 8ac4838af428a2a32498b3e8d13295eb714654b4
    Author: Junio C Hamano <junkio@cox.net>
    Date:   Wed Dec 21 13:48:47 2005 -0800

        server-info: skip empty lines.

        Now we allow an empty line in objects/info/packs file, recognize
        that and stop complaining.

        Signed-off-by: Junio C Hamano <junkio@cox.net>
