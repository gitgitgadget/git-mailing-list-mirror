From: Michael Hendricks <michael@ndrix.org>
Subject: Re: Lock binairy files in Git
Date: Wed, 4 Mar 2009 08:41:40 -0700
Message-ID: <20090304154140.GA44969@ginosko.grantstreet.com>
References: <1236175008046-2422894.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Henk <henk_westhuis@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 16:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LetFn-0001y5-Qp
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 16:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbZCDPl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 10:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbZCDPl5
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 10:41:57 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42008 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751668AbZCDPl4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 10:41:56 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 0872B2D9E44;
	Wed,  4 Mar 2009 10:41:52 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 04 Mar 2009 10:41:52 -0500
X-Sasl-enc: p4UTTywbP6+YzYu294CQ0dhwi/FAFWOtwuw7LRRWuzpL 1236181311
Received: from ginosko.ndrix.org (unknown [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9A9B636266;
	Wed,  4 Mar 2009 10:41:51 -0500 (EST)
Received: by ginosko.ndrix.org (Postfix, from userid 501)
	id B0A90A85C65; Wed,  4 Mar 2009 08:41:40 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <1236175008046-2422894.post@n2.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112224>

On Wed, Mar 04, 2009 at 05:56:48AM -0800, Henk wrote:
> In our current version control system we lock binairy files when we
> edit them. This way other developers know when a file is being
> edited. Is there something simular in Git? Or is there another
> method to let others now I am currently editing a file?
> 
> We need this only for binairy files, because they cannot be merged. 

You can't lock files, but perhaps you could specify a custom merge
driver to define how those files should be "merged" (for whatever
definition you choose).  See

    http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html

for details.

-- 
Michael
