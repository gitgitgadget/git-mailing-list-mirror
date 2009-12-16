From: bd@bc-bd.org
Subject: How do I show only log messages for commits on a specific branch?
Date: Wed, 16 Dec 2009 10:16:47 +0000
Message-ID: <20091216101647.GB27373@bc-bd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 11:43:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKrLo-0004wu-Ua
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 11:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538AbZLPKnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2009 05:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbZLPKnT
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 05:43:19 -0500
Received: from mail.bc-bd.org ([88.217.195.190]:33237 "EHLO bc-bd.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbZLPKnS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2009 05:43:18 -0500
X-Greylist: delayed 1710 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Dec 2009 05:43:18 EST
Received: from bd by bc-bd.org with local (Exim 4.69)
	(envelope-from <bd@bc-bd.org>)
	id 1NKqw3-0007Bx-Sk
	for git@vger.kernel.org; Wed, 16 Dec 2009 10:16:47 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: bd@bc-bd.org
X-SA-Exim-Scanned: No (on bc-bd.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135327>

Hello list,

[ git v1.6.3.3 ]

imagine this:

	     --A--*--B (new)
	    /
	*--X--*--Y (master)

Now I'd like to list only log messages for A..B (X..B would be okay too).

I know of 

	git log master..new

however then I need to remember that I branched new of master, and to be honest,
sometimes I forget.

So how do I:

	git please-tell-me-the-branch-I-started-this-branch-from new

Thanks in advance,

	Stefan

-- 
BOFH excuse #181:

Atilla the Hub
