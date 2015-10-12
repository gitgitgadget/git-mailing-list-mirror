From: Francois-Xavier Le Bail <devel.fx.lebail@orange.fr>
Subject: How to rebase when some commit hashes are in some commit messages
Date: Mon, 12 Oct 2015 21:59:46 +0200
Message-ID: <561C1132.3090606@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 21:59:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZljGE-0001Sf-6p
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 21:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbbJLT7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 15:59:50 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:48066 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbbJLT7t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 15:59:49 -0400
Received: from [127.0.0.1] ([213.178.77.178])
	by mwinf5d35 with ME
	id UKzm1r00B3qpEb103KznJT; Mon, 12 Oct 2015 21:59:48 +0200
X-ME-Helo: [127.0.0.1]
X-ME-Auth: ZGV2ZWwuZngubGViYWlsQHdhbmFkb28uZnI=
X-ME-Date: Mon, 12 Oct 2015 21:59:48 +0200
X-ME-IP: 213.178.77.178
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279413>

Hello,

[I try some search engines without success, perhaps I have missed something].

For example, if I rebase the following commits, I would want that if
the commit hash 2222222... become 7777777...,
the message
"Update test output for 2222222222222222222222222222222222222222"
become
"Update test output for 7777777..."

Is it possible currently? And if yes how?

Greetings,
Francois-Xavier

-------------------------------------------------------------------
commit 6666666666666666666666666666666666666666
Author: First Last <first.last@example.com>
Date:  Fri Jul 3 17:14:58 2015 -0700

Fix 5

xxx xxx xxx xxx

commit 5555555555555555555555555555555555555555
Author: First Last <first.last@example.com>
Date:  Fri Jul 3 16:58:58 2015 -0700

Update test output for 2222222222222222222222222222222222222222

commit 4444444444444444444444444444444444444444
Author: First Last <first.last@example.com>
Date:  Fri Jul 3 17:50:27 2015 -0700

Fix 4

commit 3333333333333333333333333333333333333333
Author: First Last <first.last@example.com>
Date:  Fri Jul 3 15:01:36 2015 -0700

Fix 3

xxx xxx xxx xxx

commit 2222222222222222222222222222222222222222
Author: First Last <first.last@example.com>
Date:  Fri Jul 3 11:20:28 2015 -0700

Fix 2

xxx xxx xxx xxx

commit 1111111111111111111111111111111111111111
Author: First Last <first.last@example.com>
Date:  Fri Jul 3 09:15:59 2015 -0700

Fix 1

xxx xxx xxx xxx

-------------------------------------------------------------------
