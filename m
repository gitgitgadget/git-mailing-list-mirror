From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation: reset: describe new "--keep" option
Date: Sat, 6 Mar 2010 20:26:11 +0100
Message-ID: <201003062026.11489.chriscool@tuxfamily.org>
References: <20100305202537.25469.73470.chriscool@tuxfamily.org> <20100306081034.GA4827@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 06 22:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No176-0004YU-OT
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575Ab0CFTgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 14:36:12 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48086 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381Ab0CFTgL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 14:36:11 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 80F7F81818A;
	Sat,  6 Mar 2010 20:36:01 +0100 (CET)
Received: from style.localnet (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 548018181B4;
	Sat,  6 Mar 2010 20:35:59 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-19-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <20100306081034.GA4827@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Saturday 06 March 2010 09:10:34 Peter Baumann wrote:
> On Fri, Mar 05, 2010 at 09:25:36PM +0100, Christian Couder wrote:
> > and give an example to show how it can be used.
> >
> > +--keep::
> > +	Resets the index to match the tree recorded by the named commit,
> > +	but keep changes in the working tree. Aborts if the reset would
> > +	change files that are already modified in the working tree.
> > +
> 
> Huh? Keep changes (by not touching the worktree)

Keep uncommited changes in the working tree does not mean not touching the 
working tree.

> and then aborting if we
> touch the worktree.

We abort if the commit we reset touch some files that have uncommited changes.

> Seems like a contradiction to me.

There is no contradiction. We repeat "working tree" too much perhaps, but what 
is important is to focus on "changes" and "files".

Regards,
Christian.
