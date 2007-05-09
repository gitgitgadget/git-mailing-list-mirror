From: David Miller <davem@davemloft.net>
Subject: quick bare clones taking longer?
Date: Wed, 09 May 2007 02:09:16 -0700 (PDT)
Message-ID: <20070509.020916.80034730.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 11:09:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HliAm-0000pE-Cw
	for gcvg-git@gmane.org; Wed, 09 May 2007 11:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbXEIJJR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 05:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754347AbXEIJJR
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 05:09:17 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60291
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753564AbXEIJJQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2007 05:09:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 0CE7D290133
	for <git@vger.kernel.org>; Wed,  9 May 2007 02:09:17 -0700 (PDT)
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46687>


master.kernel.org just upgraded to git-1.5.1.4 and I notice
that doing something like this:

	git clone --bare -n -l -s ../torvalds/linux-2.6.git test-2.6.git

is no longer an instantaneous operation, it seems to be doing a lot
of stuff now:

Initialized empty Git repository in /home/davem/git/test-2.6.git/
remote: Generating pack...
remote: Done counting 480025 objects.
remote: Deltifying 480025 objects.
remote:  100% (480025/480025) done
Indexing 480025 objects.
remote: Total 480025 (delta 385878), reused 473265 (delta 379369)
 100% (480025/480025) done
Resolving 385878 deltas.
 100% (385878/385878) done

Is there a new way to get a quick clone?

Thanks!
