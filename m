From: Tim Chase <git@tim.thechases.com>
Subject: defaulting git stash to "--keep-index"
Date: Tue, 19 Nov 2013 19:50:09 -0600
Message-ID: <20131119195009.6d4e183b@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 20 02:49:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Viwv4-0007sc-Gk
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 02:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720Ab3KTBt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 20:49:26 -0500
Received: from boston.accountservergroup.com ([50.22.11.22]:46605 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753832Ab3KTBsm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Nov 2013 20:48:42 -0500
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:56880 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1ViwuH-0004j1-BN
	for git@vger.kernel.org; Tue, 19 Nov 2013 19:48:41 -0600
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: authenticated_id: tim@thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238063>

Having lost "add -p" work enough times when stashing, I finally
dug into the docs to see how to prevent it, discovering that
"--keep-index" does exactly what I want.  However, now I have trouble
remembering to add the "--keep-index" until after I've shot myself in
the foot.  How do I go about getting "git stash" to default to
"--keep-index"?  I've played around a little with aliases, but
haven't found the right incantation.

The existence of "--no-keep-index" suggests there's some way to make
"--keep-index" the default, but I'm missing it.

Thanks,

-tkc
