From: Junio C Hamano <junkio@cox.net>
Subject: Re: commit triggers.
Date: Fri, 23 Jun 2006 23:43:03 -0700
Message-ID: <7vmzc32gw8.fsf@assigned-by-dhcp.cox.net>
References: <20060624032908.GH19461@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 08:43:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu1rK-0008Tk-Db
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 08:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932902AbWFXGnF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 02:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932905AbWFXGnF
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 02:43:05 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:13722 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932902AbWFXGnE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 02:43:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624064304.QWHB18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 02:43:04 -0400
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20060624032908.GH19461@redhat.com> (Dave Jones's message of
	"Fri, 23 Jun 2006 23:29:08 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22485>

Dave Jones <davej@redhat.com> writes:

> I've grepped around, and come up with nothing, so hopefully
> I'm not overlooking some already-implemented feature
> (though it'd be great if I am).  How much work is involved in
> creating a mechanism where some scripts living in say .git/triggers/
> get executed on commits ?

Perhaps "grep hooks/ git-commit.sh"?

The hooks we have right now are more interested in preventing
you from making crappy commits, so we might not have a
post-commit hook you can use for notification purposes, but if
that is the case I am open to suggestions to add one.  I think
post-commit hook is already there, though.
