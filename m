From: Bruce Momjian <bruce@momjian.us>
Subject: test -L usage
Date: Tue, 21 Sep 2010 20:11:15 -0400 (EDT)
Message-ID: <201009220011.o8M0BFO26150@momjian.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 02:18:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyD2N-0006VR-Hb
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 02:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab0IVASJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 20:18:09 -0400
Received: from momjian.us ([70.90.9.53]:57389 "EHLO momjian.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227Ab0IVASJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 20:18:09 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2010 20:18:08 EDT
Received: (from bruce@localhost)
	by momjian.us (8.11.6/8.11.6) id o8M0BFO26150
	for git@vger.kernel.org; Tue, 21 Sep 2010 20:11:15 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL124 (25)]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156773>

git-1.7.3/contrib/workdir/git-new-workdir uses 'test -L' to test for
symlinks.  I suggest using 'test -h' because it is more portable, and
would have avoided a problem on my BSD machine.

-- 
  Bruce Momjian  <bruce@momjian.us>        http://momjian.us
  EnterpriseDB                             http://enterprisedb.com

  + It's impossible for everything to be true. +
