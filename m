From: Junio C Hamano <junkio@cox.net>
Subject: Updated multi-head downloads and $GIT_DIR/remotes/ support
Date: Sat, 20 Aug 2005 11:13:10 -0700
Message-ID: <7vvf20o4sp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 20 20:13:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6XqO-0001ap-3Y
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 20:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbVHTSNM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Aug 2005 14:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbVHTSNM
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 14:13:12 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:56218 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932654AbVHTSNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2005 14:13:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050820181311.UHKP7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 20 Aug 2005 14:13:11 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Now I think all the pieces are glued together.  I'll send the
following patches, which are already in the proposed updates
branch.

I sent an early WIP for some of them, but the patches are
reorganized for easier review and applies on top of the current
"master" branch.

This series consists of the following:

    Start adding the $GIT_DIR/remotes/ support.
    Multi-head fetch.
    Retire git-parse-remote.
    Infamous 'octopus merge'
    Make "git pull" and "git fetch" default to origin
    Use .git/remote/origin, not .git/branches/origin.

The issues I discussed in "Multi-head fetches, pulls, and a King
Ghidorah" are addressed there, and the examples in "MyGITDay"
message I sent earlier should work with these patches.  I'll
work on adding some documentation, maybe in howto or tutorial
format, over the weekend.

-jc
