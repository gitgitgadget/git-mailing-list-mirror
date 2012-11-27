From: Max Horn <max@quendi.de>
Subject: [PATCH 0/6] Improve remote helper documentation
Date: Tue, 27 Nov 2012 18:44:33 +0100
Message-ID: <1354038279-76475-1-git-send-email-max@quendi.de>
Cc: Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 18:45:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdPEC-0003jF-GV
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756661Ab2K0RpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:45:04 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:45260 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756635Ab2K0RpC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 12:45:02 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=localhost.localdomain); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1TdPDO-00080S-Am; Tue, 27 Nov 2012 18:44:58 +0100
X-Mailer: git-send-email 1.8.0.393.gcc9701d
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1354038302;a61156d0;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210577>

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
  Document invocation first, then input format
  Document missing remote helper capabilities
  Fix grammar
  Rearrange the description of remote helper capabilities
  Make clearer which commands must be supported for which capabilities
  Remove 'for-push' from ref list attributes list, link to subsections

 Documentation/git-remote-helpers.txt | 241 ++++++++++++++++++++---------------
 1 file changed, 136 insertions(+), 105 deletions(-)

-- 
1.8.0.393.gcc9701d
