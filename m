From: Yann Dirson <ydirson@altern.org>
Subject: git-fetch doc seems wrong
Date: Sat, 3 Feb 2007 11:36:37 +0100
Message-ID: <20070203103637.GJ5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 11:37:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDIH5-0005DV-4Q
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 11:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946431AbXBCKhc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 05:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946432AbXBCKhc
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 05:37:32 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:47070 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946431AbXBCKhc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 05:37:32 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 0EEE0548F
	for <git@vger.kernel.org>; Sat,  3 Feb 2007 11:37:31 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 558651F080; Sat,  3 Feb 2007 11:36:37 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38561>

git-fetch.txt says the following, whereas the only command that
appears to use FETCH_HEAD in Git HEAD is git-pull.

| The ref names and their object names of fetched refs are stored
| in `.git/FETCH_HEAD`.  This information is left for a later merge
| operation done by "git merge".

Maybe the latter sentence could be reworded as something like this ?

| This information is left for a later merge operation, for use by "git
| pull" or other porcelain tools.

Best regards,
-- 
Yann.
