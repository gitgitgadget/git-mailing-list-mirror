From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [3/5] Add http-pull
Date: Thu, 21 Apr 2005 00:28:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504210007410.30848-100000@iabervon.org>
References: <Pine.LNX.4.44.0504202026180.2625-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 06:23:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOTE9-00076J-6A
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 06:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVDUE2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 00:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVDUE2E
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 00:28:04 -0400
Received: from iabervon.org ([66.92.72.58]:4868 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261211AbVDUE2C (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 00:28:02 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DOTIJ-00054n-00; Thu, 21 Apr 2005 00:28:03 -0400
To: Brad Roberts <braddr@puremagic.com>
In-Reply-To: <Pine.LNX.4.44.0504202026180.2625-100000@bellevue.puremagic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Apr 2005, Brad Roberts wrote:

> How about fetching in the inverse order.  Ie, deepest parents up towards
> current.  With that method the repository is always self consistent, even
> if not yet current.

You don't know the deepest parents to fetch until you've read everything
more recent, since the history you'd have to walk is the history you're
downloading.

	-Daniel
*This .sig left intentionally blank*

