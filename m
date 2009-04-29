From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: adding arbitary folders to the git index, from outside of the repository
Date: Wed, 29 Apr 2009 02:06:30 +0200
Message-ID: <200904290206.31153.robin.rosenberg.lists@dewire.com>
References: <8ABE87D6-F70D-4A86-8307-88B95FAF350F@patchprint.co.nz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Bush <andrew@patchprint.co.nz>
X-From: git-owner@vger.kernel.org Wed Apr 29 02:06:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyxK4-0003Pm-QE
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 02:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756427AbZD2AGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 20:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021AbZD2AGg
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 20:06:36 -0400
Received: from mail.dewire.com ([83.140.172.130]:17398 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754660AbZD2AGg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 20:06:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 538F210233FA;
	Wed, 29 Apr 2009 02:06:34 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qWuBlV4deAw3; Wed, 29 Apr 2009 02:06:33 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 884DF10233F8;
	Wed, 29 Apr 2009 02:06:33 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <8ABE87D6-F70D-4A86-8307-88B95FAF350F@patchprint.co.nz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117838>

onsdag 29 april 2009 00:54:54 skrev Andrew Bush:
> Hi all,
> 
> I have a desire to have a single git repository that tracks the  
> content of an array of folders located in various places across my  
> file system.
> 
> this doesn't *appear* to be supported in any way, I found some stuff  
> about using shortcuts but that was apparently removed in version 1.6  
> because of the problem of deciding when to follow them and when to  
> index them.
> 
> 
> Ideally what I would like is a way to specify in the git config file  
> for a repository an arbitary list of folders that it should index,  
> instead of only having the choice of indexing the folder the  
> repository is stored in.

What I do sometimes is set GIT_DIR and then add paths relative to
/ and adding excludes for some paths. That way I can cover /etc and
selected parts of /var and other interesting areas. You cannot
however have different roots for your trees, unless you make
the tree using e.g symbolic links to the different directories.

-- robin
