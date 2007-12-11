From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 14:46:09 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712111428040.5349@iabervon.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> 
 <e5bfff550712111032p60fedbedu304cab834ce86eb9@mail.gmail.com>
 <4aca3dc20712111103s1af3b045h484ea749378c6282@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
To: Daniel Berlin <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:47:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2B3q-0004cP-5c
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbXLKTqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752365AbXLKTqM
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:46:12 -0500
Received: from iabervon.org ([66.92.72.58]:45191 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbXLKTqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:46:11 -0500
Received: (qmail 19598 invoked by uid 1000); 11 Dec 2007 19:46:09 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Dec 2007 19:46:09 -0000
In-Reply-To: <4aca3dc20712111103s1af3b045h484ea749378c6282@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67923>

On Tue, 11 Dec 2007, Daniel Berlin wrote:

> It is stored in an easier format. However, can you not simply provide
> side-indexes to do the annotation?
> 
> I guess that own't work in git because you can change history (in
> other scm's, history is readonly so you could know the results for
> committed revisions will never change).

History in git is read-only. It's just that git lets you fork and move 
forward with something different. Each commit can never change (and, in 
fact, you'd have to badly break SHA1 to change it), but which commits are 
relevant to the history can change.

Keeping extra information is fine; at worst, it'll go irrelevant.

	-Daniel
*This .sig left intentionally blank*
