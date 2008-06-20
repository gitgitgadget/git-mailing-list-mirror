From: Fredrik Skolmli <fredrik@frsk.net>
Subject: git svn --add-author-from implies --use-log-author
Date: Fri, 20 Jun 2008 13:31:47 +0200
Message-ID: <20080620113147.GC27940@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 13:32:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9erK-0002GO-TC
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 13:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbYFTLbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 07:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbYFTLbu
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 07:31:50 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:41406 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbYFTLbu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 07:31:50 -0400
Received: from asterix.samfundet.no ([2001:700:300:1800::f] ident=postfix)
	by cassarossa.samfundet.no with esmtp (Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1K9eqK-0007k6-2R
	for git@vger.kernel.org; Fri, 20 Jun 2008 13:31:48 +0200
Received: by asterix.samfundet.no (Postfix, from userid 1000)
	id 05136A6039D; Fri, 20 Jun 2008 13:31:47 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85621>

Hi,

when running git svn dcommit --add-author-from on a git-svn repository,
--use-log-author is not implied by itself. This causes the rewritten history
to not show the author in the way most users would expect it to be, "Name
<email@domain.tld>", but instead "<user@uuid>".

Instead of forcing people to write "svn dcommit --add-author-from
--use-log-author", is it a bad move to imply the last argument, making the
history look more user-friendly to start with?

Any thoughts?

-- 
Regards,
Fredrik Skolmli
