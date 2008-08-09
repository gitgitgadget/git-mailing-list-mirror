From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] git gui: visually wrap lines of commit message
Date: Sun, 10 Aug 2008 00:06:37 +0200
Message-ID: <20080809220637.GA20963@localhost>
References: <20080809160557.GA902@localhost> <200808092344.33332.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Aug 10 00:07:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRwaf-0004r4-Pf
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 00:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbYHIWGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 18:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbYHIWGJ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 18:06:09 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:35612 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbYHIWGI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 18:06:08 -0400
Received: from darc.dyndns.org ([84.154.99.38]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 10 Aug 2008 00:06:06 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KRwa5-0005W4-BO; Sun, 10 Aug 2008 00:06:37 +0200
Content-Disposition: inline
In-Reply-To: <200808092344.33332.johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 09 Aug 2008 22:06:07.0038 (UTC) FILETIME=[1F67FDE0:01C8FA6C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91787>

On Sat, Aug 09, 2008 at 11:44:33PM +0200, Johannes Sixt wrote:
> On Samstag, 9. August 2008, Clemens Buchacher wrote:
> > Visually wrap lines in the commit message text box. That way we can avoid
> > a horizontal scroll bar (which was not available anyways).
> >
> > Note: This does _not_ break lines in the actual commit message.
> 
> Please don't do that. I want to get what I see.

Currently you don't see the whole message anyways if the box is too small
for the text. I find that quite annoying, especially since there are neither
keys nor a scrollbar to scroll horizontally.

And if you break the lines manually, it really doesn't make a difference.
Unless you "forget" to do so, which is unlikely, because the virtual wrap
will wrap per-character and not per-word.

Clemens
