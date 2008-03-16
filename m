From: Nick Warne <nick@ukfsn.org>
Subject: Possible git git config --global user.email BUG
Date: Sun, 16 Mar 2008 19:26:36 +0000
Message-ID: <20080316192636.3075d0eb@linuxamd.linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 20:27:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JayVx-00071V-FV
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 20:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbYCPT0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 15:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbYCPT0k
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 15:26:40 -0400
Received: from mx1.ukfsn.org ([77.75.108.10]:55194 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752167AbYCPT0k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 15:26:40 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 9CED9DEC96
	for <git@vger.kernel.org>; Sun, 16 Mar 2008 19:30:38 +0000 (GMT)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id 0Vhdn5yOBCLa for <git@vger.kernel.org>;
	Sun, 16 Mar 2008 19:03:24 +0000 (GMT)
Received: from linuxamd.linicks.net (linicks.net [87.127.191.50])
	by mail.ukfsn.org (Postfix) with ESMTP id 60620DEC68
	for <git@vger.kernel.org>; Sun, 16 Mar 2008 19:30:38 +0000 (GMT)
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.10.14; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77374>

Hi all,

I have been using git clone for 'pull' only for a while (kernel, Xorg
etc. etc.), but today starting using local commit and creating patches
for Fluxbox project.

On a new clone of fluxbox, I issued:

git config --global nick.email <real.mail.address>
git config --global nick.name "Nick Warne"

I then made my changes and issued:

git commit -a

All OK.

Then showing changes (and also creating the patch BTW!):

git show

Reveals that the change DIFF grabs hold of my local user.domain and not
what I earlier set-up:

From: Nick Warne <nick@linuxamd.linicks.net>
Date: Sun, 16 Mar 2008 15:51:49 +0000


This happens on all the patches....  Have I done something wrong?

Thanks for any help.

Nick
-- 
Free Software Foundation Associate Member 5508
