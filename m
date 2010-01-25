From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Perforce vcs-helper
Date: Mon, 25 Jan 2010 16:25:01 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1001251615430.14365@iabervon.org>
References: <1a6be5fa1001250257s333339fdq9a08e91fdb84fd3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git mailing list <git@vger.kernel.org>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 22:25:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZWQo-00014q-1I
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 22:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab0AYVZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 16:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892Ab0AYVZE
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 16:25:04 -0500
Received: from iabervon.org ([66.92.72.58]:51835 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab0AYVZE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 16:25:04 -0500
Received: (qmail 4444 invoked by uid 1000); 25 Jan 2010 21:25:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jan 2010 21:25:01 -0000
In-Reply-To: <1a6be5fa1001250257s333339fdq9a08e91fdb84fd3d@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137995>

On Mon, 25 Jan 2010, Tor Arvid Lund wrote:

> Hi, Daniel.
> 
> I remember that you posted a vcs-p4 transport helper last year... And
> I basically wondered whether or not that is something that you're
> still working on. As I understand it, the transport helper framework
> will be part of git 1.7, and I thought it would be interesting to test
> your code.

I've updated it slightly for changes in the transport helper framework, 
but I haven't done too much else on it. In particular, it's still doing 
the push side in a way I now don't like, and, in general, relies a bit too 
much on the local side going into a git database.

> The current git-p4 script is nice, of course, but I would much like to
> try the "detect branches and integrations" stuff :-)

Sure, I'll post the latest version shortly.

	-Daniel
*This .sig left intentionally blank*
