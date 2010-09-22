From: Bruce Momjian <bruce@momjian.us>
Subject: git's use of mkdir()
Date: Tue, 21 Sep 2010 20:14:02 -0400 (EDT)
Message-ID: <201009220014.o8M0E2326476@momjian.us>
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
	id 1OyD2O-0006VR-1w
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 02:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037Ab0IVASM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 20:18:12 -0400
Received: from momjian.us ([70.90.9.53]:57389 "EHLO momjian.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257Ab0IVASJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 20:18:09 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2010 20:18:08 EDT
Received: (from bruce@localhost)
	by momjian.us (8.11.6/8.11.6) id o8M0E2326476
	for git@vger.kernel.org; Tue, 21 Sep 2010 20:14:02 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL124 (25)]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156774>

git 1.7.3 uses mkdir as part of 'clone' with trailing slashes, e.g.
mkdir 'abc/'.  My older BSD machine does not accept that and only allows
mkdir 'abc'.

This patch, posted September 9, 2010, fixed my git problem:

	http://www.spinics.net/lists/git/msg140155.html

Hopefully this will be applied in a future git release.  Thanks.

-- 
  Bruce Momjian  <bruce@momjian.us>        http://momjian.us
  EnterpriseDB                             http://enterprisedb.com

  + It's impossible for everything to be true. +
