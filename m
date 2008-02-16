From: Adam Flott <adam@npjh.com>
Subject: Inheritance of files for parent/child branches
Date: Sat, 16 Feb 2008 11:32:01 -0600 (CST)
Message-ID: <alpine.DEB.1.00.0802161110310.32252@an.sumeria>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 18:32:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQQuF-0001OB-33
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 18:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757740AbYBPRcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 12:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755620AbYBPRcP
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 12:32:15 -0500
Received: from npjh.com ([200.46.204.250]:59636 "EHLO npjh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755481AbYBPRcO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 12:32:14 -0500
Received: from localhost (unknown [200.46.204.191])
	by npjh.com (Postfix) with ESMTP id 0E6D91351F1D
	for <git@vger.kernel.org>; Sat, 16 Feb 2008 17:32:12 +0000 (UTC)
Received: from npjh.com ([200.46.204.250])
 by localhost (mx1.hub.org [200.46.204.191]) (amavisd-maia, port 10024)
 with ESMTP id 63220-03 for <git@vger.kernel.org>;
 Sat, 16 Feb 2008 13:32:11 -0400 (AST)
Received: from an.sumeria (unknown [70.124.58.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by npjh.com (Postfix) with ESMTP id 54D0B1351F1C
	for <git@vger.kernel.org>; Sat, 16 Feb 2008 17:32:11 +0000 (UTC)
X-X-Sender: adam@an.sumeria
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74049>

The only redeeming feature in AccuRev was the ability to an use
inheritance for files in streams (nearly analogous to branches). While
this idea in the SCM world sounds strange, is there anything in git land
that could mimic this sort of behavior?

In case, "inheritance for files..." isn't clear, what I would like to
accomplish is: have a branch "parent" with multiple "children" branches
(which may have descendents of their own). If a file is committed to the
parent branch, then the all the descendents would receive the same
update without manually cherry-picking the commit across all the
branches.


Adam
