From: Bruce Momjian <bruce@momjian.us>
Subject: "git show" does not use diff.external like "git diff" does
Date: Tue, 28 Dec 2010 10:10:22 -0500 (EST)
Message-ID: <201012281510.oBSFAMm14943@momjian.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:31:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbVw-0004OY-4i
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab0L1Paq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:30:46 -0500
Received: from momjian.us ([70.90.9.53]:59500 "EHLO momjian.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706Ab0L1Pao (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:30:44 -0500
X-Greylist: delayed 1222 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Dec 2010 10:30:44 EST
Received: (from bruce@localhost)
	by momjian.us (8.11.6/8.11.6) id oBSFAMm14943
	for git@vger.kernel.org; Tue, 28 Dec 2010 10:10:22 -0500 (EST)
X-Mailer: ELM [version 2.4ME+ PL124 (25)]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164240>

I have diff.external configured properly, and it is used by "git diff",
but "git show" does not call the script and only returns unified diffs.

Is there a way to make "git show" use an external diff script?

-- 
  Bruce Momjian  <bruce@momjian.us>        http://momjian.us
  EnterpriseDB                             http://enterprisedb.com

  + It's impossible for everything to be true. +
