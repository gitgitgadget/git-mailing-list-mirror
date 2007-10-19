From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git on afs
Date: Fri, 19 Oct 2007 16:19:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710191541360.32497@iabervon.org>
References: <20071018203106.GA13518@fries.net> <20071019054814.GJ14735@spearce.org>
 <200710190742.08174.todd@fries.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Brandon Casey <casey@nrlssc.navy.mil>
To: "Todd T. Fries" <todd@fries.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 22:20:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiyK6-00009n-Sd
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 22:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760240AbXJSUTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 16:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760167AbXJSUTr
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 16:19:47 -0400
Received: from iabervon.org ([66.92.72.58]:56201 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758401AbXJSUTr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 16:19:47 -0400
Received: (qmail 3274 invoked by uid 1000); 19 Oct 2007 20:19:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Oct 2007 20:19:45 -0000
In-Reply-To: <200710190742.08174.todd@fries.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61759>

On Fri, 19 Oct 2007, Todd T. Fries wrote:

> You're the second one to point out that I should check the errno of link() on
> afs.
> 
> It should not matter, but I'm using arla's afs client on OpenBSD; the errno
> is 17 (EEXIST), the very errno that bypasses the coda hack's rename():

According to a quick web search, OpenAFS gives EXDEV (unless there are 
other errors that apply). Getting EEXIST when the new path doesn't exist 
sounds like a bug in arla to me, although it could also be an AFS server 
issue, AFAICT.

	-Daniel
*This .sig left intentionally blank*
