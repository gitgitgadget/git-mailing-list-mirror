From: Nick Hengeveld <nickh@reactrix.com>
Subject: HTTP questions
Date: Thu, 1 Jun 2006 16:24:37 -0700
Message-ID: <20060601232437.GD12261@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 02 01:24:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlwWw-00030J-62
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 01:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWFAXYi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 19:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWFAXYi
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 19:24:38 -0400
Received: from 241.37.26.69.virtela.net ([69.26.37.241]:16222 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750917AbWFAXYi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 19:24:38 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k51NObJD012077
	for <git@vger.kernel.org>; Thu, 1 Jun 2006 16:24:37 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k51NObWr012075
	for git@vger.kernel.org; Thu, 1 Jun 2006 16:24:37 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21127>

While testing recent http-fetch changes with a current checkout of next,
I noticed a couple of things:

- "git push" seems to pass --thin by default to http-push, which
  subsequently barfs because that's not a valid http-push option.
  Should it be?  Should it be silently ignored?  Should git-push not
  default to --thin when pushing with HTTP transport?

- when I clone, http-fetch outputs a whole bunch of 
  "error: Could not read ..." messages - is that expected?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
