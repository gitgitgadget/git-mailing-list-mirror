From: Yann Dirson <ydirson@altern.org>
Subject: Re: stg pull doesn't pull anymore
Date: Sat, 3 Feb 2007 11:16:22 +0100
Message-ID: <20070203101622.GI5362@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1170471647.9733.24.camel@dv> <1170474278.26823.11.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 11:17:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDHxu-0004Qi-4I
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 11:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbXBCKRS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 05:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbXBCKRS
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 05:17:18 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:54025 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbXBCKRR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 05:17:17 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 82B589B72A;
	Sat,  3 Feb 2007 11:17:16 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id D70101F080; Sat,  3 Feb 2007 11:16:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1170474278.26823.11.camel@dv>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38560>

On Fri, Feb 02, 2007 at 10:44:38PM -0500, Pavel Roskin wrote:
> Now I'm quite confident that stgit.pull-does-rebase=yes is not working
> the way it should.

You're right.  I have mistakenly assumed the branch.*.merge parameter
points to the local ref.  I'll fix it so it takes that as a remote
ref.  Not quite sure how to behave when more than one Fetch: line
reference a single remote branch, though.

Best regards,
-- 
Yann.
