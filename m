From: Tim Chase <git@tim.thechases.com>
Subject: branch annotations?
Date: Mon, 25 Nov 2013 08:46:44 -0600
Message-ID: <20131125084644.350bd4f7@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 15:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkxPo-0002Ig-5b
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 15:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756539Ab3KYOpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 09:45:25 -0500
Received: from boston.accountservergroup.com ([50.22.11.22]:53721 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756505Ab3KYOpW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Nov 2013 09:45:22 -0500
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:58784 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1VkxPc-000GvC-2W
	for git@vger.kernel.org; Mon, 25 Nov 2013 08:45:20 -0600
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238310>

Is there any way to associate some sort of note with a branch that
would be shown when listing them?  While I currently have things like
"issue/QA-42", it would be nice to have a note associated with it so
I could do something like

  $ git branch --show-notes
    issue/CR-88: make sure NoSQL engines support .CSV file backends
    issue/QA-31: add missile launch codes
  * issue/QA-42: support flying cars
    master

as I currently need to flip back and forth between my git/terminal
and my issue-tracker to know that, if I need to be adding missile
launch codes, I need to be working on QA-31.  I know there are "note"
features elsewhere for commits, and I know that git-branch supports
showing the most recent commit (that's not always enough info to
discern the branch's purpose).

Thanks for any ideas on how to ease this pain-point, :-)

-tkc
