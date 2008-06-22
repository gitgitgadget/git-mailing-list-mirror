From: Graham Wilson <graham@mknod.org>
Subject: Re: "git-pull --no-commit" should imply --no-ff...?
Date: Sun, 22 Jun 2008 08:36:06 -0500
Message-ID: <20080622133606.GA21828@endor.mknod.org>
References: <tkrat.5aa5af8e9968819c@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
X-From: git-owner@vger.kernel.org Sun Jun 22 15:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAPte-0002iB-1F
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 15:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbYFVNor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 09:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbYFVNor
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 09:44:47 -0400
Received: from mknod.org ([209.223.236.42]:52673 "EHLO mknod.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbYFVNoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 09:44:46 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Jun 2008 09:44:46 EDT
Received: from endor.mknod.org (72-173-220-121.cust.wildblue.net [72.173.220.121])
	by mknod.org (Postfix) with ESMTPS id 97E9E6B00DE;
	Sun, 22 Jun 2008 08:36:18 -0500 (CDT)
Received: by endor.mknod.org (Postfix, from userid 1000)
	id 301191077D2; Sun, 22 Jun 2008 08:36:06 -0500 (CDT)
Mail-Followup-To: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <tkrat.5aa5af8e9968819c@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85769>

On Sat, Jun 21, 2008 at 04:08:51PM +0200, Stefan Richter wrote:
> trying "git pull --no-commit . foo" for the first time, I was confused
> that --no-commit was a no-op when the pull resulted in a fast-forward.
> I.e. HEAD advanced the whole chain of commits to foo.  I expected it to
> apply the diff of HEAD..foo but not commit them.

--no-commit to me seems to mean don't commit a merge commit. Maybe what
you want is something like:

 git-diff HEAD foo | git-apply

-- 
gram
