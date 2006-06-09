From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 12:00:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> 
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 21:01:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FomEN-0003Uq-Dy
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 21:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWFITAt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 15:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWFITAt
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 15:00:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18839 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030398AbWFITAs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 15:00:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k59J0igt024898
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 12:00:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k59J0gxI025652;
	Fri, 9 Jun 2006 12:00:43 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21540>



On Fri, 9 Jun 2006, Jon Smirl wrote:
> 
> That looks too small. My svn git import is 2.7GB and the source CVS is
> 3.0GB. The svn import wasn't finished when I stopped it.

Git is much better at packing than either CVS or SVN. Get used to it ;)

> My cvsps process is still running from last night. The error file is
> 341MB. How big is it when the conversion is finished? My machine is
> swapping to death.

Do you have all the cvsps patches? There's a few important ones floating 
around, and David Mansfield never did a 2.2 release..

I'm pretty sure Martin doesn't run plain 2.1.

		Linus
