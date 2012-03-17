From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: rebase problem
Date: Sat, 17 Mar 2012 13:57:47 +0100
Message-ID: <OF506B5658.3E449452-ONC12579C4.00460A6E-C12579C4.0047355D@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 14:07:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8tM8-0006Ux-6z
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 14:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969Ab2CQNHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 09:07:30 -0400
Received: from gw1.transmode.se ([195.58.98.146]:48950 "EHLO gw1.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900Ab2CQNH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 09:07:29 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Mar 2012 09:07:29 EDT
Received: from mail1.transmode.se (mail1.transmode.se [192.168.201.18])
	by gw1.transmode.se (Postfix) with ESMTP id 50FFC258035
	for <git@vger.kernel.org>; Sat, 17 Mar 2012 13:57:48 +0100 (CET)
X-KeepSent: 506B5658:3E449452-C12579C4:00460A6E;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.2FP3 Aug 10, 2010
X-MIMETrack: Serialize by Router on mail1/Transmode(Release 8.5.3|September 15, 2011) at
 17/03/2012 13:57:47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193321>


A co-worker this on our local u-boot repo:
  git checkout master
  git fetch denx/master
  git merge denx/master
<resolve conflicts>
  git commit
  ...
  git commit
Now u-boot is working again
then update to latest u-boot so:
  git fetch denx/master
  git rebase denx/master
Now it is a mess, that rebase seems to start from way back as a
staring reference, not from the last merge shown above.
I guess I forgotten how git works, what did go wrong?

  Jocke
