From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 08/10] user-manual: add a "counting commits" example
Date: Mon, 14 May 2007 17:51:11 +0200
Message-ID: <20070514155111.GE5272@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon May 14 17:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HncpU-0005Jf-Ao
	for gcvg-git@gmane.org; Mon, 14 May 2007 17:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbXENPvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 11:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbXENPvP
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:51:15 -0400
Received: from planck.djpig.de ([85.10.192.180]:3444 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403AbXENPvO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:51:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 6C68B274014;
	Mon, 14 May 2007 17:51:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rBKX+vXFxB9j; Mon, 14 May 2007 17:51:12 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 423C0274013; Mon, 14 May 2007 17:51:12 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47262>

On Mon, May 14, 2007 at 11:21:27AM -0400, J. Bruce Fields wrote:
> +Suppose you want to know how many commits you've made on "mybranch"
> +since it diverged from "origin":
> +
> +-------------------------------------------------
> +$ git log --pretty=oneline origin..maint | wc -l
> +-------------------------------------------------

Shouldn't that be mybranch instead of maint?

> +Alternatively you may often see this sort of thing done with the
> +lower-level command gitlink:git-rev-list[1], which just lists the SHA1's
> +of all the given commits:
> +
> +-------------------------------------------------
> +$ git rev-list origin..maint | wc -l
> +-------------------------------------------------

Same here.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
