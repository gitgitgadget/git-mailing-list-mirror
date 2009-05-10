From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] Fix git-push --mirror also mirroring refs/remotes/
Date: Sun, 10 May 2009 23:13:13 +0200
Message-ID: <200905102313.13544.markus.heidelberg@web.de>
References: <1241984136-2578-1-git-send-email-bryan@shatow.net> <200905102225.25508.markus.heidelberg@web.de> <4A073E2E.6060403@shatow.net>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bryan Drewery <bryan@shatow.net>
X-From: git-owner@vger.kernel.org Sun May 10 23:13:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3GL9-00083X-89
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 23:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbZEJVNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 17:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbZEJVNN
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 17:13:13 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:55149 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbZEJVNM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 17:13:12 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 66DBAFEB5F19;
	Sun, 10 May 2009 23:13:12 +0200 (CEST)
Received: from [89.59.125.79] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M3GKe-0000lP-00; Sun, 10 May 2009 23:13:12 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <4A073E2E.6060403@shatow.net>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/HT5eWKeNm0bOrek8yic3dNwEynixMA+9ofJ9s
	39Hwu1ITcWeqWqNEXV5LtlCNbj9IC6frrEiKtQHg78MqR8jYN8
	WjFJXZi/uPNjNywqKWig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118746>

Bryan Drewery, 10.05.2009:
> This behavior makes no sense to me. Can we at least add a config option
> to make it not push remotes? I push my development repository
> to a remote private repository only as a backup, and push my master/next
> to a public repository. I see no reason to push my 8 remotes and
> all their branches to my backup repository.

Why are you disturbed by the remotes, if it's only a backup repository
where you don't look into in the normal case?

Markus
