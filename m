From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make CSS file gitweb/gitweb.css more readable
Date: Mon, 19 Jun 2006 13:14:02 -0700
Message-ID: <7vwtbc9a45.fsf@assigned-by-dhcp.cox.net>
References: <e76qbi$tt9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 22:15:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsQ8P-0003wa-Az
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 22:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWFSUOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 16:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWFSUOF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 16:14:05 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:3036 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964884AbWFSUOE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 16:14:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060619201403.DCWV24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Jun 2006 16:14:03 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22136>

Jakub, I've been applying your patches after hand-fixing but it
appears that there is serious whitespace breakage on the mail
path somewhere between you and the mailing list.  Please check
your MUA.

For example:

>  div.title, a.title {
> -       display:block; padding:6px 8px;
> -       font-weight:bold; background-color:#edece6; text-decoration:none; color:#000000;

The original indents these two lines with a TAB.

I'll hand-munge your patch again and will clean-up the
indentation and push the result out as part of "next" sometime
later.

Also I've removed the commented out "padding-left" in div.pre.
