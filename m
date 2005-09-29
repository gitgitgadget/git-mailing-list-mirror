From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Edit log message after commit
Date: Thu, 29 Sep 2005 09:35:23 +0100
Message-ID: <tnxbr2ce0fo.fsf@arm.com>
References: <dhfjcu$36f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 10:36:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKttY-000643-Pr
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 10:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVI2Ift (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 04:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVI2Ift
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 04:35:49 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:4790 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751125AbVI2Ift (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 04:35:49 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j8T8ZRSV019408;
	Thu, 29 Sep 2005 09:35:27 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id JAA24461;
	Thu, 29 Sep 2005 09:35:25 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.3]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 29 Sep 2005 09:35:24 +0100
To: Kevin Leung <hysoka@gmail.com>
In-Reply-To: <dhfjcu$36f$1@sea.gmane.org> (Kevin Leung's message of "Thu, 29
 Sep 2005 10:28:39 +0800")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 29 Sep 2005 08:35:24.0932 (UTC) FILETIME=[BCC6E440:01C5C4D0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9475>

Kevin Leung <hysoka@gmail.com> wrote:
> Is there any method to edit the log message after committed? I
> couldn't find any information in Documentation and in git mailing
> list.

As the others said, a commit object is immutable but it can be
replaced with a new one and the path from HEAD changed. If you need to
do this often, have a look at StGIT. It allows you to create patches
as git commit objects and indefinitely edit them (both file changes
and commit information like log messages, author etc.).

In the latest snapshot, I also added a commit command to permanently
store the patches into the repository after which you won't be able to
edit them anymore (that's useful for maintainers using StGIT, not only
contributors).

-- 
Catalin
