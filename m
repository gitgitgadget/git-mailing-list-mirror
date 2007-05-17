From: Michael Hendricks <michael@ndrix.org>
Subject: Re: [PATCH] Document core.excludesfile for git-add
Date: Thu, 17 May 2007 08:35:44 -0600
Message-ID: <20070517143542.GB15709@ginosko.local>
References: <1179378530822-git-send-email-michael@ndrix.org> <7vwsz89ftr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 16:35:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hoh5B-0005ER-BH
	for gcvg-git@gmane.org; Thu, 17 May 2007 16:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbXEQOft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 10:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbXEQOft
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 10:35:49 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53388 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753886AbXEQOfs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2007 10:35:48 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 5223421F8BC;
	Thu, 17 May 2007 10:37:18 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 17 May 2007 10:35:47 -0400
X-Sasl-enc: ZUs9xb/o/tmT8OG1JCNULZLCgLXN/Iaq8YnUkO5W+eMl 1179412547
Received: from localhost (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id D3DCA1A10F;
	Thu, 17 May 2007 10:35:47 -0400 (EDT)
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vwsz89ftr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47526>

On Wed, May 16, 2007 at 10:31:12PM -0700, Junio C Hamano wrote:
> Thanks, but wouldn't this belong to Documentation/config.txt
> instead, I wonder?

It appears to my untrained eye that core.excludesfiles only works for
git-add.  It seems to have no effect on git-status and the only code
that mentions core.excludesfile is builtin-add.c

-- 
Michael
