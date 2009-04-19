From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: checkout @{-1} bug/oddity
Date: Sun, 19 Apr 2009 17:37:40 +0200
Message-ID: <20090419153740.GA12431@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 19 17:50:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvZHM-0001Uk-FJ
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 17:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760797AbZDSPrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 11:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760731AbZDSPrt
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 11:47:49 -0400
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4124
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757020AbZDSPrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 11:47:48 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Apr 2009 11:47:47 EDT
Received: from justin (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTPS id 4FBBC801C07D
	for <git@vger.kernel.org>; Sun, 19 Apr 2009 17:38:05 +0200 (CEST)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LvZ5Q-0003GU-Tu
	  for git@vger.kernel.org; Sun, 19 Apr 2009 17:37:40 +0200
Content-Disposition: inline
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116905>

In case this is worth fixing:

  | % g co -b foo
  | Switched to a new branch 'foo'
  | 
  | % g co -
  | Switched to branch 'master'
  | 
  | % g co -b bar
  | Switched to a new branch 'bar'
  | 
  | % g co bar
  | Already on 'bar'
  | 
  | % g co -
  | Already on 'bar'

In my opinion the last command should switch to master, as in, switching
to the current branch should not lose the @{-1} history.

Thanks,

-- 
- Are you sure we're good?
- Always.
        -- Rory and Lorelai
