From: Paul Mackerras <paulus@samba.org>
Subject: Re: Shipping gitk as part of core git.
Date: Sun, 31 Jul 2005 07:00:25 -0500
Message-ID: <17132.48473.276198.835869@cargo.ozlabs.ibm.com>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
	<7vy87o6htm.fsf@assigned-by-dhcp.cox.net>
	<7vk6j8yo0g.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 14:02:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzCWI-00066H-AZ
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 14:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263216AbVGaMCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 08:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263218AbVGaMCL
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 08:02:11 -0400
Received: from ozlabs.org ([203.10.76.45]:16055 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263216AbVGaMCK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 08:02:10 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id B516967DC5; Sun, 31 Jul 2005 22:02:08 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6j8yo0g.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:

> It appears that gitk gets wider test coverage only after it is
> pulled into git.git repository.  I think it would be a good idea
> for me to pull from you often.

Yes, I agree.  I'm happy to send you an email when I have committed
changes to gitk if that will help.

> Recently there was a discussion with binary packaging folks.
> While I do not mind, and actually I would prefer, shipping gitk
> as part of the core GIT, I have never heard about your
> preference.  As long as gitk is just a single file (or even a
> handful files in the future) project that does not have a
> filename that overlaps with core GIT, I can continue pulling
> from you and I think the binary packaging folks can produce
> separate git-core and gitk package out of git.git tree without
> problems.  However, once you start wanting to have your own
> Makefile and maybe debian/rules file for packaging, for example,
> I suspect the way currently things are set up would break
> miserably.  It's all Linus' fault to have merged with your tree
> in the first place ;-).

He did ask me first, and I said he could :).  It makes things easier
for me, having gitk in the core git, because it means that I don't
have to worry about making a proper package out of it.  I don't see
any reason why gitk would grow to be more than just the script.

I am also thinking of doing a "gitool", somewhat like bk citool, to
make it easier to create commits.  I guess we can decide later whether
to make it part of the core git, although it seems more like porcelain
than gitk.

> Anyhow, I have one bug to report.  I selected one rev, and then
> said "diff this -> selected" from right-click menu on an
> adjacent one, and I got this:

Thanks for the patch.  I have committed that fix plus fixes for some
other bugs that people have reported, and pushed it to
master.kernel.org.  Could you do another pull please?

Regards,
Paul.
