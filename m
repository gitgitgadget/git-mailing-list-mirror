From: Alex Bennee <kernel-hacker@bennee.com>
Subject: git-pull and tag objects
Date: Thu, 08 Feb 2007 11:16:46 +0000
Message-ID: <1170933407.15431.38.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 13:06:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF833-0004eV-Mx
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 13:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422944AbXBHMGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 07:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422951AbXBHMGl
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 07:06:41 -0500
Received: from mx.transitive.com ([217.207.128.220]:38059 "EHLO
	pennyblack.transitives.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1422944AbXBHMGk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Feb 2007 07:06:40 -0500
X-Greylist: delayed 2990 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Feb 2007 07:06:40 EST
Received: from [192.168.1.82] (helo=[192.168.1.82])
	by pennyblack.transitives.com with esmtp (Exim 4.50)
	id 1HF7G6-0000up-PG
	for git@vger.kernel.org; Thu, 08 Feb 2007 11:16:11 +0000
X-Mailer: Evolution 2.8.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39055>

Hi,

I have a master repositary which I keep in sync with a CVS server. Each
time it imports a new baseline it tags it with the baseline tag we use.
This allows for easy branching of "baseline" levels.

I have slave repositaries which are cloned of the baseline which I do my
development in. However when I bring the master branch of these work
repositaries upto date (via git-pull ../baseline master) I find the tag
objects are lost. Should they not be part of the tree? After all when I
sync to Linus's kernel repo I get all his version tags as part of that.

-- 
Alex, homepage: http://www.bennee.com/~alex/
"Spare no expense to save money on this one." -- Samuel Goldwyn
