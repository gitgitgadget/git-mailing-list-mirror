From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: change filename/directory name of snapshots
Date: Fri, 08 Jun 2007 01:43:04 -0700
Message-ID: <7v4pliltuv.fsf@assigned-by-dhcp.cox.net>
References: <20070607092708.GA25097@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 08 10:43:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwa3q-0005xH-Qt
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 10:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936760AbXFHInI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 04:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936824AbXFHInI
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 04:43:08 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38298 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936760AbXFHInH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 04:43:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070608084305.ZZVN5800.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Jun 2007 04:43:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8wj41X0071kojtg0000000; Fri, 08 Jun 2007 04:43:04 -0400
In-Reply-To: <20070607092708.GA25097@moooo.ath.cx> (Matthias Lederhofer's
	message of "Thu, 7 Jun 2007 11:27:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49449>

Matthias Lederhofer <matled@gmx.net> writes:

> /.git or .git is removed from the project name and the
> basename of the remaining path is used as the beginning of
> the filename and as the directory in the archive.
>
> The regexp will actually not strip off /.git or .git if there
> wouldn't be anything left after removing it.
>
> Currently the full project name is used as directory in the
> archive and the basename is used as filename.  For example a
> repository named foo/bar/.git will have a archive named
> .git-<version>.* and extract to foo/bar/.git.  With this patch
> the file is named bar-<version>.* and extracts to bar.

Makes sense to me for "foo/bar/.git", but I am not sure if we
would want to do this to "foo/bar.git".  Opinions?
