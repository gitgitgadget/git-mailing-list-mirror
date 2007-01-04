From: Junio C Hamano <junkio@cox.net>
Subject: Re: clarification on git-update-index --remove
Date: Thu, 04 Jan 2007 12:27:43 -0800
Message-ID: <7vwt42k05c.fsf@assigned-by-dhcp.cox.net>
References: <e1dab3980701041129l3944df8ep985141d8f436d0a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 21:27:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2ZBk-0004b0-ID
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 21:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbXADU1p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 15:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbXADU1p
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 15:27:45 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:43166 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030186AbXADU1p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 15:27:45 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070104202744.WCYZ7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Thu, 4 Jan 2007 15:27:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 78Tz1W0031kojtg0000000; Thu, 04 Jan 2007 15:27:59 -0500
To: "David Tweed" <david.tweed@gmail.com>
In-Reply-To: <e1dab3980701041129l3944df8ep985141d8f436d0a7@mail.gmail.com>
	(David Tweed's message of "Thu, 4 Jan 2007 19:29:32 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35953>

"David Tweed" <david.tweed@gmail.com> writes:

> --remove::
> 	If a specified file is in the index but is missing then it's
> 	removed.
> 	Default behavior is to ignore removed file.

If necessary, better rewording to remove confusion is very much
appreciated.

"update-index <path>..." without options (that is "Default
behaviour") updates the index using the contents of the named
<path> found on the filesystem.  It does _not_ add new paths to
the index, nor remove paths (that exists in the index) from the
index.

Giving --add allows new paths to be added to the index if named
paths are found on the filesystem.  Giving --remove allows
existing paths to be removed from the index if named paths are
not found on the filesystem.
