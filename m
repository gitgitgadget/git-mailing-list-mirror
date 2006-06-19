From: Eric Wong <normalperson@yhbt.net>
Subject: git-svn: don't use the --rmdir feature with SVN libs
Date: Mon, 19 Jun 2006 16:34:25 -0700
Message-ID: <20060619233424.GD3929@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jun 20 01:34:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsTGK-000404-Fv
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 01:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWFSXe3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 19:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWFSXe3
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 19:34:29 -0400
Received: from hand.yhbt.net ([66.150.188.102]:14734 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964987AbWFSXe2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 19:34:28 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id BE6DC7DC022;
	Mon, 19 Jun 2006 16:34:24 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon, 19 Jun 2006 16:34:25 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22144>

It's very broken when committing.  It's off by default, and somehow my
tests didn't catch it.  I'll fix it ASAP tonight.

Sorry if anybody else hit it before I did.

-- 
Eric Wong
