From: "Evan Carroll" <me@evancarroll.com>
Subject: Git-submodule questions
Date: Fri, 19 Oct 2007 15:54:51 -0500
Message-ID: <428b865e0710191354v59f558bbv4536d60902977ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 22:55:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiys4-0006xD-6o
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 22:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765361AbXJSUyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 16:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765293AbXJSUyx
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 16:54:53 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:44201 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760098AbXJSUyw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 16:54:52 -0400
Received: by rv-out-0910.google.com with SMTP id k20so567645rvb
        for <git@vger.kernel.org>; Fri, 19 Oct 2007 13:54:52 -0700 (PDT)
Received: by 10.141.211.13 with SMTP id n13mr1243877rvq.1192827291937;
        Fri, 19 Oct 2007 13:54:51 -0700 (PDT)
Received: by 10.67.96.11 with HTTP; Fri, 19 Oct 2007 13:54:51 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61761>

I've got a set of 5 git repositories on one computer. I'm looking for
a way to more cleanly distribute them, and keep them in sync when i
distribute them. I'm trying to discern whether the scantly documented
git-submodule can accomplish this...

All of my git modules are in one place, /srv/DM: /srv/DM/a ..
/srv/DM/e to add them all into one super repository for easier
distributing I have to move them all to /srv/DM/git-old, then git init
in /srv/DM, then I git submodule add all of the modules in
/srv/DM/git-old. The question then comes down to why do I need to have
my git-submodules in /srv/DM, and /srv/DM/git-old.

Can I make a superproject out of /srv/DM and just some how add all of
that directories contents as submodules. When I try to add them as
like that I just get submodule 'a' already exists (because it does as
a non-submodule but as a git-repos.)

Picture a svn repository, now chop of the root, that's how my git
looks, and I'm trying to amend that. In svn all of your companies
projects can be tracked by one svn repository, not so in git. I'm
wondering if submodule is or isn't the tool to deliver this
functionality.

-- 
Evan Carroll
System Lord of the Internets
me@evancarroll.com
832-445-8877
