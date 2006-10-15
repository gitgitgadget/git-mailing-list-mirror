From: Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au>
Subject: gitweb.cgi feature request: project list "last change" column	to
 display last change of all heads.
Date: Sun, 15 Oct 2006 18:46:39 +0930
Message-ID: <4531FC77.6010004@adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 15 11:17:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZ278-0002vW-3f
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 11:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWJOJQs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 05:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWJOJQs
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 05:16:48 -0400
Received: from bld-mail07.adl2.internode.on.net ([203.16.214.71]:36269 "EHLO
	mail.internode.on.net") by vger.kernel.org with ESMTP
	id S932360AbWJOJQr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 05:16:47 -0400
Received: from [192.168.1.100] (unverified [203.122.224.179]) 
	by mail.internode.on.net (SurgeMail 3.2f) with ESMTP id 46697811 
	for <git@vger.kernel.org>; Sun, 15 Oct 2006 18:46:42 +0930 (CST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28910>

 Hi,
 I am working with the cinelerra-CV group (cvs.cinelerra.org) and we are 
 starting to use git to develop new patches.  Someone has offered to 
 mirror our git branches to share amongst ourselves at 
 http://www.pipapo.org/gitweb.
 
 The annoying thing is that in our mirrored personal repositories, we 
 switch from head to head and push new features in different head, and 
 then wait for the other developers to review.  At the moment, the 
 getweb.cgi script only shows the "Last Change" for the current branch, 
 and not all branches, (i.e. it's currently showing "13 days ago" for 
 cinelerra-pmdumuid, whilst if you click the summary, you'll see I 
 actually extended one of the branches only "24 hours ago".
 
 2nd feature request it the ability to browse to the next / previous 
 commit when looking at a commitdiff...
