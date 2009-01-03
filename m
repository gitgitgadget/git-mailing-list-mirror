From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git checkout does not warn about tags without corresponding
 commits
Date: Sat, 3 Jan 2009 14:31:24 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901031410130.19665@iabervon.org>
References: <200901021325.58049.henrik@austad.us> <7v8wptcrhp.fsf@gitster.siamese.dyndns.org> <200901031200.01883.henrik@austad.us> <7vr63k8vvf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Henrik Austad <henrik@austad.us>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 20:34:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJCGH-0004g4-8M
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 20:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759526AbZACTb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 14:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759459AbZACTb1
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 14:31:27 -0500
Received: from iabervon.org ([66.92.72.58]:37132 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759302AbZACTb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 14:31:26 -0500
Received: (qmail 8814 invoked by uid 1000); 3 Jan 2009 19:31:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Jan 2009 19:31:24 -0000
In-Reply-To: <7vr63k8vvf.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104478>

On Sat, 3 Jan 2009, Junio C Hamano wrote:

> Henrik Austad <henrik@austad.us> writes:
> 
> > On Friday 02 January 2009 22:44:50 Junio C Hamano wrote:
> >> Henrik Austad <henrik@austad.us> writes:
> >> > I recently tried to do a checkout of (what I thought was the first) inux
> >> > kernel in the linux git repo.
> >> >
> >> > git checkout -b 2.6.11 v2.6.11
> >>
> >> This should have barfed, and indeed I think it is a regression around
> >> v1.5.5.  v1.5.4 and older git definitely fails to check out a tree object
> >> like that.
> >
> > You're right, I bisected it down to commit 
> > 782c2d65c24066a5d83453efb52763bc34c10f81
> 
> I am not surprised.
> 
> That one discarded an implementation of "git checkout" in Bourne shell,
> with a complete reimplementation in C.
> 
> I haven't looked at the code very closely, but I think this should fix
> it.  Thorough reviewing (not just running the test suite) is much
> appreciated.

That looks right to me.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

	-Daniel
*This .sig left intentionally blank*
