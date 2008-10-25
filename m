From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: git export to svn
Date: Sat, 25 Oct 2008 11:43:25 -0700
Message-ID: <1224960205.2874.11.camel@localhost.localdomain>
References: <FC51BBF1-B2CA-4A00-9312-2333FDA537C2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Warren Harris <warrensomebody@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 21:24:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ktok7-0002tL-Tw
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 21:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbYJYTW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 15:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752033AbYJYTW6
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 15:22:58 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:53815 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbYJYTW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 15:22:57 -0400
X-Greylist: delayed 2371 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Oct 2008 15:22:57 EDT
Received: from [192.168.144.248] ([216.239.45.19])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id m9PIhNOE026616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 25 Oct 2008 11:43:23 -0700
In-Reply-To: <FC51BBF1-B2CA-4A00-9312-2333FDA537C2@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/8491/Sat Oct 25 07:32:29 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Sat, 25 Oct 2008 11:43:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99121>

The basic way you would want to do it, it attach your git tree to SVN
and then git svn dcommit - which will replay the uncommitted changes
back into SVN - git svn init will do the attachment - assuming that your
git / svn repositories are at least based from the same place.

- John 'Warthog9' Hawley

On Sat, 2008-10-25 at 11:40 -0700, Warren Harris wrote:
> Is there a way to export a git repository along with its history to  
> svn? (git svn init seems to want to go in the other direction.) I know  
> this is in some sense "going backwards" but I need to commit my work  
> to a client. Thanks,
> 
> Warren
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
