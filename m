From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT 0.99.9
Date: Sun, 30 Oct 2005 14:54:03 -0800
Message-ID: <7v4q6ymx9w.fsf@assigned-by-dhcp.cox.net>
References: <20051030203808.A535B353E3E@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 30 23:54:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWM43-0000Eb-W8
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 23:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVJ3WyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 17:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVJ3WyF
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 17:54:05 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:931 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932382AbVJ3WyE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 17:54:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051030225340.LWCJ4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Oct 2005 17:53:40 -0500
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20051030203808.A535B353E3E@atlas.denx.de> (Wolfgang Denk's
	message of "Sun, 30 Oct 2005 21:38:08 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10839>

Wolfgang Denk <wd@denx.de> writes:

> I have CDPATH set in my  shell  environment,...

I understand some people like CDPATH in their interactive
shells, but I do not see a good reason to export that to random
shell scripts you run from your interactive shell session.

We already have a workaround for this exact silliness in
git-sh-setup. Probably we also need to do this to our build
procedure, I guess.  Sigh...
