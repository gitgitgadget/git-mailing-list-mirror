From: davetron5000 <davetron5000@gmail.com>
Subject: Re: How does git store branchpoints?
Date: Mon, 9 Jun 2008 12:54:41 -0700 (PDT)
Message-ID: <fd42f577-60ba-4d26-85a3-7ca4ea8295db@a1g2000hsb.googlegroups.com>
References: <beffea8c-fd2a-44d0-a566-3ded5d09a3d2@l42g2000hsc.googlegroups.com> 
	<m3hcc2wso1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 21:55:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5nSq-0008Dk-9U
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 21:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbYFITyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 15:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753263AbYFITyn
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 15:54:43 -0400
Received: from yx-out-2122.google.com ([74.125.44.26]:55004 "EHLO
	yx-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbYFITym (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 15:54:42 -0400
Received: by yx-out-2122.google.com with SMTP id 35so588812yxh.1
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 12:54:41 -0700 (PDT)
Received: by 10.151.108.5 with SMTP id k5mr52470ybm.0.1213041281645; Mon, 09 
	Jun 2008 12:54:41 -0700 (PDT)
In-Reply-To: <m3hcc2wso1.fsf@localhost.localdomain>
X-IP: 98.218.223.189
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; 
	rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84414>


>
> You can ask git to find branch point using "git merge-base trunk FOO",
> which should return 'c' (actually, sha-1 of this commit).

OK, this revealed interesting results.  The commit it gave me was a
commit right before ANOTHER SVN branch that I was originally to work
on, but never did.  The files git-merge showed conflicts for were
files modified since THAT branch (call it BAR) was created and before
my branch (FOO) was created.

So, any ideas why git thinks that my two branches are rooted at BAR
and not FOO?  git-svn dcommit on local-FOO commits to FOO and not BAR.

Dave
