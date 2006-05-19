From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Document that "git add" only adds non-ignored files.
Date: Fri, 19 May 2006 14:56:42 -0700
Message-ID: <7vfyj5ispx.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160605191402k2863e5edk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 19 23:56:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhCxk-0007Gz-12
	for gcvg-git@gmane.org; Fri, 19 May 2006 23:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbWESV4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 17:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWESV4o
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 17:56:44 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:27356 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964856AbWESV4n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 17:56:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060519215643.XUHC9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 May 2006 17:56:43 -0400
To: Santi <sbejar@gmail.com>
In-Reply-To: <8aa486160605191402k2863e5edk@mail.gmail.com> (sbejar@gmail.com's
	message of "Fri, 19 May 2006 23:02:34 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20359>

Thanks for the reminder, but I wonder if it is good to update
the description of this command, and ls-files to use the
same wording for consistency.  We seem to use <pathspec> to mean
"this is not necessarily a filename -- we glob", so that may be
a good candidate (we do not have <pathspec> in glossary yet --
we would need to add).

Please don't touch description for diff-* family -- right now,
they say <path>, because they do not glob.  If we decide that it
is a good idea to glob (which I suspect we don't for the
low-level stuff, but we probably do for the "git-diff" wrapper),
we would update the code and the description at the same time.
