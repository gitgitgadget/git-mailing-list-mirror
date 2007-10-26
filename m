From: Gerrit Pape <pape@smarden.org>
Subject: Re: git-svnimport
Date: Fri, 26 Oct 2007 14:55:20 +0000
Message-ID: <20071026145520.2141.qmail@7a6a65599aed61.315fe32.mid.smarden.org>
References: <31e679430710250225w39a876d0w738d819245e514e@mail.gmail.com> <Pine.LNX.4.64.0710251132580.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 16:55:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlQal-0007jY-3E
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 16:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbXJZOzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 10:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbXJZOzD
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 10:55:03 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:33544 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751142AbXJZOzB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 10:55:01 -0400
Received: (qmail 2142 invoked by uid 1000); 26 Oct 2007 14:55:20 -0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710251132580.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62413>

On Thu, Oct 25, 2007 at 11:56:44AM +0100, Johannes Schindelin wrote:
> On Thu, 25 Oct 2007, Felipe Balbi wrote:
> > I was importing busybox svn repository to git but I got a connection 
> > timeout after more than 19k commits... is there a way to continue where 
> > the error happened or should I do it all over again ??
> 
> AFAICT git-svn is better suited, even to one-shot importing svn.

AIUI git-svnimport provides a subset of git-svn's functionality.
There've been some problems with git-svnimport reported through the
Debian BTS

 http://bugs.debian.org/436930
 http://bugs.debian.org/447325
 http://bugs.debian.org/447965

I'm not sure these are worth fixing, I'd rather suggest to drop
git-svnimport in favor of git-svn, and not installing it in future
versions.

Regards, Gerrit.
