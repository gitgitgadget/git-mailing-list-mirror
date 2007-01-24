From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How to pull only a few files from one branch to another?
Date: Wed, 24 Jan 2007 14:46:01 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701241434540.20138@iabervon.org>
References: <17846.53626.895660.762096@lisa.zopyra.com>
 <Pine.LNX.4.64.0701240019250.20138@iabervon.org> <ep791o$h2u$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 20:47:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9o4Q-0001Sz-1K
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 20:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbXAXTqF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 14:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbXAXTqF
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 14:46:05 -0500
Received: from iabervon.org ([66.92.72.58]:1279 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021AbXAXTqE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 14:46:04 -0500
Received: (qmail 25288 invoked by uid 1000); 24 Jan 2007 14:46:02 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Jan 2007 14:46:02 -0500
In-Reply-To: <ep791o$h2u$2@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37667>

On Wed, 24 Jan 2007, Jakub Narebski wrote:

> Daniel Barkalow wrote:
> 
> > (Incidentally, I think "git diff ^ {commit}" should be made to do "git 
> > diff {commit}^ {commit}"; i.e., if there is a single other revision 
> > provided, interpret a modifier not applied to anything as applying to that 
> > revision, in the "what else could that possibly mean?" department.)
> 
> "git diff <commit>^!" doesn't work?

It generates the right result, but it hasn't become something I 
automatically think of. :) For that matter, "git diff <commit>{^,}" also 
works, but, again, I don't think of it instantly.

	-Daniel
*This .sig left intentionally blank*
