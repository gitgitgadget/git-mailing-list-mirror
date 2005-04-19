From: =?utf-8?b?U3TDqXBoYW5l?= Fillod <fillods@gmail.com>
Subject: Re: A VFS layer - was: SCM ideas from 2003
Date: Tue, 19 Apr 2005 23:13:36 +0000 (UTC)
Message-ID: <loom.20050420T003535-908@post.gmane.org>
References: <42647D3D.6030906@qualitycode.com>  <u0tkboecbuybl.fsf@merleau.ntc.nokia.com> <2cfc403205041901074ca57724@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 20 01:19:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1zc-0002rB-J9
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 01:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVDSXTW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVDSXTP
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:19:15 -0400
Received: from main.gmane.org ([80.91.229.2]:6586 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261689AbVDSXSz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 19:18:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DO1v8-0002MN-Uf
	for git@vger.kernel.org; Wed, 20 Apr 2005 01:14:18 +0200
Received: from d83-177-218-88.cust.tele2.fr ([83.177.218.88])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Apr 2005 01:14:18 +0200
Received: from fillods by d83-177-218-88.cust.tele2.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Apr 2005 01:14:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.177.218.88 (Mozilla/5.0 (compatible; Konqueror/3.3; Linux) KHTML/3.3.2 (like Gecko))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jon Seymour <jon.seymour <at> gmail.com> writes: 
[...]  
> It seems to me that file-orientation is here to stay and it would be 
> really cool to layer some kind of virtual filesystem over the git 
> repository so that different trees become transparently accessible via 
> different branches of a file system, e.g.: 
>     /mnt/gitfs/working                  # some kind of writeable virtual 
directory over the git cache 
>     /mnt/gitfs/c157067185209b50b350571fe762c2740ea13fc1  # read-only tree of 
commit c157... 
>     /mnt/gitfs/5b53d3a08d64198d26d4f2323f235790c04aeaab # read-only tree of 
comit 5b53... 
 
Ah, you mean wrapping the libgit in a FUSE plugin and let 
the Linux pagecache/dentry cache do the caching of on-demand 
inflated blobs and indexes? Would the hash be the "inode number"? 
 
 
--  
Stephane 

