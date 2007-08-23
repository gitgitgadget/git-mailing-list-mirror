From: bdowning@lavos.net (Brian Downing)
Subject: Re: [BUG] git-gui: "Stage Hunk For Commit" doesn't work at all anymore
Date: Thu, 23 Aug 2007 15:38:18 -0500
Message-ID: <20070823203818.GG21692@lavos.net>
References: <20070823203024.GF21692@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 22:38:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOJRo-0004ks-G7
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 22:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758743AbXHWUi3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 16:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757719AbXHWUi3
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 16:38:29 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:32727 "EHLO
	asav02.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757211AbXHWUi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 16:38:28 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAH+NzUZKhvbz/2dsb2JhbAA
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav02.insightbb.com with ESMTP; 23 Aug 2007 16:38:28 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 54D9C309F21; Thu, 23 Aug 2007 15:38:18 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070823203024.GF21692@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56528>

On Thu, Aug 23, 2007 at 03:30:24PM -0500, Brian Downing wrote:
> This commit:
> 
> commit a13ee29b975d3a9a012983309e842d942b2bbd44
> 
> seems to have broken the "Stage Hunk For Commit" option entirely for me
> -- it is now disabled whether or not there is a patch in the viewer.

Sorry, I just saw the following commit in the git-gui tree:

ce015c213fbef39140b6192db28110bc666dc6c8 
git-gui: Paper bag fix "Stage Hunk For Commit" in diff context menu

So it appears this issue is known.  Sorry about the noise.

(Though this will be merged before 1.5.3, right?)

-bcd
