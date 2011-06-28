From: eugene <eugene@oggtrading.com>
Subject: refactoring in GIT
Date: Tue, 28 Jun 2011 13:19:23 +0000 (UTC)
Message-ID: <loom.20110628T151105-908@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 17:04:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbZqF-0005AK-Ck
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 17:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738Ab1F1Ouz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 10:50:55 -0400
Received: from lo.gmane.org ([80.91.229.12]:60374 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758330Ab1F1OuI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 10:50:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QbZc6-0007Mc-9M
	for git@vger.kernel.org; Tue, 28 Jun 2011 16:50:06 +0200
Received: from 69.167.69.170 ([69.167.69.170])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 16:50:06 +0200
Received: from eugene by 69.167.69.170 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 16:50:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.167.69.170 (Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; GTB6.5; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176403>

Hi,
 I'm new to GIT and have two questions about code refactoring. 

#1. I want to refactor class A into few classes B,C,D. How should I check them 
in and mark class A inactive so that development on A stops? Note, I do need A 
stay in repository for backward compt. with prior code releases.

#2. [related question] What if another developer already had A in his local 
repository, made changes and wants to commit after me. I just made A obsolete. 
Does he have drop his changes and take B,C,D from me and/or merge?

Sorry if this question was already answered, pls point me.

Thanks,
Eugene
