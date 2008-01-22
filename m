From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Using email between 2 developers to keep git repositories in
 sync
Date: Tue, 22 Jan 2008 17:22:31 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801221713120.13593@iabervon.org>
References: <7A02F7D1-9EB0-43AB-96F9-DDD71D4EF5FE@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: ab_lists@mac.com
X-From: git-owner@vger.kernel.org Tue Jan 22 23:23:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHRWR-0004by-JS
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 23:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbYAVWWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 17:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752355AbYAVWWe
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 17:22:34 -0500
Received: from iabervon.org ([66.92.72.58]:48762 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980AbYAVWWd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 17:22:33 -0500
Received: (qmail 6997 invoked by uid 1000); 22 Jan 2008 22:22:31 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jan 2008 22:22:31 -0000
In-Reply-To: <7A02F7D1-9EB0-43AB-96F9-DDD71D4EF5FE@mac.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71474>

On Tue, 22 Jan 2008, ab_lists@mac.com wrote:

> Hello there,
> 
> I have been converted to git after reading good things about it. I have been
> using it with a personal project and so I'm familiar with the basics.
> However I need to share code with a co-developer. He also has a code base that
> I need access to. For several reasons, a shared server will not work so I was
> thinking of using email to send patches back and forth.

I think bundles or email or both is likely to be the correct solution, but 
you should know that you don't need a shared server if you each have a 
server the other can read from. Each of you sets up a public repository 
with the same basic history, and you each have local clones of your public 
repository, and you pull from the other into your local clone and 
(assuming you want to accept the other's changes) you do the merge and 
push to your own public server.

In fact, having a shared server is vaguely discouraged, since it means 
there's a repository that's no single individual's responsibility; it's 
just that it's often the case that the existing social structure is based 
on a group of co-maintainers of a single series.

	-Daniel
*This .sig left intentionally blank*
