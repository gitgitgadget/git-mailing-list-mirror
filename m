From: linux@horizon.com
Subject: Re: A look at some alternative PACK file encodings
Date: 7 Sep 2006 15:16:22 -0400
Message-ID: <20060907191622.7597.qmail@science.horizon.com>
References: <Pine.LNX.4.64.0609071228560.18635@xanadu.home>
Cc: git@vger.kernel.org, gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 07 21:16:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLPMi-0003OG-Ml
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 21:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWIGTQY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 15:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWIGTQY
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 15:16:24 -0400
Received: from science.horizon.com ([192.35.100.1]:44861 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751440AbWIGTQX
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 15:16:23 -0400
Received: (qmail 7598 invoked by uid 1000); 7 Sep 2006 15:16:22 -0400
To: linux@horizon.com, nico@cam.org
In-Reply-To: <Pine.LNX.4.64.0609071228560.18635@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26650>

> So I don't think we would gain that much using that encoding 
> unless/until the pack format is made completely incompatible due to 
> other changes, and that's something we should try to avoid as much as 
> possible anyway.

Ah, I'm sorry; I didn't realize that it was already used elsewhere in
the pack format and this was just code re-use.  That is indeed a good
reason to stick with what's already there.

I agree the savings are minimal, but if you're starting from scratch,
they're free, so why not use them?  I tried to show that the code
complexity is truly negligible.

I'm sorry I didn't realize the details of pack structure before.
