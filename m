From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix use of wc in t0000-basic
Date: Fri, 20 May 2005 21:16:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505202113500.30848-100000@iabervon.org>
References: <4616.10.10.10.24.1116637985.squirrel@linux1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 03:16:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZIb7-0004Lu-DL
	for gcvg-git@gmane.org; Sat, 21 May 2005 03:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVEUBRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 21:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVEUBRF
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 21:17:05 -0400
Received: from iabervon.org ([66.92.72.58]:51204 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261560AbVEUBQ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 21:16:59 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DZIbG-00002S-00; Fri, 20 May 2005 21:16:22 -0400
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <4616.10.10.10.24.1116637985.squirrel@linux1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 20 May 2005, Sean wrote:

> Yes, i was.   But presumably someone was stripping the whitespace from wc
> for a reason?   Either way the sed-only solution seems a little cleaner.

Junio was stripping the filename (not whitespace) from wc, not knowing
that it could be suppressed by using stdin. This didn't work with versions
of wc that put whitespace at the beginning. I think the sed-only solution
is far more obscure and no cleaner than cat and wc.

	-Daniel
*This .sig left intentionally blank*

