From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: question git & branches
Date: Mon, 29 Aug 2005 11:04:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508291103010.3243@g5.osdl.org>
References: <4312C24E.4000803@candelatech.com> <Pine.LNX.4.58.0508290754410.3243@g5.osdl.org>
 <43134AA3.2010308@candelatech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 20:06:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9nzs-0007nZ-4V
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 20:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVH2SEc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 14:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVH2SEc
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 14:04:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28630 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751246AbVH2SEa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 14:04:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7TI4SjA012048
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Aug 2005 11:04:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7TI4Oju015720;
	Mon, 29 Aug 2005 11:04:26 -0700
To: Ben Greear <greearb@candelatech.com>
In-Reply-To: <43134AA3.2010308@candelatech.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7912>



On Mon, 29 Aug 2005, Ben Greear wrote:
> 
> I tried 'git checkout ben_dev_rfcnt'.  It took a few seconds and
> had no errors.  But, the files created on my other branch still
> exist in the code tree, and I still see my patch in the
> existing files..  I would expect them to go away.
> 
> I don't think I've managed to commit anything to any branch yet...  Could that
> be part of the problem?

Yes. If you haven't committed anything, then the dirty state follows you
to the other branch (unless the branch differs in the dirty files, in
which case "git checkout" will refuse with a hopefully quite
understandable error message).

> I tried gitk -all, and get this error popup:

Double dashes: "gitk --all".

		Linus
