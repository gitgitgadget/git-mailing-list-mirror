From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] cvsserver: Fix handling of diappeared files on update
Date: Wed, 11 Apr 2007 23:42:31 +0200
Message-ID: <20070411214231.GB7085@planck.djpig.de>
References: <Pine.LNX.4.64.0704111158220.27922@iabervon.org> <11763238991005-git-send-email-frank@lichtenheld.de> <7v1wiqoaph.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:42:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbkaR-0007Yw-EY
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 23:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161235AbXDKVmk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 17:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbXDKVmk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 17:42:40 -0400
Received: from planck.djpig.de ([85.10.192.180]:2241 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161235AbXDKVmj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 17:42:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 1BE6B88003;
	Wed, 11 Apr 2007 23:42:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UsJsWZp2Qd8e; Wed, 11 Apr 2007 23:42:32 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id EEB018801B; Wed, 11 Apr 2007 23:42:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1wiqoaph.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44261>

On Wed, Apr 11, 2007 at 02:36:10PM -0700, Junio C Hamano wrote:
> This would make the modified response go away, but would it
> cause a fresh re-checkout to happen?

Yeah, the rest of the code handles this case correctly if
it actually gets the chance to do so.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
