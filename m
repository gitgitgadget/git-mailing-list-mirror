From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: filter-branch --subdirectory-filter prematurely truncating history?
Date: Tue, 10 Mar 2009 08:00:09 +0100
Message-ID: <49B60FF9.9020805@viscovery.net>
References: <loom.20090309T230424-857@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Cap Petschulat <cap@naviasystems.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 08:01:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgvyJ-0002GQ-4A
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 08:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbZCJHAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 03:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbZCJHAW
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 03:00:22 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:64334 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbZCJHAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 03:00:21 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lgvwg-0004h8-9u; Tue, 10 Mar 2009 08:00:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0EE384FB; Tue, 10 Mar 2009 08:00:10 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <loom.20090309T230424-857@post.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112783>

Cap Petschulat schrieb:
> I'd like to spin a subdirectory of an existing git repo off in to its
> own repo while preserving history. From what I've read, I should be
> able to do this with a fresh clone followed by git filter-branch
> --subdirectory-filter MYSUBDIR, assuming I don't care about other
> branches or tags. This runs, and when it's done, I have a repo that
> contains the subdir's contents as its root. So far so good.
> 
> I would expect to see the subdir's full history when I run git log,
> but instead it cuts off prematurely, showing the first commit to be
> some relatively recent minor change I'll call FOO. In gitk, I can see
> that history prior to FOO is still around, but FOO has no parents, and
> the commit before FOO has no children. In the original repo, FOO's
> parent was the merge of a branch which no longer exists, if this
> matters.

A bug in this area was fixed in git v1.6.0-rc3. Which version are you using?

-- Hannes
