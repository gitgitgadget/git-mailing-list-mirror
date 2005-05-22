From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-files -z output
Date: Sun, 22 May 2005 10:17:40 -0700
Message-ID: <7v3bsffadn.fsf@assigned-by-dhcp.cox.net>
References: <20050522170540.GO15178@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 19:18:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZu44-0001BV-8u
	for gcvg-git@gmane.org; Sun, 22 May 2005 19:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVEVRRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 13:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVEVRRu
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 13:17:50 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:6647 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261833AbVEVRRr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 13:17:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050522171741.CGSE26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 May 2005 13:17:41 -0400
To: GIT <git@vger.kernel.org>
In-Reply-To: <20050522170540.GO15178@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Sun, 22 May 2005 19:05:40 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

TG> I am adopting to the new format.
TG> Are the fields supposed to be seperated by space or tab?

Please see Documentation/diff-format.txt; find the below in the
archive for the full description of why we wanted this format
update.

    From:	Junio C Hamano <junkio@cox.net>
    Subject: Re: updated design for the diff-raw format.
    To:	git@vger.kernel.org
    Date:	Sat, 21 May 2005 16:17:33 -0700

    (second of the replayed message, with blessing from Linus)

    Date: Sat, 21 May 2005 11:24:31 -0700 (PDT)
    From: Linus Torvalds <torvalds@osdl.org>
    To: Junio C Hamano <junkio@cox.net>
    Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half of copy detection.
    Message-ID: <Pine.LNX.4.58.0505211107160.2206@ppc970.osdl.org>

    On Sat, 21 May 2005, Junio C Hamano wrote:
    > 
    > Once we start to think of it this way, it becomes quite tempting
    > to change the diff-raw format to actually match the above
    > concept.

    I agree, and I was going to suggest changing the "raw" diff output for all
    the same reasons. So I think you should do it, as the old format was based
    on not really knowing where this all would take us. I think your proposed
    format is visually nicer, and it's obviously more flexible.


