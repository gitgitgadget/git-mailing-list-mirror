From: Max Horn <max@quendi.de>
Subject: [PATCH v2 0/6] Improve remote helper documentation
Date: Wed, 28 Nov 2012 00:03:20 +0100
Message-ID: <1354057407-83151-1-git-send-email-max@quendi.de>
Cc: Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 00:04:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUCS-0005AE-SC
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663Ab2K0XDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:03:48 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:53661 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755399Ab2K0XDr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 18:03:47 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=localhost.localdomain); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1TdUBs-0001yU-Pq; Wed, 28 Nov 2012 00:03:44 +0100
X-Mailer: git-send-email 1.8.0.393.gcc9701d
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1354057427;a49318a8;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210615>

Various remote helper capabilities and commands were not
documented, in particular 'export', or documented in a misleading
way (e.g. 'for-push' was listed as a ref attribute understood by
git, which is not the case). This patch series changes that, and
also address some other things in the remote helper documentation
that I found jarring when reading through it.

Note that the description of export and (im|ex)port-marks probably can be
improved, and I hope that somebody who knows more about them
than me and/or is better at writing documentation will do just that.
But I felt it was better to provide something than to do nothing
and only complain, as I did previously on this subject ;-).

Max Horn (6):
  git-remote-helpers.txt: document invocation before input format
  git-remote-helpers.txt: document missing capabilities
  git-remote-helpers.txt: minor grammar fix
  git-remote-helpers.txt: rearrange description of capabilities
  git-remote-helpers.txt: clarify command <-> capability correspondences
  git-remote-helpers.txt: clarify options & ref list attributes

 Documentation/git-remote-helpers.txt | 245 ++++++++++++++++++++---------------
 1 file changed, 140 insertions(+), 105 deletions(-)

-- 
1.8.0.393.gcc9701d
