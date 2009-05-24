From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] Revert "git gui: show diffs with a minimum of 1 context line"
Date: Sun, 24 May 2009 12:01:03 +0200
Message-ID: <200905241201.04297.markus.heidelberg@web.de>
References: <1243099727-5272-1-git-send-email-markus.heidelberg@web.de> <20090523231605.GA4522@localhost>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun May 24 12:05:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8AZq-0007Hc-4D
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 12:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbZEXKBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 06:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbZEXKBE
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 06:01:04 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:51593 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbZEXKBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 06:01:03 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 68278100E2819;
	Sun, 24 May 2009 12:01:01 +0200 (CEST)
Received: from [89.59.101.94] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M8AVp-0003Xz-00; Sun, 24 May 2009 12:01:01 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090523231605.GA4522@localhost>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+IovFqAgjpMvqNw8hQT8Q6bmFT88+uOGVxZM2O
	u6xhp1ucOIfzIadbifZcyM2+8iWQOFZytgSoKrJbP5rxNVY7CK
	nuXY6LqzpTlWudUx3dUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119817>

Clemens Buchacher, 24.05.2009:
> On Sat, May 23, 2009 at 07:28:47PM +0200, Markus Heidelberg wrote:
> > Diffs without context can actually be useful. Depending on the changes
> > it can be less distracting to read them or to get an overview.
> 
> Maybe so. But as stated in the commit message of 55ba8a3 (git gui: show
> diffs with a minimum of 1 context line) context-less diff was disabled
> because it caused bugs with staging.

It wasn't clear to me that there were bugs. I thought it just "does not
work" in some way, but should have tried it at least. Now I see.

> However, I never got around to fix the
> real cause of the problem. See the original thread at
> 
> http://article.gmane.org/gmane.comp.version-control.git/94387

Thanks for the link. After reading this discussion I also see that
disabling staging with zero context is not a user-friendly solution.

Markus
