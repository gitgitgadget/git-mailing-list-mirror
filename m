From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Importing all modules in a CVS repo with git-cvsimport
Date: Wed, 19 Mar 2008 16:10:47 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803191602110.19665@iabervon.org>
References: <1205951736.24610.3.camel@pitcairn.cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:27:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4rd-0004ng-8j
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764294AbYCSUKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 16:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764284AbYCSUKv
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:10:51 -0400
Received: from iabervon.org ([66.92.72.58]:59352 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755556AbYCSUKu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:10:50 -0400
Received: (qmail 14510 invoked by uid 1000); 19 Mar 2008 20:10:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Mar 2008 20:10:47 -0000
In-Reply-To: <1205951736.24610.3.camel@pitcairn.cambridgebroadband.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77534>

On Wed, 19 Mar 2008, Alex Bennee wrote:

> Hi,
> 
> I'm wanting to import the entirety of a CVS repository into git rather
> than an individual module. However every approach I've tried to do this
> fails as the underlying cvsps tool seems to only be able to deal with
> modules rather than the whole project.
> 
> Is there any invocation I could do that would do the whole import?

A for loop? I don't think it's possible to treat the modules as just 
subdirectories, but you can loop over the modules, importing each of them 
into a separate git repository and then, if you want, merge each of them 
into a new master repository with the "subdirectory" strategy.

	-Daniel
*This .sig left intentionally blank*
