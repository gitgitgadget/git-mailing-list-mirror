From: Francesc Guasch <frankie@etsetb.upc.edu>
Subject: importing svn directori inside git project
Date: Fri, 9 Jul 2010 11:34:22 +0200
Message-ID: <20100709093422.GC31968@etsetb.upc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 09 13:45:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXC19-0001ja-1A
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 13:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856Ab0GILpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 07:45:12 -0400
Received: from dash.upc.es ([147.83.2.50]:34538 "EHLO dash.upc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755834Ab0GILpL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 07:45:11 -0400
X-Greylist: delayed 7819 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jul 2010 07:45:11 EDT
Received: from xena.upc.es (xena.upc.es [147.83.36.242])
	by dash.upc.es (8.14.1/8.13.1) with ESMTP id o699YoiX012524
	for <git@vger.kernel.org>; Fri, 9 Jul 2010 11:34:51 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
	by xena.upc.es (Postfix) with ESMTP id E35CA2026493
	for <git@vger.kernel.org>; Fri,  9 Jul 2010 11:34:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at etsetb.upc.edu
Received: from xena.upc.es ([127.0.0.1])
	by localhost (mail.etsetb.upc.es [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nt4KoiG4SdBe for <git@vger.kernel.org>;
	Fri,  9 Jul 2010 11:34:26 +0200 (CEST)
Received: from etsetb.upc.edu (jolibus.upc.es [147.83.36.68])
	by xena.upc.es (Postfix) with ESMTP id 279E42025CD9
	for <git@vger.kernel.org>; Fri,  9 Jul 2010 11:34:26 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Mail-Scanned: Criba 2.0 + Clamd
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (dash.upc.es [147.83.2.50]); Fri, 09 Jul 2010 11:34:51 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150653>

Hi. I have some svn projects I want to join in a git big project.

I've been trying with guidelines from the git faq and from 
  http://www.jonmaddox.com/2008/03/05/cleanly-migrate-your-subversion-repository-to-a-git-repository/
but I'm not able to do it.

So I have a new git project I make it like this:


  $ mkdir project
  $ cd project
  $ git init

Then I want to import the svn project. If I do this I get the files:

  $ mkdir subproject1
  $ cd subproject1
  $ git-svn init http://iteleco/repos/vnproject --no-metadata
  $ git config svn.authorsfile ~/users.txt
  $ git-svn fetch
  
Now I have all the files inside subproject1 but the main git project
does not know anything about them. It looks like I should add all of
them but I will lose all the svn history.

Is it possible to do what I want ?

thank you very much.
