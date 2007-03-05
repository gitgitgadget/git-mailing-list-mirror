From: Junio C Hamano <junkio@cox.net>
Subject: Re: Documentation (mostly user manual) patches
Date: Sun, 04 Mar 2007 19:14:33 -0800
Message-ID: <7vr6s42xgm.fsf@assigned-by-dhcp.cox.net>
References: <1173045556191-git-send-email-bfields@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Mar 05 04:14:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO3en-0006Xn-NH
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 04:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbXCEDOe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 22:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbXCEDOe
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 22:14:34 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:44486 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbXCEDOe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 22:14:34 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070305031433.HNIZ26279.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 4 Mar 2007 22:14:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WrEZ1W00P1kojtg0000000; Sun, 04 Mar 2007 22:14:33 -0500
In-Reply-To: <1173045556191-git-send-email-bfields@citi.umich.edu> (J. Bruce
	Fields's message of "Sun, 4 Mar 2007 16:59:09 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41397>

"J. Bruce Fields" <bfields@citi.umich.edu> writes:

> Sorry for the long silence.  You can also get these by pulling from
>
> 	git://linux-nfs.org/~bfields/git.git
>
> if you'd prefer.

Thanks.  I pulled first, but ended up rebasing them on top of
'maint', as the updated manual is still perfectly applicable for
1.5.0 series.

If it is not too much to ask, I'd prefer future pull insns for
two branches from your side.  Please maintain a fork of my
'maint' and a fork of my 'master' on your side, and apply all
updates to the manual that is applicable to 1.5.0 series on your
'maint'.  If there are updates to the manual that talks about
new material that will appear in 1.5.1, merge your 'maint' to
your 'master' and then apply the updates there.

That way, I can continue pulling your 'maint' to my 'maint' to
keep 1.5.0 series alive without worrying about contaminating
'maint' with new material that should appear only in 1.5.1.  At
the same time, pulling your 'master' to my 'master' will not
miss any updates to 'maint' and the manual that ships with 1.5.1
will talk about new stuff as well.
