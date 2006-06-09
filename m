From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git-daemon messing up permissions for gitweb
Date: Fri, 09 Jun 2006 13:34:50 -0700
Message-ID: <7vodx2m5jp.fsf@assigned-by-dhcp.cox.net>
References: <5A14AF34CFF8AD44A44891F7C9FF41050795787F@usahm236.amer.corp.eds.com>
	<Pine.LNX.4.64.0606091321100.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Post, Mark K" <mark.post@eds.com>
X-From: git-owner@vger.kernel.org Fri Jun 09 22:35:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fonh1-00041C-Dj
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 22:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWFIUew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 16:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWFIUew
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 16:34:52 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7883 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965048AbWFIUev (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 16:34:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060609203451.MOYH554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Jun 2006 16:34:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091321100.5498@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 9 Jun 2006 13:22:18 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21551>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 9 Jun 2006, Post, Mark K wrote:
>>
>> Martin is using git over SSH.  I have git-shell in /etc/passwd for his
>> account.
>
> Ahh. git-shell doesn't read .bashrc or anything like that.

But that should be tweakable by configuring what sshd does for
the user, shouldn't it?  The "LOGIN PROCESS" section from man
sshd(8) seems to talk about $HOME/.ssh/environment, for example.
