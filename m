From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Submodule complaint
Date: Fri, 21 Nov 2008 20:51:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811212043430.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 20:45:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3bwB-0005OV-Ic
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 20:45:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbYKUTnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 14:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbYKUTnu
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 14:43:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:49742 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751942AbYKUTnt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 14:43:49 -0500
Received: (qmail invoked by alias); 21 Nov 2008 19:43:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 21 Nov 2008 20:43:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+fVv5A40SfmiUCgV6FKJ1oFujCfk4TzTzNK5FSaT
	RJmU5p4wZ6ED43
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101536>

Hi,

just to let you know (those who are capable of coding, that is): 
submodules are _still_ a 2nd-class citizen, and very much so.

With a commit where you _know_ that a submodule has a different version 
than the current one, try this:

	$ git checkout $COMMIT -- $SUBMODULE

You will realize that it does not change the "git status" output (i.e. it 
does not change the index), which is wrong, wrong, wrong.

Ciao,
Dscho

P.S.: If I would not have enjoyed my rightfully deserved weekend beers, I 
would have taken take care of this myself, depriving _you_ of 
commit-karma.  So, in a way I am giving you the chance to increase your 
value ;-)
