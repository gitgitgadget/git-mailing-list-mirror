From: Marc Weber <marco-oweber@gmx.de>
Subject: verifying git file contents without checking out history?
Date: Mon, 19 Nov 2012 02:50:35 +0100
Message-ID: <1353287836-sup-270@nixos>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 02:51:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaGVp-0000HP-2A
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 02:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab2KSBuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 20:50:39 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:37425 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752780Ab2KSBui (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 20:50:38 -0500
Received: (qmail invoked by alias); 19 Nov 2012 01:50:35 -0000
Received: from p5DD8FA80.dip.t-dialin.net (EHLO mail.gmx.net) [93.216.250.128]
  by mail.gmx.net (mp020) with SMTP; 19 Nov 2012 02:50:35 +0100
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX180+V9/htc0OZAo5XFW5QtrIemKM4CrfzDx5S0PvN
	RqqYNzS4tgxYVH
Received: by mail.gmx.net (sSMTP sendmail emulation); Mon, 19 Nov 2012 02:50:35 +0100
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210038>

git clone --depth=20 $url; git checkout $hash

How to verify that I have the contents I think I have - given that I
trust my local git executable?

Would it be enough to also store the git log --pretty=format:%T $hash
value and check that only? %T is the root tree hash.

Does git checkout verify the file tree checksum when receiving all blob
objects from a server?
Then verifying that %T didn't change should be enough to enable me
fetching sources and trust them without running git fsck which would
fetch all history.

Marc Weber
