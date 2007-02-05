From: Blu Corater <blu@daga.cl>
Subject: replacing a bad commit
Date: Mon, 5 Feb 2007 12:39:49 -0300
Message-ID: <20070205153949.GT14499@daga.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 05 17:21:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE6ac-00058A-ES
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 17:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbXBEQVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 11:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbXBEQVF
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 11:21:05 -0500
Received: from pc-25-158-44-190.cm.vtr.net ([190.44.158.25]:58097 "EHLO
	daga.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbXBEQVE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 11:21:04 -0500
X-Greylist: delayed 2472 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Feb 2007 11:21:04 EST
Received: from blu by daga.cl with local (Exim 4.63)
	(envelope-from <blu@daga.cl>)
	id 1HE5wb-000262-VR
	for git@vger.kernel.org; Mon, 05 Feb 2007 12:39:49 -0300
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38757>

Hello,

Here is the situation. Upstream realeses tarballs once in a while. I
maintain local modifications. Every time upstream releases a tarball, I
fast forward the 'upstream' branch, and merge into 'local' branch. My
tree, currently, looks somewhat like this:

               o---o---o <--topic2
               |
               |  o---o---o <--topic1
               | /
   o---o---C---A---o---o <--local
  /   /   /  
 /   /   /
o---o---o---B <--upstream

Problem is, B should have been merged into 'local', at A, but I just
realized it wasn't (probably due to my own stupidity).

I need to correct A, i.e. merge with B, but keeping the branches already
in flux, and propagating the changes due to the merge to them. In short,
replace A with a properly merged A'.

I tried branching from C and merging with B, then rebasing topic branches,
but then I am not sure how to rebase 'local'to eliminate A.

Thanks in advance for any help.

-- 
Blu.
