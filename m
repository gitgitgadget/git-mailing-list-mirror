From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: Having $GIT_COMMITTER_NAME implies -s
Date: Wed, 16 Nov 2005 20:28:17 -0800
Message-ID: <7vbr0j3nku.fsf@assigned-by-dhcp.cox.net>
References: <20051116233829.0B3C55BA81@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 05:29:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcbO3-0002y4-Tl
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 05:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbVKQE2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 23:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbVKQE2T
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 23:28:19 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:24010 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1161129AbVKQE2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 23:28:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051117042742.TEHM20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 23:27:42 -0500
To: exon@op5.se (Andreas Ericsson)
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12085>

I am not so sure about this.  A Signed-off-by line used in the
kernel and git projects has a specific meaning; you've read
SubmittingPatches in either projects, have'nt you?

I do work on a machine from which I make commits to both git
project and my day-job work project.  I do not necessarily want
to add Signed-off-by line in commits I make for the latter.
