From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: stopping patches from just floating by
Date: Sun, 11 Jan 2009 15:37:36 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901111524110.19665@iabervon.org>
References: <87y6xhkb2f.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Sun Jan 11 21:39:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM75K-00074m-2O
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbZAKUhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbZAKUhi
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:37:38 -0500
Received: from iabervon.org ([66.92.72.58]:46924 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbZAKUhh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:37:37 -0500
Received: (qmail 32506 invoked by uid 1000); 11 Jan 2009 20:37:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jan 2009 20:37:36 -0000
In-Reply-To: <87y6xhkb2f.fsf@jidanni.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105222>

On Mon, 12 Jan 2009, jidanni@jidanni.org wrote:

> I notice lots of "Merge branch qq/bla". And think, hmmm, Mr. QQ must
> be using Documentation/everyday.txt's [[Individual Developer
> (Participant)]] git-push methods, for a more efficient way of getting
> his patches included by the maintainer.

Nope, that would lead to "Merge git://qq.org/git bla". In fact, Junio is 
getting the patches by email, and then using that workflow in his own tree 
to manage the maintence process. That is, he creates a branch for each 
patch series that someone sends that looks ready for more exposure, by 
starting with some plausible commit and applying the series of patches, 
and then he can merge than branch into pu, next, master, or maint as 
needed. This is particularly useful for pu, where he redoes all the merges 
frequently; if he worked by just applying the patches, every time he 
wanted to drop a series that he'd applied before some other series, he'd 
have to pick out the conflict resolutions from the original author's 
changes.

	-Daniel
*This .sig left intentionally blank*
