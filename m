From: Michael Hendricks <michael@ndrix.org>
Subject: git-svn: importing branches later
Date: Mon, 7 May 2007 13:07:06 -0600
Message-ID: <20070507190702.GE342@ginosko.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 21:07:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl8YQ-0004Hi-TQ
	for gcvg-git@gmane.org; Mon, 07 May 2007 21:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966234AbXEGTHL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 15:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966239AbXEGTHL
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 15:07:11 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37560 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966234AbXEGTHK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2007 15:07:10 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id BE64021E02D
	for <git@vger.kernel.org>; Mon,  7 May 2007 15:08:10 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 07 May 2007 15:07:09 -0400
X-Sasl-enc: kNVsJMABCM+D7vxOvdJCZRJrxUDUuYVOKnm7PNzRbp46 1178564828
Received: from localhost (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id D73E81B012
	for <git@vger.kernel.org>; Mon,  7 May 2007 15:07:08 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46476>

I've cloned the trunk of a SVN repository using git-svn and now I want
to bring in just a couple of the branches from the same repository.
I've not been able to discover anything that works.  Basically, I've
done this

$ git svn clone $URL -T trunk git-repo

Now I want to import the 'foo' branch from the same SVN repo without
grabbing all the branches.  Any suggestions?

Thanks.

-- 
Michael
