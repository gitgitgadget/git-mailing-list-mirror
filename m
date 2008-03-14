From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 0/5] builtin-status submodule summary
Date: Fri, 14 Mar 2008 17:22:16 +0100
Message-ID: <47DAA638.6060108@viscovery.net>
References: <1205508521-7407-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 17:23:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaCgP-0008AX-Jr
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 17:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbYCNQWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 12:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753880AbYCNQWW
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 12:22:22 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:3101 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548AbYCNQWV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 12:22:21 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JaCex-0005I9-Le; Fri, 14 Mar 2008 17:21:31 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EE3E84E4; Fri, 14 Mar 2008 17:22:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1205508521-7407-1-git-send-email-pkufranky@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77251>

Ping Yin schrieb:
> IMO, git submodule summary is not so useful for me if it's not
> integrated into git-status. In fact i never use "git submodule
> summary" directly. git-status with submodule summary support is very
> useful to help user figure out what is going on in a more global level
> when cooking the commit message.
> 
> So i think this series should go along with the submodule summary series.

I think so, too. The changes and defaults in wt-status.c are trivial
enough that they don't penalize traditional git-status users.

> The v2 series has following commits adding a new commit for documentation
> 
>     1  git-submodule summary: --for-status option
>     2  builtin-status: submodule summary support
>     3  builtin-status: configurable submodule summary size
>     4  buitin-status: Add tests for submodule summary
>     5  git-status: Mention status.submodulesummary config in the documentation

I'd actually squash 2, 3, and 5.

You still have the statement before a declaration in 3/5.

> +	if (! wt_status_submodule_summary) return;

And here the important part (IMO) is actually that 'return' should go on a
line of its own.

-- Hannes
