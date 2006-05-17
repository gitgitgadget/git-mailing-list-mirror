From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git 1.3.2 on Solaris
Date: Wed, 17 May 2006 01:28:26 -0700
Message-ID: <7vpsidhx79.fsf@assigned-by-dhcp.cox.net>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 10:28:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgHOR-0006pH-Co
	for gcvg-git@gmane.org; Wed, 17 May 2006 10:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWEQI22 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 04:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbWEQI22
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 04:28:28 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38373 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932485AbWEQI22 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 04:28:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517082827.WGLY15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 04:28:27 -0400
To: "Stefan Pfetzing" <stefan.pfetzing@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20171>

"Stefan Pfetzing" <stefan.pfetzing@gmail.com> writes:

> 1.  fix every single shellscript automatically during the build phase
> 2.  setup a dir which contains symlinks to the "right" binaries and
> put that dir into PATH.

You forgot 3.

  3.  rewrite scripts so that they would require only POSIX;
      for ones that do need GNU extended coreutils to do in
      shell, find other ways, perhaps rewriting the stuff in C.

I am not looking forward to do the g- prefix in the main
Makefile.  The approach to have symlink forest under gitexecdir
(<Pine.LNX.4.64.0605162047380.10823@g5.osdl.org> by Linus) is
more palatable, and I am not opposed to host a script to do so
under contrib/notgnu perhaps.
