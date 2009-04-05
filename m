From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: git-{diff,merge} refactor round 2
Date: Sun, 5 Apr 2009 04:58:17 +0200
Message-ID: <200904050458.17708.markus.heidelberg@web.de>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, charles@hashpling.org, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 05:00:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqIaV-0007E5-Te
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 05:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717AbZDEC6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 22:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756715AbZDEC6S
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 22:58:18 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:47778 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071AbZDEC6R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 22:58:17 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id A3189F9FB9F9;
	Sun,  5 Apr 2009 04:58:15 +0200 (CEST)
Received: from [89.59.118.104] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LqIYp-0000XY-00; Sun, 05 Apr 2009 04:58:15 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1238590514-41893-1-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19jwavKEOYJcYzvc2a3hHRxs7Mj/T+ugyMG5XQx
	ibyuQ3r8UIAm0mFoA6P3xua2uJRb/qRSW3BzC1uNNppKdVyWCe
	8BdGz7Z5r9+1faKqmXDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115622>

David Aguilar, 01.04.2009:
> Here's the 2nd round of refactoring.

I just noticed that mergetool.<mergetool>.path doesn't work anymore.
git grep mergetool.*path only hits one line in git-difftool--helper.sh
Neither does it seem to work with difftool, but I'm gonna go to bed now.

Markus
