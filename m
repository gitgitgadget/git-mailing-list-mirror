From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/8] diff: support reading a file from stdin via "-"
Date: Sun, 25 Feb 2007 16:03:47 -0800
Message-ID: <7vejodrdi4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702252335410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvehprgl7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702260009530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7virdprejh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 26 01:03:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLTLL-0007lx-0J
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 01:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835AbXBZADs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 19:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933701AbXBZADs
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 19:03:48 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:38969 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932835AbXBZADs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 19:03:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070226000348.SUZO3546.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 19:03:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U03m1W00Q1kojtg0000000; Sun, 25 Feb 2007 19:03:47 -0500
In-Reply-To: <7virdprejh.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 25 Feb 2007 15:41:22 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40598>

Another hack just occurred to me... get_pathspec() could
translate '-' to /dev/stdin while leaving './-' to '-'.

It could be rather too ugly to the taste of some people.
Myself, I dunno...
