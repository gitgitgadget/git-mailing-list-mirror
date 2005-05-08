From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: cg-log patches
Date: Sun, 08 May 2005 19:42:16 +0200
Message-ID: <1115574136.9031.147.camel@pegasus>
References: <1742.10.10.10.24.1115573750.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 19:35:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUpg3-0008O3-7R
	for gcvg-git@gmane.org; Sun, 08 May 2005 19:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbVEHRl5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 13:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbVEHRl5
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 13:41:57 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:58797 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262910AbVEHRlz
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 13:41:55 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j48HhBWX004375
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Sun, 8 May 2005 19:43:12 +0200
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <1742.10.10.10.24.1115573750.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Sean,

> commit 33762f33ee87377c0cfcea51382bad04d7c9ba8d
> 
>     Fix cg-log -f option so that a complete list of files is
>     displayed when a commit has more than one parent.
> 
>     Move the list of files so they're displayed after the
>     commit message
> 
>     List the files in columns, instead of one big line of comma-
>     separated files.

why don't you use diffstat for it? I think that it is more handy then
the list of modified files.

Regards

Marcel


