From: racin@free.fr
Subject: (unknown)
Date: Mon, 22 Oct 2007 20:16:48 +0200
Message-ID: <1193077008.471ce910f15c5@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 19:17:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik0tk-0001di-7K
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 19:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356AbXJVRQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 13:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbXJVRQx
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 13:16:53 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:51189 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbXJVRQw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 13:16:52 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 398741AB399
	for <git@vger.kernel.org>; Mon, 22 Oct 2007 19:16:51 +0200 (CEST)
Received: from imp8-g19.free.fr (imp8-g19.free.fr [212.27.42.39])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 626791AB3AE
	for <git@vger.kernel.org>; Mon, 22 Oct 2007 19:16:49 +0200 (CEST)
Received: by imp8-g19.free.fr (Postfix, from userid 33)
	id 473E63D13; Mon, 22 Oct 2007 20:16:49 +0200 (CEST)
Received: from 160.228.154.4 ([160.228.154.4]) 
	by imp.free.fr (IMP) with HTTP 
	for <racin@212.27.42.70>; Mon, 22 Oct 2007 20:16:48 +0200
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 160.228.154.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62028>


Hello,

I found the following on the development version of git.el: saving
non-git-managed files in Emacs threw an error.

It is due to a simple error in the call to condition-case in a
recently added function, git-update-save-file.

I attached the patch for your convenience.

Regards,
Matthieu Lemerre

PS: Please Cc me when you ackwowledge; I'm not subscribed to the list.
As a matter of fact, I found the bug only because I didn't find git.el
for my distribution (debian) so I got directly from the development
version on the website.
