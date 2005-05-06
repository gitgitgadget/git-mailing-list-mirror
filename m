From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: How do I...
Date: Fri, 06 May 2005 10:39:33 -0600
Message-ID: <427B9DC5.9060905@tuxrocks.com>
References: <427B3DB3.4000507@tuxrocks.com> <1115390221.10459.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 18:34:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU5m2-0005qc-Av
	for gcvg-git@gmane.org; Fri, 06 May 2005 18:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVEFQkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 12:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVEFQkc
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 12:40:32 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:17419 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261237AbVEFQjm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 12:39:42 -0400
Received: from [10.0.0.10] (byu-gw.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j46GdZOB011344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 May 2005 10:39:36 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Dave Kleikamp <shaggy@austin.ibm.com>
In-Reply-To: <1115390221.10459.4.camel@localhost>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dave Kleikamp wrote:
> On Fri, 2005-05-06 at 03:49 -0600, Frank Sorenson wrote:
> 
> 
>>After doing a cg-update, can I cg-log just the changes since the last
>>update?  Alternatively, how can I tell cg-log I'm caught up, and don't
>>need anything historical?
> 
> 
> (Assuming pulling from "origin")
> Instead of doing cg-update, do cg-pull.  Then "cg-log :origin" will give
> you you the changesets you just pulled.

Super.  This works great.  Thanks.

> "cg-merge origin" will then
> complete operation, thereby catching you up.

Okay, not quite so great.  Here's the ouput when I ran it to update my
kernel this morning.  Note that I haven't made any local modifications.
 I'm seeing this sort of thing often enough that I'm blowing away my
whole git tree and regenerating it to get back to a stable state once or
twice a week.  I'm sure there's another way, but without me making
modifications on my end, I wouldn't expect this to happen.  Suggestions
are welcome! :)

# cg-merge origin
Fast-forwarding 6741f3a7f9922391cd02b3ca1329e669497dc22f ->
2512809255d018744fe6c2f5e996c83769846c07
        on top of 6741f3a7f9922391cd02b3ca1329e669497dc22f...
patching file fs/proc/Makefile
patching file fs/proc/array.c
patching file fs/proc/base.c
patching file fs/proc/generic.c
patching file fs/proc/inode-alloc.txt
patching file fs/proc/inode.c
patching file fs/proc/internal.h
patching file fs/proc/kcore.c
patching file fs/proc/kmsg.c
patching file fs/proc/mmu.c
patching file fs/proc/nommu.c
patching file fs/proc/proc_devtree.c
patching file fs/proc/proc_misc.c
patching file fs/proc/proc_tty.c
patching file fs/proc/root.c
patching file fs/proc/task_mmu.c
patching file fs/proc/task_nommu.c
touch: cannot touch `fs/proc/Makefile': No such file or directory
touch: cannot touch `fs/proc/array.c': No such file or directory
touch: cannot touch `fs/proc/base.c': No such file or directory
touch: cannot touch `fs/proc/generic.c': No such file or directory
touch: cannot touch `fs/proc/inode-alloc.txt': No such file or directory
touch: cannot touch `fs/proc/inode.c': No such file or directory
touch: cannot touch `fs/proc/internal.h': No such file or directory
touch: cannot touch `fs/proc/kcore.c': No such file or directory
touch: cannot touch `fs/proc/kmsg.c': No such file or directory
touch: cannot touch `fs/proc/mmu.c': No such file or directory
touch: cannot touch `fs/proc/nommu.c': No such file or directory
touch: cannot touch `fs/proc/proc_devtree.c': No such file or directory
touch: cannot touch `fs/proc/proc_misc.c': No such file or directory
touch: cannot touch `fs/proc/proc_tty.c': No such file or directory
touch: cannot touch `fs/proc/root.c': No such file or directory
touch: cannot touch `fs/proc/task_mmu.c': No such file or directory
touch: cannot touch `fs/proc/task_nommu.c': No such file or directory
rm: cannot remove `fs/proc/Makefile': No such file or directory
rm: cannot remove `fs/proc/array.c': No such file or directory
rm: cannot remove `fs/proc/base.c': No such file or directory
rm: cannot remove `fs/proc/generic.c': No such file or directory
rm: cannot remove `fs/proc/inode-alloc.txt': No such file or directory
rm: cannot remove `fs/proc/inode.c': No such file or directory
rm: cannot remove `fs/proc/internal.h': No such file or directory
rm: cannot remove `fs/proc/kcore.c': No such file or directory
rm: cannot remove `fs/proc/kmsg.c': No such file or directory
rm: cannot remove `fs/proc/mmu.c': No such file or directory
rm: cannot remove `fs/proc/nommu.c': No such file or directory
rm: cannot remove `fs/proc/proc_devtree.c': No such file or directory
rm: cannot remove `fs/proc/proc_misc.c': No such file or directory
rm: cannot remove `fs/proc/proc_tty.c': No such file or directory
rm: cannot remove `fs/proc/root.c': No such file or directory
rm: cannot remove `fs/proc/task_mmu.c': No such file or directory
rm: cannot remove `fs/proc/task_nommu.c': No such file or directory
fs/proc/Makefile: needs update
fs/proc/array.c: needs update
fs/proc/base.c: needs update
fs/proc/generic.c: needs update
fs/proc/inode-alloc.txt: needs update
fs/proc/inode.c: needs update
fs/proc/internal.h: needs update
fs/proc/kcore.c: needs update
fs/proc/kmsg.c: needs update
fs/proc/mmu.c: needs update
fs/proc/nommu.c: needs update
fs/proc/proc_devtree.c: needs update
fs/proc/proc_misc.c: needs update
fs/proc/proc_tty.c: needs update
fs/proc/root.c: needs update
fs/proc/task_mmu.c: needs update
fs/proc/task_nommu.c: needs update


Thanks,
Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCe53EaI0dwg4A47wRAt5dAJ4wEG8KmRvEnqLMOtDiNrZqRhURMgCfTUaE
JLGGFnRN4YGhix/7SkOwAtg=
=aDQu
-----END PGP SIGNATURE-----
