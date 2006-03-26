From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 08:46:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org>
References: <20060326014946.GB18185@pasky.or.cz> <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
 <e06fl8$p9f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 18:46:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNYNX-0003ea-Ui
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 18:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWCZQqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 11:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWCZQqI
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 11:46:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57010 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751479AbWCZQqH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 11:46:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2QGk5DZ024562
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 26 Mar 2006 08:46:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2QGk4r0010780;
	Sun, 26 Mar 2006 08:46:04 -0800
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e06fl8$p9f$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18046>



On Sun, 26 Mar 2006, Jakub Narebski wrote:
>
> I wonder what is the most common case in Linux kernel or git.
> 
> 1.) renaming the file in the same directory, old-file.c to new-file.c?

The kernel uses subdirectories extensively, and a lot of renames (most of 
them, I'd say) is because of that subdirectory structure. 

So the same-directory case is the unusual one, I'd say.

> 3.) splitting file into modules, huge-file.c to file1.c, file2.c?
> 4.) copying fragment of one file to other?
> 5.) moving fragment of code from one file to other?

I'd say that (5) is very common. And (4) happens a lot under certain 
circumstances (new driver, new architecture, new filesystem..).

Doing (3) happens, but probably less often that it should ;/

		Linus
