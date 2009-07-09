From: Larry D'Anna <larry@elder-gods.org>
Subject: determine if one commit is an ancestor of another
Date: Thu, 9 Jul 2009 13:13:51 -0400
Message-ID: <20090709171351.GA30088@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 09 19:15:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOxC4-0001SG-1W
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 19:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbZGIRNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 13:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbZGIRNw
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 13:13:52 -0400
Received: from cthulhu.elder-gods.org ([140.239.99.253]:35396 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbZGIRNv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 13:13:51 -0400
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 33CA9822106; Thu,  9 Jul 2009 13:13:51 -0400 (EDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122993>

Is there any builtin to do this?  I'm doing it in a perl script now by parsing
git log --pretty=raw, but it's pretty slow for a big repository.

    --larry
