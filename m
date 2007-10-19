From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git-submodule questions
Date: Fri, 19 Oct 2007 14:22:48 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710191420410.26902@woody.linux-foundation.org>
References: <428b865e0710191354v59f558bbv4536d60902977ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Evan Carroll <me@evancarroll.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 23:23:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IizJC-0005Aw-ES
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 23:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760932AbXJSVWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 17:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759083AbXJSVWy
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 17:22:54 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52957 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757929AbXJSVWy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 17:22:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9JLMnr5032604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 19 Oct 2007 14:22:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9JLMmAo020744;
	Fri, 19 Oct 2007 14:22:49 -0700
In-Reply-To: <428b865e0710191354v59f558bbv4536d60902977ac@mail.gmail.com>
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61766>



On Fri, 19 Oct 2007, Evan Carroll wrote:
>
> I've got a set of 5 git repositories on one computer. I'm looking for
> a way to more cleanly distribute them, and keep them in sync when i
> distribute them. I'm trying to discern whether the scantly documented
> git-submodule can accomplish this...

Sounds like subprojects are indeed a good way for you.

> All of my git modules are in one place, /srv/DM: /srv/DM/a ..
> /srv/DM/e to add them all into one super repository for easier
> distributing I have to move them all to /srv/DM/git-old, then git init
> in /srv/DM, then I git submodule add all of the modules in
> /srv/DM/git-old. The question then comes down to why do I need to have
> my git-submodules in /srv/DM, and /srv/DM/git-old.

You shouldn't need to do anything even half-way complicated like that.

In fact, it should be enough to do

	cd /srv/DM
	git init
	git add .
	git commit

and you're now literally all done!

		Linus
