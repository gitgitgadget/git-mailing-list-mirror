From: Joshua N Pritikin <jpritikin@pobox.com>
Subject: problem with import-tars?
Date: Mon, 21 May 2007 14:18:46 +0530
Message-ID: <20070521084846.GN11652@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 11:23:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq474-0002SS-NJ
	for gcvg-git@gmane.org; Mon, 21 May 2007 11:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866AbXEUJXb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 05:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756269AbXEUJXb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 05:23:31 -0400
Received: from lollipop.listbox.com ([208.210.124.78]:46632 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756866AbXEUJXa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 05:23:30 -0400
X-Greylist: delayed 1522 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 May 2007 05:23:30 EDT
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by lollipop.listbox.com (Postfix) with ESMTP id E0B37433BD2
	for <git@vger.kernel.org>; Mon, 21 May 2007 04:50:14 -0400 (EDT)
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C8C842F2
	for <git@vger.kernel.org>; Mon, 21 May 2007 04:49:11 -0400 (EDT)
Received: from emit.nirmalvihar.info (unknown [59.95.12.140])
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E64974F5B5
	for <git@vger.kernel.org>; Mon, 21 May 2007 04:49:10 -0400 (EDT)
Received: by emit.nirmalvihar.info (sSMTP sendmail emulation); Mon, 21 May 2007 14:18:46 +0530
Content-Disposition: inline
X-PGP-Key: 06E3 3D22 D307 AAE6 ACB4  6B44 A9CA A794 A4A6 0BBD
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48000>

I ran the import-tars which comes with 1:1.5.1.1-1 (Debian). I checked 
out the import-tars branch but now I can't commit:

joshua@emit:~/ev$ git commit
error: unable to read tree object HEAD
# On branch import-tars
error: unable to read tree object HEAD
[...snip...]

joshua@emit:~/ev$ git fsck-objects --full
warning in tree 05c3fd86565c57f128495d420565f813ba4b2535: contains empty 
pathname
warning in tree 16f235c9367ca15e3a3a6709547e235f701a1ee5: contains empty 
pathname
warning in tree 30f1e3c3926c52094bf6bb182906feed0cad2da1: contains empty 
pathname
warning in tree 528e0a55edc527f8f8a14d33057a6003ec87071d: contains empty 
pathname
warning in tree 5818056708134bbd4217195b32c65feed0527547: contains empty 
pathname
warning in tree 75382de0c9f403cb2c72e56b255a617c43bcd679: contains empty 
pathname
warning in tree a66bbc0c86757d18f187079d1f25bbaea19fc29c: contains empty 
pathname
warning in tree aa17744c47e7b8898e956b8d8e246f8b0b9860d8: contains empty 
pathname
warning in tree b120f845d24d7736aab58f04745c03a54366d68f: contains empty 
pathname
warning in tree eb650564f413d4a3fb67ca5f0c4e8dac08262f52: contains empty 
pathname

How do I proceed? I upgraded to 1:1.5.1.4-2 but the problem persists.

-- 
Make April 15 just another day, visit http://fairtax.org
