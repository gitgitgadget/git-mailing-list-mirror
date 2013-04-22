From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG] Silent data loss on merge with uncommited changes + renames
Date: Mon, 22 Apr 2013 16:23:52 +0200
Message-ID: <517547F8.3040004@viscovery.net>
References: <vpqobd6q5nm.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 22 16:24:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUHf3-0007P2-T9
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 16:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab3DVOX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 10:23:58 -0400
Received: from so.liwest.at ([212.33.55.23]:25778 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989Ab3DVOX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 10:23:57 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UUHer-0000zw-6m; Mon, 22 Apr 2013 16:23:53 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F26211660F;
	Mon, 22 Apr 2013 16:23:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <vpqobd6q5nm.fsf@grenoble-inp.fr>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222016>

Am 4/22/2013 11:24, schrieb Matthieu Moy:
> Following the discussion on "merge with uncommited changes" inside the
> "git pull --autostash" thread, I did a bit of testing, and encountered a
> case with silent data loss. In short: merge a branch introducing changes
> to a file. If the file has been renamed in the current branch, then "git
> merge" follows the rename and brings changes to the renamed file, but
> uncommited changes in this file are overriden silently.

Can you check whether your case is already covered by one of:

  git grep expect_failure t/*merge*

and if not, contribute a test case?

-- Hannes
