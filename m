From: Orestis Markou <orestis@orestis.gr>
Subject: Editing git-svn metadata
Date: Sat, 2 May 2009 04:02:56 +0300
Message-ID: <24ACA1E2-9B33-412D-A426-FAF3CF683ADA@orestis.gr>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 03:04:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M03eb-0002vn-2T
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 03:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbZEBBDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 21:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbZEBBDA
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 21:03:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:21311 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbZEBBC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 21:02:59 -0400
Received: by fg-out-1718.google.com with SMTP id 16so822722fgg.17
        for <git@vger.kernel.org>; Fri, 01 May 2009 18:02:58 -0700 (PDT)
Received: by 10.86.62.3 with SMTP id k3mr3366085fga.28.1241226178701;
        Fri, 01 May 2009 18:02:58 -0700 (PDT)
Received: from ?192.168.10.4? (athedsl-132853.home.otenet.gr [85.75.94.148])
        by mx.google.com with ESMTPS id 4sm1718220fge.13.2009.05.01.18.02.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 May 2009 18:02:58 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118113>

Hello,

I couldn't find anything in the manpages for this, and I don't know  
where else to look for it.

As mentioned here: http://article.gmane.org/gmane.comp.version-control.git/116382 
  , an svn repository I'm working against has a weird layout on which  
git-svn chokes on. I'm working around that by using grafts to inform  
git about the history of the branches. It involves some manual work  
but it's fine.

Another problem I have (possibly linked) is that branches are only  
detected after the first commit to them - the commit that creates the  
branch is not recorded by git-svn at all. This forces me to do a  
'dummy' commit from svn in order to even see the branch in git-svn.

Given that I have all the information I need (branch name, parent id),  
is there any file I can manually edit to inform git-svn about my  
branches?

Alternatively, and more usefully to git in general, perhaps I can have  
a look at the git-svn code and add some diagnostics to see what's  
failing, and provide a patch? I looked for a developer guide but  
couldn't find one (only how to write tests).

Regards,
Orestis
--
orestis@orestis.gr
http://orestis.gr/
