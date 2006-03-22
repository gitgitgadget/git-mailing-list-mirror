From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Tue, 21 Mar 2006 21:07:37 -0800
Message-ID: <7vacbjawyu.fsf@assigned-by-dhcp.cox.net>
References: <7vodzzb5q3.fsf@assigned-by-dhcp.cox.net>
	<86y7z3mdcz.fsf@blue.stonehenge.com>
	<86hd5rma75.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 22 06:07:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLvZQ-000750-5C
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 06:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWCVFHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 00:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWCVFHl
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 00:07:41 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:49074 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750762AbWCVFHk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 00:07:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060322050416.OXPE26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Mar 2006 00:04:16 -0500
To: git@vger.kernel.org
In-Reply-To: <86hd5rma75.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "21 Mar 2006 19:26:22 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17804>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> For example, I can do this:
>
> $ git-checkout next
> $ cp git-cvsimport.perl DUMMY
> $ git-checkout -b my-playground
> $ mv DUMMY git-cvsimport.perl
> $ git-commit -a -m 'trying that other version'
>
> But this wastes a commit.  Is there any way to get an index that simply
> includes the file from that other branch?

        $ git checkout master
        $ git checkout next git-cvsimport.perl
