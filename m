From: Teemu Likonen <tlikonen@iki.fi>
Subject: Segmentation fault on http clone, post-1.5.6
Date: Tue, 24 Jun 2008 16:04:57 +0300
Message-ID: <20080624130457.GB13696@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 15:07:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB8EP-0003kU-5k
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 15:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756706AbYFXNFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 09:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756683AbYFXNFA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 09:05:00 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:55915 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756609AbYFXNE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 09:04:59 -0400
Received: from mithlond.arda.local (80.220.180.140) by jenni2.rokki.sonera.fi (8.5.014)
        id 483E832F0133086D for git@vger.kernel.org; Tue, 24 Jun 2008 16:04:57 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KB8Cf-0005Tu-95
	for git@vger.kernel.org; Tue, 24 Jun 2008 16:04:57 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86051>

With the current "master" branch version (29b0d0191) I get segmentation
fault when trying to clone a git repo with http protocol. Tried a couple
of times and it's always reproducible. You can test with the following
repository (about 5.5 MB):

  git clone http://www.iki.fi/tlikonen/voikko.git

I also build git from the tag v1.5.6 and it seems to work fine, so
I guess the bug was introduced after 1.5.6.
