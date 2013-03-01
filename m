From: David Madore <david+news@madore.org>
Subject: suggestion for a simple addition: git update-ref --ff-only
Date: Sat, 2 Mar 2013 00:18:59 +0100
Message-ID: <20130301231859.GA334@achernar.madore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 02 00:28:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBZNR-0006Xa-H9
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 00:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab3CAX2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 18:28:06 -0500
Received: from achernar.gro-tsen.net ([88.191.144.68]:35877 "EHLO
	achernar.gro-tsen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab3CAX2D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 18:28:03 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Mar 2013 18:28:03 EST
Received: by achernar.gro-tsen.net (Postfix, from userid 500)
	id 5DA072407AF; Sat,  2 Mar 2013 00:18:59 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217306>

Hi list,

I'd like to suggest a very simple, but IMHO quite useful, additional
option to git-update-ref: an option --ff-only which would cause the
command to refuse unless the current ref is an ancestor of the new
one.

The reason I think it would be useful: I occasionally wish to perform
a trivial (i.e., fast-forward) merge of some branch into another
(e.g., after a git-fetch) without checking it out.  Now git-update-ref
is perfect for that, but there is always the possibility of getting
something wrong (which one would not have with git merge --ff-only,
but the latter requires checking out the branch), and this option
would avoid tedious verifications.

Happy hacking,

-- 
     David A. Madore
   ( http://www.madore.org/~david/ )
