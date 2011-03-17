From: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
Subject: git filter-branch --filter-notes/--post-rewrite?
Date: Thu, 17 Mar 2011 21:50:12 +0100
Message-ID: <hbf.20110317iwua@bombur.uio.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 22:24:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0KgZ-0002Ze-A7
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 22:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659Ab1CQVYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 17:24:42 -0400
Received: from mail-out2.uio.no ([129.240.10.58]:35224 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755653Ab1CQVYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 17:24:40 -0400
X-Greylist: delayed 2067 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Mar 2011 17:24:40 EDT
Received: from mail-mx4.uio.no ([129.240.10.45])
	by mail-out2.uio.no with esmtp (Exim 4.74)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1Q0K96-0005tt-Mm
	for git@vger.kernel.org; Thu, 17 Mar 2011 21:50:12 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx4.uio.no with esmtp  (Exim 4.72)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1Q0K96-0001d4-Bt; Thu, 17 Mar 2011 21:50:12 +0100
Received: from hbf by bombur.uio.no with local (Exim 4.72)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1Q0K96-00075x-9i; Thu, 17 Mar 2011 21:50:12 +0100
X-UiO-Ratelimit-Test: rcpts/h 2 msgs/h 1 sum rcpts/h 3 sum msgs/h 1 total rcpts 999 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: A5720C94ADDD5EC490EA3E43C712FB1089E3E456
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -49 maxlevel 80 minaction 1 bait 0 mail/h: 1 total 429 max/h 5 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169279>

Is there a git version where filter-branch can copy notes, or with a
post-rewrite hook?  I found an old discussion of that on WWW, but
nothing seems to have come of that yet.  Currently I remove the 'rm
-rf "$tempdir"' in git-filter-branch.sh so the info is available
for a separate script.

-- 
Hallvard
