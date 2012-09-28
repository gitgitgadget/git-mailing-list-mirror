From: esr@thyrsus.com (Eric S. Raymond)
Subject: The ciabot hook code in contrib/ is obsolete - delete it
Date: Thu, 27 Sep 2012 22:40:45 -0400 (EDT)
Message-ID: <20120928024045.E0D6F42F19@snark.thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 04:49:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THQeD-00066p-MV
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 04:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546Ab2I1Ctk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 22:49:40 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:55216
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386Ab2I1Ctj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 22:49:39 -0400
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2012 22:49:39 EDT
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id E0D6F42F19; Thu, 27 Sep 2012 22:40:45 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206536>

The CIA notification server died about two days ago, done in by
a screwup at the cloud service hosting is VM.  For various technical
reasons there cannot and will not be any effort to revive it.  If you want
the whole sordid tale, read "CIA and the perils of overengineering" at
<http://esr.ibiblio.org/?p=4540>.

Accordingly, the contrib/ciabot code is now obsolete and should be removed.

I have written a replacement service. irker, with a different (and
fundamentally simpler) design. Though I released irker just today, it
already has multiple deployments.  A lot of hackers like their IRC
commit notifications and have instantly seized on this option to get
such a service running again - this time as a distributed flock of
lightweight notifier proxy daemons that cannot be taken out by any
single-point failure. 

Interested persons may wish to monitor the freenode #cia channel,
which is morphing into a discussion about coordinating irker
deployment and building various proxy/symbiote/statistics-gathering 
services around it.

I'm shipping a generic repo-hook script that supports both git and
Subversion in the irker distribution, so there won't be any need
for git to carry a special hook.  I remain grateful for your previous 
cooperation in supporting and distributing the ciabot code. 
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

You need only reflect that one of the best ways to get yourself a
reputation as a dangerous citizen these days is to go about repeating
the very phrases which our founding fathers used in the great struggle
for independence.	-- Attributed to Charles Austin Beard (1874-1948)
