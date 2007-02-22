From: Brian Gernhardt <benji@silverinsanity.com>
Subject: git-svn + svn:externals
Date: Thu, 22 Feb 2007 11:10:45 -0500
Message-ID: <51167308-9E52-4E46-80A0-70A3C255C081@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 22 17:10:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKGWx-00063t-HO
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 17:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbXBVQKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 11:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbXBVQKs
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 11:10:48 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:35792 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbXBVQKs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 11:10:48 -0500
Received: from [%??????????`?9?7IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id CA3131FFC132
	for <git@vger.kernel.org>; Thu, 22 Feb 2007 16:10:46 +0000 (UTC)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40352>

Is there any plan or shell incantation to get git-svn working nicely  
with SVN externals?  I'm working a Ruby on Rails application  
(radiantcms.org), which uses the externals to track library  
versions.  I don't mind reading from an SVN repository, but would  
much much rather use git to track my local changes.

Also, is it possible for git-svn to at least warn when the repo  
you're importing has externals?  It would be nicer than randomly  
having hunks of the project missing.

~~ Brian
