From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase behaviour changed?
Date: Mon, 16 Jan 2006 22:29:02 -0800
Message-ID: <7v7j8zfjv5.fsf@assigned-by-dhcp.cox.net>
References: <43CC695E.2020506@codeweavers.com>
	<7vslrnh080.fsf@assigned-by-dhcp.cox.net>
	<43CC89DC.5060201@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 07:29:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EykL6-00037E-So
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 07:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWAQG3F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 01:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWAQG3E
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 01:29:04 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:42129 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751216AbWAQG3D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 01:29:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060117062907.QPEW25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 Jan 2006 01:29:07 -0500
To: Mike McCormack <mike@codeweavers.com>
In-Reply-To: <43CC89DC.5060201@codeweavers.com> (Mike McCormack's message of
	"Tue, 17 Jan 2006 15:08:28 +0900")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14782>

Mike McCormack <mike@codeweavers.com> writes:

> btw. I'm not the only person having this problem.  Others using the
> same commands, and upgrading GIT have run into it too, so something
> has changed...

Sorry, I accidentally removed the part from my message where I
said "Yes it was changed on Nov 28 after discussion on the list
regarding rebase".

	$ git whatchanged -S'is up to date' git-rebase.sh

would show that commit.
