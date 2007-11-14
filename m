From: Bruce Stephens <bruce.stephens@isode.com>
Subject: refining .gitignores
Date: Wed, 14 Nov 2007 22:36:06 +0000
Message-ID: <804pfobgkp.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 23:42:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsQwH-0004o3-Dt
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 23:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbXKNWmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 17:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754799AbXKNWmM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 17:42:12 -0500
Received: from rufus.isode.com ([62.3.217.251]:60491 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754102AbXKNWmL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 17:42:11 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Nov 2007 17:42:11 EST
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <Rzt4VgBBVF9l@rufus.isode.com> for <git@vger.kernel.org>;
          Wed, 14 Nov 2007 22:36:06 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Wed, 14 Nov 2007 22:36:06 +0000
X-Hashcash: 1:20:071114:git@vger.kernel.org::1LVS8ssrHUynmpFQ:0000000000000000000000000000000000000000001VvA
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65021>

How do I get a list of files (in HEAD, say) that would be ignored by
the .gitignore files (and the other usual settings)?

It feels like something like this ought to work:

     git ls-files -z | xargs -0 git ls-files --ignored

But listing its arguments that are ignored by .gitignore (etc.)
doesn't seem to be what "git ls-files --ignored" does.  Or at least,
not quite as straightforwardly as that.

The motivation is (obviously) that I fear some of the .gitignore
patterns are too broad, and a reasonable check is that none of the
files that are already committed would be caught by the patterns.
