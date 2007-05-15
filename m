From: Junio C Hamano <junkio@cox.net>
Subject: Re: newby question about merge.
Date: Tue, 15 May 2007 14:47:51 -0700
Message-ID: <7vabw5iws8.fsf@assigned-by-dhcp.cox.net>
References: <20070515113820.2621c8d5@localhost.localdomain>
	<f2c23k$dm0$1@sea.gmane.org>
	<20070515133720.20d76042@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: picca <picca@synchrotron-soleil.Fr>
X-From: git-owner@vger.kernel.org Tue May 15 23:47:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho4sA-0002au-Q0
	for gcvg-git@gmane.org; Tue, 15 May 2007 23:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672AbXEOVrx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 17:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755616AbXEOVrx
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 17:47:53 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:48549 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467AbXEOVrx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 17:47:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070515214753.MFVW2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 15 May 2007 17:47:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zZns1W0031kojtg0000000; Tue, 15 May 2007 17:47:52 -0400
In-Reply-To: <20070515133720.20d76042@localhost.localdomain>
	(picca@synchrotron-soleil.Fr's message of "Tue, 15 May 2007 13:37:20
	+0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47377>

picca <picca@synchrotron-soleil.Fr> writes:

> Is it possible to add this git cat-file -p :2:filename > filename in
> the man page of git-merge in the resolve conflict part ?
>
> Or a link to the documentation speaking of this stage part.

See:

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#conflict-resolution

As this walk through section from the user manual's already
talks about it, I am not sure if we would want to duplicate its
wording in git-merge manual page.

Regardlessly, I think it is a good idea to refer to it in SEE
ALSO section, just in case the user hasn't read the user manual
before reading the git-merge manpage.
