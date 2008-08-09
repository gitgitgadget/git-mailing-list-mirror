From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] git gui: visually wrap lines of commit message
Date: Sun, 10 Aug 2008 00:14:13 +0200
Message-ID: <200808100014.13408.johannes.sixt@telecom.at>
References: <20080809160557.GA902@localhost> <200808092344.33332.johannes.sixt@telecom.at> <20080809220637.GA20963@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Aug 10 00:15:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRwib-0006fc-JH
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 00:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbYHIWOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 18:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbYHIWOQ
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 18:14:16 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:34616 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbYHIWOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 18:14:16 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id EC686BEEBA;
	Sun, 10 Aug 2008 00:14:13 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8307D1226D;
	Sun, 10 Aug 2008 00:14:13 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080809220637.GA20963@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91788>

On Sonntag, 10. August 2008, Clemens Buchacher wrote:
> On Sat, Aug 09, 2008 at 11:44:33PM +0200, Johannes Sixt wrote:
> > On Samstag, 9. August 2008, Clemens Buchacher wrote:
> > > Visually wrap lines in the commit message text box. That way we can
> > > avoid a horizontal scroll bar (which was not available anyways).
> > >
> > > Note: This does _not_ break lines in the actual commit message.
> >
> > Please don't do that. I want to get what I see.
>
> Currently you don't see the whole message anyways if the box is too small
> for the text. I find that quite annoying, especially since there are
> neither keys nor a scrollbar to scroll horizontally.

In this case, I use the middle mouse button to pan around. And then I do see 
what I will get.

The width of the box was chosen wisely: It takes a bit less than 80 columns, 
to leave room for quoting in emails and to avoid wrapping of git log output.

-- Hannes
