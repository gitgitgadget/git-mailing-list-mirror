From: Junio C Hamano <junkio@cox.net>
Subject: Re: Expected Behavior?
Date: Tue, 08 Nov 2005 13:41:20 -0800
Message-ID: <7v7jbig6m7.fsf@assigned-by-dhcp.cox.net>
References: <E1EZKOB-0002j5-VY@jdl.com>
	<7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
	<20051108210332.GB23265@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 22:43:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZbDc-0000YH-IH
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 22:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVKHVlW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 16:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVKHVlW
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 16:41:22 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:31950 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964773AbVKHVlV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 16:41:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108214123.IHAR9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 16:41:23 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051108210332.GB23265@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Tue, 8 Nov 2005 22:03:32 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11358>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> Jon: You could try to this merge with the recursive merge strategy
> (git merge -s recursive 'merge message' master dev) If you do, you
> _should_ get something like:
>
>     CONFLICT (add/add): File file3 added non-identically in both
>     branches. Adding as file3_master and file3_dev instead.
>
> You will then end up with file3_master and file3_dev in your working
> tree, which corresponds to file3 in the master branch and file3 in the
> dev branch, respectively.

Oops, I missed that part.  This is unsafe in theory, if you
could overwrite existing file3_master or file3_dev.  Does that
matter in practice?
