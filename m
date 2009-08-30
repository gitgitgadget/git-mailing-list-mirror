From: Brenton Fletcher <i@bloople.net>
Subject: Strangeness with git log --follow
Date: Mon, 31 Aug 2009 00:01:54 +0930
Message-ID: <E50B7EBE-7DBB-442F-A341-FD8A1EEFB41B@bloople.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 30 16:32:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhlS8-0007Uq-4b
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 16:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbZH3OcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 10:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753754AbZH3OcI
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 10:32:08 -0400
Received: from mail-vw0-f195.google.com ([209.85.212.195]:45374 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbZH3OcH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 10:32:07 -0400
Received: by vws33 with SMTP id 33so2321686vws.33
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 07:32:08 -0700 (PDT)
Received: by 10.220.108.71 with SMTP id e7mr4265335vcp.46.1251642725822;
        Sun, 30 Aug 2009 07:32:05 -0700 (PDT)
Received: from ?115.131.199.162? ([115.131.199.162])
        by mx.google.com with ESMTPS id 23sm1336152yxe.4.2009.08.30.07.32.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Aug 2009 07:32:05 -0700 (PDT)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127411>

I'm using git log --follow -p <filename> to list all the commits  
affecting a certain file. My problem is that git log --follow --topo- 
order returns fewer commits than git log --follow --date-order (or  
default). The docs for git log and git-rev-list don't seem to indicate  
whay this is happening.

The repo I'm working with is http://github.com/bloopletech/keycontrol/tree/master 
  and the file is original/C/kc.c on the master branch; I'm using git  
v1.6.4.2

Am I misunderstanding what's going on here? --topo-order is kind of  
doing that I want since it's generating a nice series of commits that  
diff against each other nicely, whereas running without topo-order is  
returning the commits in a sequence which means thay don't properly  
diff against each other. I like the results I'm getting from --topo- 
order, but I need results in date order, which is not assured AFAIK  
with topo-order.

If someone could enlighten me as to what's going on, thanks!

-Brenton Fletcher
