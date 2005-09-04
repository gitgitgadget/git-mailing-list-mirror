From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: Could not interpret heads/dbrt-test as something to pull
Date: Sun, 04 Sep 2005 12:20:10 +0300
Message-ID: <87psrp5gvp.fsf@litku.valo.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 04 11:20:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBqfk-0004VS-UE
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 11:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVIDJUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 05:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVIDJUQ
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 05:20:16 -0400
Received: from fep06-0.kolumbus.fi ([193.229.0.57]:25036 "EHLO
	fep06-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751312AbVIDJUO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 05:20:14 -0400
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep06-app.kolumbus.fi
          with ESMTP
          id <20050904092011.FWNQ27547.fep06-app.kolumbus.fi@litku.valo.iki.fi>
          for <git@vger.kernel.org>; Sun, 4 Sep 2005 12:20:11 +0300
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8052>

I was trying to clone the git repository this morning and it fails
every time:

$ git clone http://www.kernel.org/pub/scm/git/git.git git
defaulting to local storage area
got 953e5842f8fcd40c3e7013a9793746719016db1b
got 394b750a6e25c2f085d950dbe04368e212f07ad8
got 86b13da46cd710a45a89968880c691452d5b70b4
got 245f54e050b65126ec28e82508a1b4e187ca8728
[...]
got 1bd90415deccc4562e0fb4d0f8e58140aa687ac1
got cc4dc346498b450c18b09f63800ac28c07064c52
got 2a54cff3fe9de4828730e3ad1c32217abb2c2731
got 15891f81e0fa99333ad81e9271df5b2a72ba368e
error: Couldn't get http://www.kernel.org/pub/scm/git/git.git/refs/heads/dbrt-test for heads/dbrt-test

error: Could not interpret heads/dbrt-test as something to pull
litku:~/projects/git$ 

I tried this a couple of times this morning (an hour apart) to find
out whether it was just some mirroring glitch, but the error
prevailed. What's wrong?

I'm using git compiled earlier this week on Debian unstable.

-- 
Kalle Valo
