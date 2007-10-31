From: Bill Lear <rael@zopyra.com>
Subject: cpio command not found
Date: Wed, 31 Oct 2007 06:51:30 -0600
Message-ID: <18216.31314.990545.518458@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 13:52:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InD31-00086k-6x
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 13:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035AbXJaMvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 08:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756088AbXJaMvf
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 08:51:35 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61782 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756064AbXJaMve (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 08:51:34 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l9VCpXb02693;
	Wed, 31 Oct 2007 06:51:33 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62825>

I just cloned the latest git and it builds ok, but fails when I clone:

% uname -a
Linux gronk.zopyra.com 2.4.9-21 #1 Thu Jan 17 14:16:30 EST 2002 i686 unknown

% git --version
git version gitgui.0.8.4.g9c514

% git clone --bare ~/my_repo
Initialized empty Git repository in /repos/git/my_repo/
/opt/git/bin/git-clone: line 297: cpio: command not found

So, should git not check this when it is building?  I don't remember
this dependence from earlier versions of git.  I have been running git
1.4.xx on this machine for a while...


Bill
