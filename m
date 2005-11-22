From: Junio C Hamano <junkio@cox.net>
Subject: Re: strange cg-add problem
Date: Tue, 22 Nov 2005 08:55:38 -0800
Message-ID: <7vbr0cfwqd.fsf@assigned-by-dhcp.cox.net>
References: <20051122123058.GB19989@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 17:59:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EebR7-0001J7-5u
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 17:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVKVQzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 11:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVKVQzn
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 11:55:43 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:5369 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S965005AbVKVQzl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 11:55:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122165511.WRCT15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 11:55:11 -0500
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
In-Reply-To: <20051122123058.GB19989@schottelius.org>
	(nico-linux-git@schottelius.org's message of "Tue, 22 Nov 2005
	13:30:58 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12554>

Nico -telmich- Schottelius <nico-linux-git@schottelius.org> writes:

> srwali01:/home/server/backup/db# ~/db-dump.sh 
> /home/server/backup/db//2005-11-22/13:26 does not exist or is not a regular file
> cg-add: warning: not all files could be added
> cg-commit: Nothing to commit

I do not use cogito, but I suspect it would work if you change
your script to avoid double slash between db and 2005-11-22.
