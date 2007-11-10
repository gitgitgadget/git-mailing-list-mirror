From: Brian Gernhardt <benji@silverinsanity.com>
Subject: t7005 and vi in GIT_EXEC_PATH
Date: Sat, 10 Nov 2007 17:03:44 -0500
Message-ID: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 23:04:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqyQy-0002rD-5D
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 23:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbXKJWDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 17:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754531AbXKJWDv
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 17:03:51 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:53353 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413AbXKJWDu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 17:03:50 -0500
Received: from [192.168.1.6] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id D816D1FFC142
	for <git@vger.kernel.org>; Sat, 10 Nov 2007 22:03:47 +0000 (UTC)
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64380>

If vi is in GIT_EXEC_PATH, then t7005-editor.sh fails because the real  
vi is invoked instead of the test vi script.  This is because the git  
wrapper puts GIT_EXEC_PATH ahead of ".".  I see no easy solution to  
this problem, and thought I should bring it up with the list.

~~ Brian
