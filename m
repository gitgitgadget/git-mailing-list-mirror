From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: rebase hint unmerged file removed
Date: Mon, 24 Aug 2009 16:42:46 +0200
Message-ID: <4A92A6E6.5060702@viscovery.net>
References: <20090824140549.GA3973@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 16:42:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mfal7-0005q8-7N
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 16:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbZHXOms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 10:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbZHXOms
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 10:42:48 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38886 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbZHXOmr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 10:42:47 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mfakx-0003dA-4C; Mon, 24 Aug 2009 16:42:47 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D8BDE6B7; Mon, 24 Aug 2009 16:42:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090824140549.GA3973@debian.b2j>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126934>

bill lam schrieb:
> Sometimes during rebase -i, it stopped with an unmerged file but that
> file did not have any sections of conflict marked.  ls-files showed it
> had :1: and :2: but no :3:  I suspected that file was git-rm in that
> commit.  Will it be possible for git status or rebase to give hint
> that unmerged file was actually removed?

Rebase -i emitted used to write merge-recursive's conflict hints that said
"modify/delete", "modify/rename", "content", etc. I think that's what you
were looking for. But these hints have vanished since quite some time now.
I haven't taken the time, yet, to track down when this happened and why.

-- Hannes
