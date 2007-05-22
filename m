From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow user to specify mailbox format for mailsplit
Date: Wed, 23 May 2007 00:04:43 +0200
Message-ID: <20070522220443.GK30871@steel.home>
References: <20070520181447.GA10638@ferdyx.org> <7vd50uj29r.fsf@assigned-by-dhcp.cox.net> <20070521182052.GB4696@ferdyx.org> <20070521230524.GC10890@steel.home> <7vwsz1bw8y.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 23 00:04:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqcTK-00061h-SX
	for gcvg-git@gmane.org; Wed, 23 May 2007 00:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758276AbXEVWEq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 18:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757749AbXEVWEq
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 18:04:46 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:64540 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757563AbXEVWEp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 18:04:45 -0400
Received: from tigra.home (Fc8ee.f.strato-dslnet.de [195.4.200.238])
	by post.webmailer.de (klopstock mo45) (RZmta 6.5)
	with ESMTP id F04758j4MLxJ2R ; Wed, 23 May 2007 00:04:43 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3AA72277BD;
	Wed, 23 May 2007 00:04:43 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1272ED195; Wed, 23 May 2007 00:04:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwsz1bw8y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow37lQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48125>

Junio C Hamano, Tue, May 22, 2007 01:19:25 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > If the argument ends with a slash - assume it is a Maildir and try to
> > create it. Otherwise - it is an mbox.
> 
> Sorry, I am lost here.  git-mailsplit is to read an existing
> mbox and split the pieces of e-mail into the specified output
> directory.  The recent Maildir support is to make it read pieces
> of e-mails from an existing Maildir (which presumably have bunch
> of files that store e-mail), isn't it?

Oh... Fernando, I'm very sorry. I never used mailsplit and didn't even
gave a second thought about its name. For reasons unknown, I assumed
the mbox/maildir argument is for the output.
Must be all the ozone depletion and the cosmic rays now causing
glitches in programmers brains...

> If the patch were about creating a new _output_ directory (that
> is, "dir" in cmd_mailsplit), I would understand what you are
> trying to do, but why would you even want to create the input
> Maildir in that loop (I take that your patch is on top of
> Fernando's patch)?

Yes, but don't apply it! :)
