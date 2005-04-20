From: Tom Lord <lord@emf.net>
Subject: Re: on when to checksum
Date: Wed, 20 Apr 2005 15:52:33 -0700 (PDT)
Message-ID: <200504202252.PAA16837@emf.net>
References: <Pine.LNX.4.58.0504201539180.6467@ppc970.osdl.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 00:48:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DONzY-0002l7-6X
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 00:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVDTWwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 18:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVDTWwk
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 18:52:40 -0400
Received: from emf.emf.net ([205.149.0.19]:51214 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S261827AbVDTWwf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 18:52:35 -0400
Received: (from lord@localhost) by emf.net (K/K) id PAA16837; Wed, 20 Apr 2005 15:52:33 -0700 (PDT)
To: torvalds@osdl.org
In-reply-to: <Pine.LNX.4.58.0504201539180.6467@ppc970.osdl.org> (message from Linus Torvalds on Wed, 20 Apr 2005 15:41:47 -0700 (PDT))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


   From: Linus Torvalds <torvalds@osdl.org>

   On Wed, 20 Apr 2005, Tom Lord wrote:
   > 
   > I think you have made a mistake by moving the sha1 checksum from the
   > zipped form to the inflated form.  Here is why:

   I'd have agreed with you (and I did, violently) if it wasn't for the
   performance issues. It makes a huge difference for write-tree, and to me,
   clearly performance _does_ matter.

   Fractions of seconds may not sound like a lot, but they add up. I work 
   with 200-patch series myself all the time, so I'm very sensitive to a 0.3 
   second difference in performance.


How many times per day do you invoke `write-tree' and why?

It takes a large multiple of `0.3s' to get me to take you seriously
on this point.

I have long harbored the suspician that your perceived bandwidth
implies that you process a lot of patches unread or barely read --
implying that your day-to-day bitslingling could/should largely be
handled by an Arch-style patch-queue-manager (a script).

-t
