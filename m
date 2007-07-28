From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn rebase screwing up commit messages
Date: Sat, 28 Jul 2007 05:14:26 -0700
Message-ID: <7v8x90sp25.fsf@assigned-by-dhcp.cox.net>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sat Jul 28 14:14:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IElBy-0005fr-5H
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 14:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbXG1MO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 08:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbXG1MO2
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 08:14:28 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:64560 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbXG1MO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 08:14:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728121427.RICS8237.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Jul 2007 08:14:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id V0ES1X00C1kojtg0000000; Sat, 28 Jul 2007 08:14:27 -0400
In-Reply-To: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr> (Benoit
	SIGOURE's message of "Sat, 28 Jul 2007 12:07:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54025>

Benoit SIGOURE <tsuna@lrde.epita.fr> writes:

> git version 1.5.2.3 over here, I've googled and searched in the ML
> archives but did not find this:  when I git-svn rebase, my commits in
> Git (that are temporarily removed and then re-applied) get their
> commit message flattened on a single line...

Do you mean by "my commits in Git" a commit you created with git
in your git repository?
