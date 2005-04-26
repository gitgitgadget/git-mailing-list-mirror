From: Junio C Hamano <junkio@cox.net>
Subject: Re: git add / update-cache --add fails.
Date: Mon, 25 Apr 2005 18:38:26 -0700
Message-ID: <7vhdhuqpv1.fsf@assigned-by-dhcp.cox.net>
References: <200504252226.00354.rhys@rhyshardwick.co.uk>
	<200504252252.05957.rhys@rhyshardwick.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 03:33:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQExC-0008BZ-2o
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 03:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVDZBig (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 21:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVDZBig
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 21:38:36 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:9352 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261248AbVDZBid (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 21:38:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050426013828.FUOC7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Apr 2005 21:38:28 -0400
To: rhys@rhyshardwick.co.uk
In-Reply-To: <200504252252.05957.rhys@rhyshardwick.co.uk> (Rhys Hardwick's
 message of "Mon, 25 Apr 2005 22:52:05 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Just a wild guess.  Are you trying to run the command from a
subdirectory, not from the top directory (that is, the one that
has subdirectory .git/ in it)?

