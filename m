From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Only use ETC_GITCONFIG=$(prefix)/etc/gitconfig ifeq ($(prefix),$(HOME))
Date: Mon, 23 Apr 2007 21:27:47 -0700
Message-ID: <7vhcr6bdmk.fsf@assigned-by-dhcp.cox.net>
References: <462D673A.1010805@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 06:28:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgCdP-00057U-1w
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 06:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbXDXE1t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 00:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754569AbXDXE1s
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 00:27:48 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:59890 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754566AbXDXE1s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 00:27:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424042748.SNVH1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 24 Apr 2007 00:27:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qsTn1W0021kojtg0000000; Tue, 24 Apr 2007 00:27:47 -0400
In-Reply-To: <462D673A.1010805@freedesktop.org> (Josh Triplett's message of
	"Mon, 23 Apr 2007 19:11:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45408>

Is this really necessary?

I personally think distro people (or anybody who configures git
for system-wide deployment for that matter) already has Makefile
wrapper (a la debian/rules) to take care of this and other
issues.
