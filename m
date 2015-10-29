From: Johannes Sixt <j6t@kdbg.org>
Subject: git-gui is still using old-style git-merge invocation
Date: Thu, 29 Oct 2015 18:50:16 +0100
Message-ID: <56325C58.1060007@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 18:50:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrrLI-0006y8-8o
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 18:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbbJ2RuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 13:50:22 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:55863 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757960AbbJ2RuU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 13:50:20 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nmvSB0PNZz5tlK
	for <git@vger.kernel.org>; Thu, 29 Oct 2015 18:50:17 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id CAB0E5385
	for <git@vger.kernel.org>; Thu, 29 Oct 2015 18:50:16 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280450>

Performing a merge with git gui presents the following message in the 
merge result window:

warning: old-style 'git merge <msg> HEAD <commit>' is deprecated.
Merge made by the 'recursive' strategy.
  a | 1 +
  1 file changed, 1 insertion(+)
  create mode 100644 a

But I am unable to find where the invocation happens. Can somebody help?

-- Hannes

PS: Reproducer:

git init
echo a > a
git add a
git commit -ma a
git checkout -b side @~
echo b > b
git add b
git commit -mb
git gui      # to merge: Ctrl-M, Enter, Enter
