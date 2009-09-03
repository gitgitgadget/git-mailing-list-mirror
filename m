From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH (RESEND) 3/3] Fix DirCache.findEntry to work on an empty cache
Date: Fri, 4 Sep 2009 01:14:12 +0200
Message-ID: <200909040114.12980.robin.rosenberg@dewire.com>
References: <1251847010-9992-1-git-send-email-spearce@spearce.org> <1251847010-9992-2-git-send-email-spearce@spearce.org> <1251847010-9992-3-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <sop@google.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 01:14:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjLVW-0000ie-Iz
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 01:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbZICXOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2009 19:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbZICXON
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Sep 2009 19:14:13 -0400
Received: from mail.dewire.com ([83.140.172.130]:5197 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092AbZICXON (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2009 19:14:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id ABF078026F6;
	Fri,  4 Sep 2009 01:14:14 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tVITSuxWztDF; Fri,  4 Sep 2009 01:14:14 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 0E2DE80025E;
	Fri,  4 Sep 2009 01:14:13 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1251847010-9992-3-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127669>

onsdag 02 september 2009 01:16:50 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> If the cache has no entries, we want to return -1 rather than throw
> ArrayIndexOutOfBoundsException.  This binary search loop was stolen
> from some other code which contained a test before the loop to see if
> the collection was empty or not, but we failed to include that here.
> 
> Flipping the loop around to a standard while loop ensures we test
> the condition properly first.
> 
> Signed-off-by: Shawn O. Pearce <sop@google.com>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

Is this a new policy?

-- robin
