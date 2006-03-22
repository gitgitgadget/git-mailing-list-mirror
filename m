From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Tue, 21 Mar 2006 21:46:07 -0800
Message-ID: <7v64m7av6o.fsf@assigned-by-dhcp.cox.net>
References: <7vodzzb5q3.fsf@assigned-by-dhcp.cox.net>
	<86y7z3mdcz.fsf@blue.stonehenge.com>
	<86hd5rma75.fsf@blue.stonehenge.com>
	<7vacbjawyu.fsf@assigned-by-dhcp.cox.net>
	<867j6nm47b.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 06:46:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLwAf-0002sg-VA
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 06:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWCVFqK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 00:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWCVFqK
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 00:46:10 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:35534 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750781AbWCVFqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 00:46:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060322054245.PXPL26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Mar 2006 00:42:45 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <867j6nm47b.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "21 Mar 2006 21:35:52 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17806>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
>
>>> But this wastes a commit.  Is there any way to get an index that simply
>>> includes the file from that other branch?
>
> Junio>         $ git checkout master
> Junio>         $ git checkout next git-cvsimport.perl
>
> Yow.  How simple is *that*?  Thanks.

There is one thing you would want to be careful about.
This updates the index.
