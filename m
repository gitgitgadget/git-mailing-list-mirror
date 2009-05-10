From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] Fix git-push --mirror also mirroring refs/remotes/
Date: Sun, 10 May 2009 22:25:24 +0200
Message-ID: <200905102225.25508.markus.heidelberg@web.de>
References: <1241984136-2578-1-git-send-email-bryan@shatow.net>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bryan Drewery <bryan@shatow.net>
X-From: git-owner@vger.kernel.org Sun May 10 22:26:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3Fb3-0007wi-5S
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 22:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbZEJUZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 16:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752437AbZEJUZw
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 16:25:52 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:38100 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbZEJUZv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 16:25:51 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id B2E11101B57B1;
	Sun, 10 May 2009 22:25:24 +0200 (CEST)
Received: from [89.59.125.79] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M3FaO-00069t-00; Sun, 10 May 2009 22:25:24 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1241984136-2578-1-git-send-email-bryan@shatow.net>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19/lqz/FE/MRTDtLdiTWHGK/1qhD8H47fcMnu28
	pV94aSejzUo+01C5OZYvrc7INseGR2TMdPLK0qjRFeBrUYfXR6
	cwKtPM+gUuERxGwy+1yA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118743>

Bryan Drewery, 10.05.2009:
> git-push --mirror was incorrectly mirroring refs/remotes/

No, that's correct.

> previously. This patch fixes it to follow the documentation
> which is to mirror only refs/heads/ and refs/tags/.

Where have you read this? In the git-push docs at the --mirror
description there is written "all refs under $GIT_DIR/refs/".

Markus
