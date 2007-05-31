From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Breaking up repositories
Date: Wed, 30 May 2007 23:50:14 -0700
Message-ID: <31e9dd080705302350x7752c1f0p3dee2f0d35a97b56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 08:50:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HteUd-0004x2-OJ
	for gcvg-git@gmane.org; Thu, 31 May 2007 08:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbXEaGuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 02:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754330AbXEaGuR
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 02:50:17 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:36091 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbXEaGuP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 02:50:15 -0400
Received: by wx-out-0506.google.com with SMTP id t15so68180wxc
        for <git@vger.kernel.org>; Wed, 30 May 2007 23:50:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qGUs8fjdThGp0A6XTRePa/I7T6dIwHJjH7V7HIMbjw+eesHgl+JpgF4YWVWGZSgz4iFYMXN2PYElN8W5wugXkwfUCtxtC/wE3cBFTxy+bDLBYG/5ECYuAr0ZWGGucWi5eLwe++8WK+WFGDT+tcaZcwKI0oqCnkJ//JUzl5iztfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NJr5mLw7BkDqe2sC9U8PNNjXPM+6ml7WkQcLi+pKNbxZuA/em2SU/R0mtqGrBRKXQe+u4E0q14ZzQx5PF0vMx4FH5R/0md0KNxbxJkHDAX84Nq6x1nhx/z89YgtxH6bsBhRAbUAx5w8SKR39kuloO0JualUtKit/Jy/SZPNaG+s=
Received: by 10.90.97.11 with SMTP id u11mr136168agb.1180594214641;
        Wed, 30 May 2007 23:50:14 -0700 (PDT)
Received: by 10.90.27.9 with HTTP; Wed, 30 May 2007 23:50:14 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48802>

I recently imported my subversion repo with git-svn and I'm curious
what the best way to break up the monolithic repo (my many disparate
projects from my single svn repo) into individual git repos of their
own.

 I'm still trying to get a grasp on the considerable git toolbox and I
can't seem to find the functionality I'm describing, but I'm sure it
exists - I heard Linus talk about it in that Google talk on git!

Thanks,
Jason
