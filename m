From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Suggestion: rebase [--onto <newbase>] [<upstream>][..[<branch>]]
Date: Tue, 17 Jan 2012 17:44:29 +0100 (CET)
Message-ID: <hbf.20120117gdfh@bombur.uio.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 17:44:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnC9F-0000P4-1J
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 17:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab2AQQob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 11:44:31 -0500
Received: from mail-out1.uio.no ([129.240.10.57]:34585 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755086Ab2AQQob (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 11:44:31 -0500
Received: from mail-mx1.uio.no ([129.240.10.29])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RnC97-0004MI-V3
	for git@vger.kernel.org; Tue, 17 Jan 2012 17:44:29 +0100
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx1.uio.no with esmtp  (Exim 4.76)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1RnC97-0003PJ-LI; Tue, 17 Jan 2012 17:44:29 +0100
Received: by bombur.uio.no (Postfix, from userid 2112)
	id 8A72E109D; Tue, 17 Jan 2012 17:44:29 +0100 (CET)
X-UiO-Ratelimit-Test: rcpts/h 7 msgs/h 2 sum rcpts/h 8 sum msgs/h 2 total rcpts 2091 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: A145477493CA9FD5AAAC3B548DC8A02AF2B50CA5
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -49 maxlevel 80 minaction 1 bait 0 mail/h: 2 total 913 max/h 5 blacklist 0 greylist 1 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188708>

I think
	git rebase [--onto <newbase>] [<upstream>][..[<branch>]]
would be a more readable syntax for what rebase is doing.  Easier
to see which argument means what without staring at the manpage.
"..[<branch>]" without <upstream> implies --root.

-- 
Hallvard
