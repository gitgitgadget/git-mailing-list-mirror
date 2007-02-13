From: Yann Dirson <ydirson@altern.org>
Subject: Missing documentation for GIT_DIFF_OPTS and GIT_EXTERNAL_DIFF
Date: Tue, 13 Feb 2007 23:36:57 +0100
Message-ID: <20070213223657.GC4266@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 23:38:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH6I5-0005E9-I6
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 23:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbXBMWiW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 17:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbXBMWiW
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 17:38:22 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:43848 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbXBMWiW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 17:38:22 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 28FD35EC3
	for <git@vger.kernel.org>; Tue, 13 Feb 2007 23:38:20 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id ED123200F; Tue, 13 Feb 2007 23:36:57 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39594>

I noticed today, after unsuccessfully trying GIT_DIFF_OPTS=-U2, that
1) it did not work, 2) the doc in 1.4.4.4 tells about using
"GIT_DIFF_OPTS=-c", which does not work either and 3) there is
virtually no more doc about it in HEAD.

It would be useful to document which flags are recognized, and notably
that -u<n> has to be used instead of GNU diff's -U<n>.

At the same time, I noticed that GIT_EXTERNAL_DIFF is not described in
the diff docs either, although it is described in the main git.txt
page (which may not be the place where users would look for it - at
least, only my grep aiming to be accurate before composing this mail
finally found it).

Best regards,
-- 
Yann.
