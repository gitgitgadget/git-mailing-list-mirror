From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git protocol specification
Date: Thu, 10 Jul 2008 01:47:50 +0000
Message-ID: <20080710014750.GA7714@spearce.org>
References: <48750231.4020805@rubyisawesome.com> <alpine.DEB.1.00.0807092044120.4010@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Tom Werner <pubsub@rubyisawesome.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 03:48:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGlH9-0001W8-QO
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 03:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612AbYGJBrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 21:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755032AbYGJBrv
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 21:47:51 -0400
Received: from george.spearce.org ([209.20.77.23]:44390 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbYGJBrv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 21:47:51 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4D32A381FC; Thu, 10 Jul 2008 01:47:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807092044120.4010@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87929>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 9 Jul 2008, Tom Werner wrote:
> 
> > I'm working on a flexible Erlang replacement for git-daemon and would 
> > like to know if there is a specification available for the protocol that 
> > git-upload-pack and git-receive-pack use.
> 
> How about Documentation/technical/pack-protocol.txt?

You may also want to look at jgit's source code.  Its a cleaner
implementation of the protocol in 100% Java.  Not something you
would want to try and call directly from in Erlang, but it may
be easier to follow.

  http://repo.or.cz/w/egit.git/

Look inside of the org.spearce.jgit/src/org/spearce/jgit/transport
package.  In particular the client side of the protocol for git://
is in the TransportGitAnon class as two inner subclasses, one for
fetch ('git-upload-pack') and another for push ('git-receive-pack').

-- 
Shawn.
