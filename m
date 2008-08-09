From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] git gui: visually wrap lines of commit message
Date: Sun, 10 Aug 2008 00:41:50 +0200
Message-ID: <20080809224150.GA21530@localhost>
References: <20080809160557.GA902@localhost> <200808092344.33332.johannes.sixt@telecom.at> <20080809220637.GA20963@localhost> <200808100014.13408.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Aug 10 00:42:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRx9A-00066e-0E
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 00:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbYHIWlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 18:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbYHIWlt
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 18:41:49 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:37295 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbYHIWls (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 18:41:48 -0400
Received: from darc.dyndns.org ([84.154.99.38]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 10 Aug 2008 00:41:43 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KRx8A-0005i6-32; Sun, 10 Aug 2008 00:41:50 +0200
Content-Disposition: inline
In-Reply-To: <200808100014.13408.johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 09 Aug 2008 22:41:47.0144 (UTC) FILETIME=[1B024080:01C8FA71]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91790>

On Sun, Aug 10, 2008 at 12:14:13AM +0200, Johannes Sixt wrote:
> > Currently you don't see the whole message anyways if the box is too small
> > for the text. I find that quite annoying, especially since there are
> > neither keys nor a scrollbar to scroll horizontally.
> 
> In this case, I use the middle mouse button to pan around. And then I do
> see what I will get.

Ok, that's not bad. But nevertheless I think we should at least add a
scrollbar.

> The width of the box was chosen wisely: It takes a bit less than 80
> columns, to leave room for quoting in emails and to avoid wrapping of git
> log output.

Maybe I'm doing something wrong, but on my system (wish8.5) the box width
changes with the window size, and gui.commitmsgwidth appears to be ignored.
Even if I close and restart git gui, the old window size is kept.

Clemens
