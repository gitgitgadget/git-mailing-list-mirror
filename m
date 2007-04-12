From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Thu, 12 Apr 2007 17:12:08 +0200
Message-ID: <200704121712.08706.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704110753360.6730@woody.linux-foundation.org> <20070411235447.GO21701@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 17:12:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc0y9-0005ix-5c
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 17:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbXDLPMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 11:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992553AbXDLPMN
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 11:12:13 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:64762 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750961AbXDLPMM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2007 11:12:12 -0400
Received: from dhcp-3s-55.lrr.in.tum.de (dhcp-3s-55.lrr.in.tum.de [131.159.35.55])
	by mail.in.tum.de (Postfix) with ESMTP id 8A0D127A7;
	Thu, 12 Apr 2007 17:12:10 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070411235447.GO21701@admingilde.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44341>

On Thursday 12 April 2007, you wrote:
> If you use a detached HEAD then you can no longer switch back to it
> once you used some other (independent) branch (for testing or whatever).
> This is my main argument: If you just update some 'special'
> refs/heads/from-supermodule (or whatever, maybe get it from
> .gitmodules/config) you can still switch between branches, making them
> more useful IMHO.

The supermodule checkout could create a .git/SUPER_HEAD for this.
OK, that is a special kind of reference.

Or introduce "git --super ..." with works with the superproject.
Form a submodule directory, a "git --super checkout ." could reset the
submodule checkout. 

Josef
