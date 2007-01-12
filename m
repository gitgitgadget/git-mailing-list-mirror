From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Explain "Not a git repository: '.git'".
Date: Fri, 12 Jan 2007 12:55:00 -0800
Message-ID: <7vtzywrmmz.fsf@assigned-by-dhcp.cox.net>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
	<200701121501.24642.andyparkins@gmail.com>
	<7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 21:55:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5TQa-0004BR-E4
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 21:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbXALUzE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 15:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbXALUzE
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 15:55:04 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:42082 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030331AbXALUzD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 15:55:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112205501.RQZV25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 15:55:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ALu91W01A1kojtg0000000; Fri, 12 Jan 2007 15:54:10 -0500
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 12 Jan 2007 12:26:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36705>

I have three follow-up patches, two are probably Ok (but I'd
rather not apply them to 'master' now -rc1 cycle is on), and the
last one debatable.

  [PATCH 1/3] Define cd_to_toplevel shell function in git-sh-setup
  [PATCH 2/3] Use cd_to_toplevel in scripts that implement it by hand.
  [PATCH 3/3] Allow whole-tree operations to be started from a subdirectory
