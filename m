From: Junio C Hamano <junkio@cox.net>
Subject: Re: multiple .gitignore-s
Date: Sun, 22 Apr 2007 14:46:43 -0700
Message-ID: <7vwt04krp8.fsf@assigned-by-dhcp.cox.net>
References: <f36b08ee0704221436g661396b6m4ed8e16676175f4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Yakov Lerner" <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 23:46:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfjtQ-0003yz-L4
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 23:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbXDVVqp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 17:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbXDVVqp
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 17:46:45 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:42342 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbXDVVqo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 17:46:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422214643.PIOI1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 17:46:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qMmk1W0031kojtg0000000; Sun, 22 Apr 2007 17:46:44 -0400
In-Reply-To: <f36b08ee0704221436g661396b6m4ed8e16676175f4a@mail.gmail.com>
	(Yakov Lerner's message of "Mon, 23 Apr 2007 00:36:22 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45283>

"Yakov Lerner" <iler.ml@gmail.com> writes:

> If repo has toplevel .gitignore, and subdir A/B
> has also .gitignore, then how these two .gitignore-s
> interact to affect A/B ? Are they shadowed, or accumulated ?

Study "Exclude Patterns" section of git-ls-files documentation,
perhaps?
