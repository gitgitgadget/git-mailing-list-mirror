From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: How-to create a new repository using cogito
Date: Thu, 12 May 2005 08:27:04 -0700
Message-ID: <20050512152704.GA14353@tumblerings.org>
References: <42837827.8020404@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 17:24:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWFXa-0006Yq-Pc
	for gcvg-git@gmane.org; Thu, 12 May 2005 17:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVELPbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 11:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVELPbl
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 11:31:41 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:64749 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S262032AbVELPbh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 11:31:37 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DWFaa-0003jo-DU; Thu, 12 May 2005 08:27:04 -0700
To: Wink Saville <wink@saville.com>
Content-Disposition: inline
In-Reply-To: <42837827.8020404@saville.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 at 08:37:11AM -0700, Wink Saville wrote:
> Hello,
> 
> I've successfully followed the instructions in the cogito README and 
> gotten both cogito repositories and linux. I then tried to create a 
> local repository for a directory of my own. But was unsuccessful.

You didn't read far enough down in the README.

Look for cg-init

> 
> <Attempted to do the following>
> 
> wink@tuxws git-linux $ mkdir test
> wink@tuxws git-linux $ cd test
> wink@tuxws test $ echo "some data" > src.c
> wink@tuxws test $ cat src.c
> some data
> wink@tuxws test $ cg-clone -s .
> defaulting to local storage area
> `/home/wink/git-linux/test/./.git/refs/heads/master' -> 
> `.git/refs/heads/origin'
> cg-pull: objects pull failed
> cg-init: pull failed
> 
> <forged ahead despite the error's>
> 
> wink@tuxws test $ cg-add src.c
> Adding file src.c
> wink@tuxws test $ cg-commit
> usage: git-diff-cache [-p] [-r] [-z] [-m] [--cached] <tree sha1>
> cg-commit: Nothing to commit
> 
> <using "cg-commit ." did prompt me for log info>
> 
> wink@tuxws test $ cg-commit .
> Ignoring path .
> usage: read-tree (<sha> | -m <sha1> [<sha2> <sha3>])
> error: mmap failed
> fatal: cache corrupted
> cg-commit: update-cache failed
> wink@tuxws test $ cg-log
> cat: .git/refs/tags/: Is a directory
> cat: .git/refs/heads/: Is a directory
> Invalid id:
> 
> <contents of .git>
> 
> wink@tuxws test $ find .git -type f
> .git/refs/heads/master
> .git/refs/heads/origin
> .git/index
> .git/branches/origin
> .git/objects/42/6863280eedd08aa600ac034e6a9933ba372944
> 
> So something happened but I'm obviously missing something. Also why does 
> this fail?
> 
> wink@tuxws test $ cd .git/objects/42/
> wink@tuxws test $ git-cat-file 6863280eedd08aa600ac034e6a9933ba372944
> usage: git-cat-file [-t | tagname] <sha1>
> 
> Thanks,
> 
> Wink
> 
> 
> -- 
> No virus found in this outgoing message.
> Checked by AVG Anti-Virus.
> Version: 7.0.308 / Virus Database: 266.11.8 - Release Date: 5/10/2005
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
