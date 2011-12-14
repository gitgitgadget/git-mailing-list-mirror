From: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
Subject: How to commit incomplete =?UTF-8?Q?changes=3F?=
Date: Thu, 15 Dec 2011 00:24:33 +0100
Message-ID: <4cfc9cf0515b1bc751f6aa0de4f55e2a@ulrik.uio.no>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 00:45:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RayVj-0000NK-Dq
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 00:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab1LNXpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 18:45:11 -0500
Received: from mail-out1.uio.no ([129.240.10.57]:51997 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150Ab1LNXpK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 18:45:10 -0500
X-Greylist: delayed 1235 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Dec 2011 18:45:09 EST
Received: from mail-mx3.uio.no ([129.240.10.44])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1RayBd-0007j6-SA
	for git@vger.kernel.org; Thu, 15 Dec 2011 00:24:33 +0100
Received: from w3prod-wm01.uio.no ([129.240.4.214] helo=webmail.uio.no)
	by mail-mx3.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1RayBd-0002TR-Gf
	for git@vger.kernel.org; Thu, 15 Dec 2011 00:24:33 +0100
Received: from c3C3D47C1.dhcp.bluecom.no ([193.71.61.60])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Thu, 15 Dec 2011 00:24:33 +0100
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 1 msgs/h 1 sum rcpts/h 4 sum msgs/h 1 total rcpts 2038 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RP_MATCHES_RCVD=-2.023,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 76EAFF6FDCD8051CC3149048733EC990E3AA4678
X-UiO-SPAM-Test: remote_host: 129.240.4.214 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 23 total 1944038 max/h 663 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187177>

 Do people have any feelings or conventions for how and when to publish
 a series of commits where the first one(s) break something and the next
 ones clear it up?  I've found some discussion, but with vague results.

 I'm about to commit some small edits which go together with bigger
 generated changes.  It seems both more readable and more cherry-pick-
 friendly to me to keep these in separate commits.

 What I've found is I can use a line in the commit message like
     "Incomplete change, requires next commit (update foo/ dir)."
 and, if there is any point, do a no-ff merge past the breakage.

-- 
 Hallvard
