From: Madhu <enometh@meer.net>
Subject: Re: git/path.c - order of accessing ~/.gitconfig
Date: Wed, 18 Sep 2013 23:26:45 +0530 (IST)
Message-ID: <20130918.232645.170158661.enometh@meer.net>
References: <20130918.201006.407922449.enometh@meer.net>
	<vpq8uyuxjfe.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr
To: Matthieu.Moy@grenoble-inp.fr
X-From: git-owner@vger.kernel.org Wed Sep 18 20:22:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMMOn-0006rj-Qw
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 20:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954Ab3IRSWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 14:22:45 -0400
Received: from vps4.hungerhost.com ([199.167.40.167]:57955 "EHLO
	vps4.hungerhost.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752147Ab3IRSWo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 14:22:44 -0400
Received: from [59.92.35.116] (port=41363 helo=localhost)
	by vps4.hungerhost.com with esmtpsa (SSLv3:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1)
	(envelope-from <enometh@meer.net>)
	id 1VMMOd-0007rM-Od
	for git@vger.kernel.org; Wed, 18 Sep 2013 14:22:40 -0400
In-Reply-To: <vpq8uyuxjfe.fsf@anie.imag.fr>
X-Mailer: Mew version 6.5 on Emacs 24.3.50 / Mule 6.0 (HANACHIRUSATO)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps4.hungerhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - meer.net
X-Get-Message-Sender-Via: vps4.hungerhost.com: authenticated_id: enometh@secure.meer.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234980>

[I posted this via gmane (m3mwnac9ob.fsf@leonis4.robolove.meer.net)
 but the posting hasn't appeared, so I'm sending this by email..]

* Matthieu Moy <vpq8uyuxjfe.fsf@anie.imag.fr> :
Wrote on Wed, 18 Sep 2013 17:01:57 +0200:
|> * commit 21cf32279120799a766d22416be7d82d9ecfbd04
|> |    In the order of reading, this file comes between the global
|> |    configuration file (typically $HOME/.gitconfig) and the system wide
|> |    configuration file (typically /etc/gitconfig).
|>
|> However git/config.c (git_config_early) commit accesses xdg_config
|> before user_config.  So the comments and documentation are
|> inconsistent with the code.
|
| It seems the commit message is wrong, indeed. But it's too late to fix
| it. OTOH, the documentation seems right to me
| (Documentation/git-config.txt). It says:

No, The commit message is also right.  xdg_config indeed comes betweeen
git_etc_gitconfig and user_config, as the commit says, I misunderstood
what the commit was saying because it says this in the reverse order.
Sorry, (nothing to see here) ---Madhu
