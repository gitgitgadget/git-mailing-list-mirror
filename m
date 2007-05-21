From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow user to specify mailbox format for mailsplit
Date: Mon, 21 May 2007 16:19:25 -0700
Message-ID: <7vwsz1bw8y.fsf@assigned-by-dhcp.cox.net>
References: <20070520181447.GA10638@ferdyx.org>
	<7vd50uj29r.fsf@assigned-by-dhcp.cox.net>
	<20070521182052.GB4696@ferdyx.org> <20070521230524.GC10890@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 01:20:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqHAh-0002ZC-FL
	for gcvg-git@gmane.org; Tue, 22 May 2007 01:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758283AbXEUXTf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 19:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758510AbXEUXTf
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 19:19:35 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:53062 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758283AbXEUXTe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 19:19:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521231932.JXC15717.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 21 May 2007 19:19:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1zKS1X0Br1kojtg0000000; Mon, 21 May 2007 19:19:27 -0400
In-Reply-To: <20070521230524.GC10890@steel.home> (Alex Riesen's message of
	"Tue, 22 May 2007 01:05:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48062>

Alex Riesen <raa.lkml@gmail.com> writes:

> If the argument ends with a slash - assume it is a Maildir and try to
> create it. Otherwise - it is an mbox.

Sorry, I am lost here.  git-mailsplit is to read an existing
mbox and split the pieces of e-mail into the specified output
directory.  The recent Maildir support is to make it read pieces
of e-mails from an existing Maildir (which presumably have bunch
of files that store e-mail), isn't it?

If the patch were about creating a new _output_ directory (that
is, "dir" in cmd_mailsplit), I would understand what you are
trying to do, but why would you even want to create the input
Maildir in that loop (I take that your patch is on top of
Fernando's patch)?
