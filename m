From: =?iso-8859-1?Q?Andr=E9_H=E4nsel?= <andre@webkr.de>
Subject: git merge --abort deletes unstaged files
Date: Mon, 15 Sep 2014 17:43:33 +0200
Message-ID: <04af01cfd0fb$d077e200$7167a600$@webkr.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 17:50:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTYYK-0002Pl-1F
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 17:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbaIOPuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 11:50:50 -0400
Received: from webkr.de ([78.47.151.182]:47037 "HELO mail.webkr.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753743AbaIOPuT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 11:50:19 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Sep 2014 11:50:19 EDT
Received: (qmail 9317 invoked from network); 15 Sep 2014 15:43:37 -0000
Received: from unknown (HELO LappyAndre) (andre@webkr.de@128.199.152.82)
  by mail.webkr.de with SMTP; 15 Sep 2014 15:43:37 -0000
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac/Q+6S5OotCctiVTn6oTzqIlib5wg==
Content-Language: de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257054>

As discussed in
https://groups.google.com/forum/#!topic/git-users/uR7gzLL2Ovc:

I ran git merge to merge a branch. There were some conflicted files.
Although they were automatically resolved by git rerere, I still had to add
them. I accidentally ran "git add ." instead of "git add -u". I noticed my
mistake and ran "git merge --abort" to start over. To my dismay all my
untracked files were gone.
