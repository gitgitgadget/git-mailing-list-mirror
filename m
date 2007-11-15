From: Jens Axboe <jens.axboe@oracle.com>
Subject: auto gc
Date: Thu, 15 Nov 2007 09:10:27 +0100
Message-ID: <20071115081025.GC638@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 09:10:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsZoG-0007jp-8N
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 09:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbXKOIKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 03:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbXKOIKb
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 03:10:31 -0500
Received: from brick.kernel.dk ([87.55.233.238]:29889 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660AbXKOIKa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 03:10:30 -0500
Received: by kernel.dk (Postfix, from userid 500)
	id 796952571FE; Thu, 15 Nov 2007 09:10:27 +0100 (CET)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65081>

Hi,

I've noticed that recent git versions, in a supposedly helpful fashion,
run garbage collection automatically after a pull if it deems it
necessary:

[...]
Resolving 556 deltas...
 100% (556/556) done
Updating 9418d5d..99fee6d
Fast forward
Packing your repository for optimum performance. You may also
run "git gc" manually. See "git help gc" for more information.
Generating pack...
[...]

This is extremely annoying behaviour! If I'm on battery or just in a bit
of a hurry, I defeinitely don't want git second guessing me and deciding
that it's time to run git gc.

I'd suggest just printing a hint that running git gc would increase
performance, doing it automatically is definitely bad style (even more
so when then yet again changed git refs layout even breaks old scripts,
when git gc has run).

-- 
Jens Axboe
