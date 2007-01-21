From: Bill Lear <rael@zopyra.com>
Subject: git-push through git protocol
Date: Sun, 21 Jan 2007 08:10:46 -0600
Message-ID: <17843.29798.866272.414435@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 21 15:11:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8dPa-0004cs-SQ
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 15:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbXAUOLE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 09:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbXAUOLE
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 09:11:04 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60680 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698AbXAUOLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 09:11:03 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0LEB1E13249;
	Sun, 21 Jan 2007 08:11:01 -0600
To: git@vger.kernel.org
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37325>

We have a secure network in which we run all of our git-supported
development activities.  We would like to be able to do git-push
through the git protocol.  Reasons: 1) it seems more efficient; 2) we
have run into problems with developers having different umasks ---
when run through ssh, we ran into file permissions problems and
instead of tracking down each umask issue the developer has (and,
frankly, not wanting to change their default), we resorted to fixing
up the permissions inside of the update hook (chmod -R ug+w, I think);
3) we would prefer a single protocol instead of sometimes pulling with
git and pushing with ssh.

It seems there should be a way to configure a repo or the git daemon
to say "Allow push operations".

I looked through the release notes Junio posted for 1.5.0-rc2, but
found no reference to the git daemon.


Bill
