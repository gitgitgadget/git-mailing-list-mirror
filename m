From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 10:35:30 +0200
Message-ID: <4864A652.6070607@viscovery.net>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Anderson <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 10:36:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC9RW-0005pi-3x
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 10:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321AbYF0Ife (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 04:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755306AbYF0Ifd
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 04:35:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40110 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbYF0Ifc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 04:35:32 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KC9QY-00065V-BK; Fri, 27 Jun 2008 10:35:30 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 22F6654D; Fri, 27 Jun 2008 10:35:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86534>

Robert Anderson schrieb:
> Seems to me the concept of the "index" is a half-baked version of what
> I really want, which is the ability to factor a working tree's changes
> into its constituent parts in preparation for committing them.  The
> index provides some very nice facilities to factor out changes in a
> working tree into a "staging area", but the fundamental flaw of this
> in my view is that this "staging area" is not instantiated as a tree,
> so it cannot be compiled and/or tested before committing.

I do this all the time. After I have made $N commits out of my worktree, I
usually

	$ git rebase -i HEAD~$N

and turn all 'pick's into 'edit's and 'squash's. Then I can compile and
test each commit, perhaps add some fixups, in isolation.

-- Hannes
