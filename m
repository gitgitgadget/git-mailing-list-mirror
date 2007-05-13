From: Junio C Hamano <junkio@cox.net>
Subject: Re: suggestions for gitweb
Date: Sat, 12 May 2007 17:54:01 -0700
Message-ID: <7vabw9v906.fsf@assigned-by-dhcp.cox.net>
References: <20070512205529.GS14859@MichaelsNB>
	<7v8xbtwtsy.fsf@assigned-by-dhcp.cox.net>
	<1f3701c794eb$5ff781b0$0200a8c0@AMD2500> <f25mic$1b1$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 13 02:54:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn2Lj-00069I-0k
	for gcvg-git@gmane.org; Sun, 13 May 2007 02:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbXEMAyF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 20:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754336AbXEMAyF
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 20:54:05 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35732 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbXEMAyD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 20:54:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070513005402.XTUN1318.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 20:54:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yQu01W00R1kojtg0000000; Sat, 12 May 2007 20:54:01 -0400
In-Reply-To: <f25mic$1b1$2@sea.gmane.org> (Jakub Narebski's message of "Sun,
	13 May 2007 02:41:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47119>

Jakub Narebski <jnareb@gmail.com> writes:

> Lines of code and file sizes: file size needs additional invocation
> per each file for gitweb; it would be easier for cgit. Costly! Counting
> LOC is even more costly: take note that 1.) gitweb operates directly
> on repository / object database, and does not use working area, 
> 2.) git is snapshot based and not changeset based.

We earlier discussed to make --numstat to allow us add this kind
of information for easier script consumption.

Perhaps instead of modifying --numstat, we may be better off to
add another format that can be more easily extended to support
other things, like we do for the --porcelain format out of
git-blame?  It does not have to be one line per record, like the
way --numstat was done, which was primarily in order to make it
a compact, human readable format.
