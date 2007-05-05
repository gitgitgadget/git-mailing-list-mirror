From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Sat, 05 May 2007 13:17:35 -0700
Message-ID: <7vy7k3hvog.fsf@assigned-by-dhcp.cox.net>
References: <463BD40C.6080909@gmail.com>
	<Pine.LNX.4.64.0705050324580.4015@racer.site>
	<20070505033039.GD16538@spearce.org>
	<20070505193214.GD30511@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Sat May 05 22:17:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkQhJ-0004Y0-2n
	for gcvg-git@gmane.org; Sat, 05 May 2007 22:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933318AbXEEURi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 16:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933327AbXEEURh
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 16:17:37 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:34287 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933318AbXEEURh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 16:17:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070505201736.IVCT13903.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 5 May 2007 16:17:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id vYHb1W0051kojtg0000000; Sat, 05 May 2007 16:17:36 -0400
In-Reply-To: <20070505193214.GD30511@admingilde.org> (Martin Waitz's message
	of "Sat, 5 May 2007 21:32:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46284>

Martin Waitz <tali@admingilde.org> writes:

> we could also introduce "<tree-ish>/<path>" for absolute path entries.

When you name the tree-ish with usual "branch name", where does
the branch name end and pathname start?  What happens when there
is an ambiguity, and how costly to detect such an ambiguity to
begin with?
