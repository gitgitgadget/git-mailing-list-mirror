From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 13 Mar 2007 21:30:54 +0100
Message-ID: <20070313203054.GA6139@moooo.ath.cx>
References: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net> <7v8xep8dfk.fsf@assigned-by-dhcp.cox.net> <7v7itx5mep.fsf@assigned-by-dhcp.cox.net> <7vps7dle8j.fsf@assigned-by-dhcp.cox.net> <20070313174304.GA2540@moooo.ath.cx> <7vd53cj55n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 21:31:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRDe9-0008A6-RF
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 21:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933177AbXCMUa6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 16:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933297AbXCMUa6
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 16:30:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:33386 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933177AbXCMUa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 16:30:57 -0400
Received: (qmail invoked by alias); 13 Mar 2007 20:30:56 -0000
Received: from pD9EBB63A.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.182.58]
  by mail.gmx.net (mp028) with SMTP; 13 Mar 2007 21:30:56 +0100
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX18GzLgz3zkGbDisb/0Ft4nuTkvQTxbcEcYsYQPZrY
	u0XVQtIjhrlfZ0
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vd53cj55n.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42152>

Junio C Hamano <junkio@cox.net> wrote:
> By the way, why should it be $GIT_DIR/workdir when it appears
> everybody is putting things in $GIT_DIR/config?  Shouldn't it be
> something like:
> 
> 	[core]
>         	worktree = "/path/to/the/working/tree"

That's right.  When I wrote the code I first had only support for a
directory in $GIT_DIR/workdir (using a symlink) and added a file after
that.  Using a symlink is still easily possible with core.worktree =
workdir.
