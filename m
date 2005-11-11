From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] C implementation of the 'git' program.
Date: Fri, 11 Nov 2005 11:31:22 -0800
Message-ID: <7vek5nm16d.fsf@assigned-by-dhcp.cox.net>
References: <20051110182631.3C5615BF90@nox.op5.se>
	<Pine.LNX.4.64.0511101133550.4627@g5.osdl.org>
	<4373CEA8.1020900@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 20:32:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaecR-0005wm-0C
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 20:31:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVKKTbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 14:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVKKTbY
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 14:31:24 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43248 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751092AbVKKTbX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 14:31:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111193019.ZJR2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 14:30:19 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4373CEA8.1020900@op5.se> (Andreas Ericsson's message of "Thu, 10
	Nov 2005 23:50:16 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11631>

Andreas Ericsson <ae@op5.se> writes:

> Linus Torvalds wrote:
>
>> I think this might be a bit ambiguous. When I see "GIT_LIB", to me
>> it implies traditional libraries (ie a "libgit.a" kind of thing),
>> not the kind of "git executable plugin" directory.
>> So I'd suggest renaming "--lib" and "GIT_LIB" to be more of a
>> "--libexec" kind of flavor, if only to avoid that confusion.
>
> Someone said libexec was moving out (of Linux, at least), so I thought 
> I'd better avoid that. Perhaps GIT_LIBDIR?

More like "the rest of git executables".  GIT_EXEC_PATH, with
"git --exec-path" command, perhaps?
