From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-tree
Date: Mon, 7 Nov 2005 19:35:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511071934410.3247@g5.osdl.org>
References: <20051108021232.GB10835@redhat.com> <Pine.LNX.4.64.0511071819510.3247@g5.osdl.org>
 <20051108025755.GA22243@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 04:36:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZKHW-0000da-5Z
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 04:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVKHDgT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 22:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVKHDgT
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 22:36:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51606 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932344AbVKHDgS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 22:36:18 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA83a0nO009813
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 7 Nov 2005 19:36:01 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA83Zu7p015967;
	Mon, 7 Nov 2005 19:35:58 -0800
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20051108025755.GA22243@redhat.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11308>



On Mon, 7 Nov 2005, Dave Jones wrote:
> 
> (18:47:37:davej@hera:agp2)$ export KERNEL=master.kernel.org:/pub/scm/linux/kernel/git/
> (18:47:43:davej@hera:agp2)$ git fetch $KERNEL/torvalds/linux-2.6 master:linus
> davej@master.kernel.org's password:
> Packing 35335 objects
> Unpacking 35335 objects
>  100% (35335/35335) done
> * committish: d27ba47e7e8c466c18983a1779d611f82d6a354f
>   branch 'master' of master.kernel.org:/pub/scm/linux/kernel/git//torvalds/linux-2.6
> * refs/heads/linus: storing branch 'master' of master.kernel.org:/pub/scm/linux/kernel/git//torvalds/linux-2.6
> 
> which looks ok, but then when I do the git log linus..HEAD, I get no output at all.

You've got the right "linus" commit.

However, are you aware that I did pull from you? If you don't have 
anything new, "no output at all" is the right thing.

> *click*, ahh wait, I didn't have a 'linus' branch before I did that fetch.
> For the above to work, do I need there to be a 'linus' branch before
> I start making changes ?  Or am I barking up the wrong tree ?

No, the above will have created the "linus" branch as needed.

		Linus
