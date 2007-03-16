From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question about bare repositories
Date: Fri, 16 Mar 2007 03:05:02 -0700
Message-ID: <7vhcslv701.fsf@assigned-by-dhcp.cox.net>
References: <200703160947.03833.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 11:05:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS9J7-0002xy-HC
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 11:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933565AbXCPKFF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 06:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933566AbXCPKFF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 06:05:05 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:49274 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933565AbXCPKFD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 06:05:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070316100503.HHWU18070.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Mar 2007 06:05:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bN521W00d1kojtg0000000; Fri, 16 Mar 2007 06:05:03 -0400
In-Reply-To: <200703160947.03833.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 16 Mar 2007 09:47:02 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42344>

Andy Parkins <andyparkins@gmail.com> writes:

> Why does a bare repository have/need a HEAD?

To mark which branch the repository owner considers the primary
branch of the repository.  I think "git pull $URL" (i.e. without
using shorthand arranged in the config nor $GIT_DIR/remotes/)
defaults to fetching and merging HEAD from there, for example (I
say "I think" because it's been a while I did so myself, and we
might have broken it during the 1.5.0 process, which had a lot
of work in that area).
