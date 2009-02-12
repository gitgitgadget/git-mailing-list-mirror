From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/3] builtin-remote: teach show to display remote HEAD
Date: Thu, 12 Feb 2009 16:34:01 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902121627520.19665@iabervon.org>
References: <1234332083-45147-1-git-send-email-jaysoffian@gmail.com> <1234332083-45147-2-git-send-email-jaysoffian@gmail.com> <1234332083-45147-3-git-send-email-jaysoffian@gmail.com> <20090212002612.GC30231@coredump.intra.peff.net>
 <76718490902111748j58f80591ma149f8ec9fb8b352@mail.gmail.com> <alpine.LNX.1.00.0902121519160.19665@iabervon.org> <7vfxijjqlb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:35:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXjDZ-0003Jx-62
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758072AbZBLVeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756772AbZBLVeF
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:34:05 -0500
Received: from iabervon.org ([66.92.72.58]:53176 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754932AbZBLVeE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:34:04 -0500
Received: (qmail 2380 invoked by uid 1000); 12 Feb 2009 21:34:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Feb 2009 21:34:01 -0000
In-Reply-To: <7vfxijjqlb.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109662>

On Thu, 12 Feb 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I have the vague memory, as well, that there's some way for a transport to 
> > report that it actually knows that HEAD is a symref to something in 
> > particular, and so git shouldn't guess.
> 
> I think you are thinking about:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/102039

Actually, I think I missed that thread entirely; I was thinking of earlier 
work to allow the http transport, when it finds that HEAD is a symref 
file, to report that there's a ref named "HEAD", with a particular value, 
and that it's incidentally known to be a symref to another particular ref.

Ended up in be885d96fe0ebed47e637f3b0dd24fc5902f7081, but I don't think 
anything was set up to actually do anything with the information.

	-Daniel
*This .sig left intentionally blank*
