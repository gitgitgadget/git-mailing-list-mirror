From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: git-svn dcommit failure
Date: Thu, 07 Jun 2007 16:04:44 +0200
Message-ID: <87abvb508z.fsf@mid.deneb.enyo.de>
References: <87veecat2k.fsf@mid.deneb.enyo.de>
	<87d50kas6p.fsf@mid.deneb.enyo.de>
	<20070529144742.GG1025@.intersec.eu>
	<87k5ur64hx.fsf@mid.deneb.enyo.de> <20070605101744.GA12948@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 16:04:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwIbg-0007nU-VD
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 16:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758002AbXFGOEv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 10:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758478AbXFGOEv
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 10:04:51 -0400
Received: from mail.enyo.de ([212.9.189.167]:1713 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754485AbXFGOEu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 10:04:50 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1HwIbX-0008E9-1z; Thu, 07 Jun 2007 16:04:47 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1HwIbU-0002NY-3L; Thu, 07 Jun 2007 16:04:44 +0200
In-Reply-To: <20070605101744.GA12948@muzzle> (Eric Wong's message of "Tue, 5
	Jun 2007 03:17:44 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49369>

* Eric Wong:

>> After manually committing the offending changes via Subversion, I
>> git-svn has begun to work again, too (but I haven't yet tried to
>> change the same files).
>
> Would upgrading to 1.5.2 final have helped?

I've upgraded to this version, but since it's not exactly trivial for
me to test this on the Subversion side, it'll take some time until I
can be confident that the bug was indeed fixed in the
6442754d6cc0056cf5b69b43d218f8b6d317e7f5 revision.

Is there some kind of magic environment variable I could set to get
tracing information?  If such bugs turn up, I'd try to debug them on
my own and submit a fix, or at least a reproduction recipe.  (The
repository itself may contain personally identifiable information in
test cases and hence, cannot be shared.)
