From: Andy Parkins <andyparkins@gmail.com>
Subject: git checkout won't detach head when a reference equals the detach point
Date: Sun, 18 Feb 2007 18:41:34 +0000
Message-ID: <200702181841.36203.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 18 19:44:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIr1g-0000bR-1o
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 19:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbXBRSod (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 13:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbXBRSod
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 13:44:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:50271 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbXBRSoc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 13:44:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so458187uga
        for <git@vger.kernel.org>; Sun, 18 Feb 2007 10:44:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MYJGOfWFRqGKWehzLas73lBi+8jVVa57RiCm7IDWn6peZ6AZtLiSQTORU3l9Hc+4dEsOCA/SnSV6Lz6noqkVFckiF4Xb9YnXzcbA//HZqIe+D6zdWXz1VdWjXAFQgvo6RvMFTwkX8g5qaqZ3X7N7mMArmwCnceSLbrB9i5mD9Qo=
Received: by 10.66.239.18 with SMTP id m18mr5794873ugh.1171824271393;
        Sun, 18 Feb 2007 10:44:31 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id q1sm7807234uge.2007.02.18.10.44.29;
        Sun, 18 Feb 2007 10:44:29 -0800 (PST)
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40084>

Hello,

Kind of convoluted, and perhaps not even an error.

On a repository with a remote tracking branch, say 
remotes/origin/master, then do this:

git checkout -b temp origin/master
git checkout origin/master
git branch
 * temp

This might seem like an odd thing to want to do, but I found this 
because the next thing I wanted to do was

git branch -D temp

Which won't work because the branch hasn't changed.




Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
