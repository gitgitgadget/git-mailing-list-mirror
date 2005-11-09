From: Junio C Hamano <junkio@cox.net>
Subject: Re: Expected Behavior?
Date: Tue, 08 Nov 2005 21:50:54 -0800
Message-ID: <7vmzkenzcx.fsf@assigned-by-dhcp.cox.net>
References: <E1EZKOB-0002j5-VY@jdl.com>
	<7vwtjjllw4.fsf@assigned-by-dhcp.cox.net>
	<20051108210332.GB23265@c165.ib.student.liu.se>
	<7v7jbig6m7.fsf@assigned-by-dhcp.cox.net>
	<20051108225320.GB4805@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 06:52:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZirL-0004nF-5a
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 06:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVKIFu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 00:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVKIFu4
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 00:50:56 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:61667 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932465AbVKIFuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 00:50:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109055029.MUBY4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 00:50:29 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051108225320.GB4805@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Tue, 8 Nov 2005 23:53:20 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11385>

Fredrik Kuivinen <freku045@student.liu.se> writes:

>> Oops, I missed that part.  This is unsafe in theory, if you
>> could overwrite existing file3_master or file3_dev.  Does that
>> matter in practice?
>
> It wont overwrite any existing files. If there is a file named
> 'file3_master' then the new file will be named 'file3_master_1' and if
> that file also exists the new file will be named 'file3_master_2', and
> so on.

Another thing to watch out is that a branch name could have a
slash in it.  It might make more sense to just name the heads file3~2
or file3~3 (with as many ~s repeated to avoid name clashes) like
Pasky does.
