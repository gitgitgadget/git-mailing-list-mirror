From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: how to move with history?
Date: Tue, 19 Jun 2007 20:28:34 +0100
Message-ID: <20070619192834.GS3037@cs-wsok.swansea.ac.uk>
References: <20070618191607.GK3037@cs-wsok.swansea.ac.uk> <20070618194907.GA12445@steel.home> <20070618202918.GM3037@cs-wsok.swansea.ac.uk> <20070618210743.GA16397@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 21:14:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0jA0-0003UP-IX
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 21:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933027AbXFSTOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 15:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933011AbXFSTOi
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 15:14:38 -0400
Received: from mhs.swan.ac.uk ([137.44.1.33]:44012 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933023AbXFSTOh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 15:14:37 -0400
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.66)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1I0j9v-0003es-8W; Tue, 19 Jun 2007 20:14:35 +0100
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id E7F6F45EA6;
	Tue, 19 Jun 2007 20:14:34 +0100 (BST)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 33B8874191; Tue, 19 Jun 2007 20:28:34 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20070618210743.GA16397@steel.home>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50502>

Thanks for all the replies!

Now I see pretty clear; a quick summary
(in case somebody else wants to learn from this):

1.

"git mv file new_file" seems to be (exactly?) equivalent to

mv file new_file
git rm file
git add new_file

(Perhaps this information could be added to the git-mv-documentation?
I would have found it useful (since I had a different expectation).)

2. To do something with the history, for example to rename "file"
to "new_file" also in the whole history, a new repository (or
a new branch) has to be created. Three possibilities:
 
 (a) Using the basic git-functionality, re-creating a repository
     by re-creating all commits (with appropriate changes) by "hand"
     or "script".
 (b) More convenient, the upcoming "git-filter-branch" apparently
     makes filtering out easier.
 (c) Or, apparently more powerful, with "cg-admin-rewritehis"
     (part of the cogito-tool) we have quite a powerful tool
     for creating a branch with a (re-created and modified)
     history (the documentation explicitely mentions how to
     remove a file from history --- that is, in the new branch).

Hope that's correct.

Thanks a lot to all!

Oliver
