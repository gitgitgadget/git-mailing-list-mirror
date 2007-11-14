From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git and Scmbug integration
Date: Wed, 14 Nov 2007 01:04:57 +0100
Message-ID: <20071114000457.GM3268@steel.home>
References: <1194980792.4106.6.camel@localhost> <20071113234722.GK3268@steel.home> <ee77f5c20711131553j587cb566id6d76bd23182dd6@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristis Makris <kristis.makris@asu.edu>, git@vger.kernel.org,
	scmbug-users@lists.mkgnu.net
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 01:06:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5lN-0002FR-TT
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 01:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759276AbXKNAFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 19:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759294AbXKNAFB
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 19:05:01 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:46195 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbXKNAFA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 19:05:00 -0500
Received: from tigra.home (Faa9a.f.strato-dslnet.de [195.4.170.154])
	by post.webmailer.de (klopstock mo44) (RZmta 14.0)
	with ESMTP id j0478djADI5mTp ; Wed, 14 Nov 2007 01:04:57 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id AB729277AE;
	Wed, 14 Nov 2007 01:04:57 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 9859156D22; Wed, 14 Nov 2007 01:04:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ee77f5c20711131553j587cb566id6d76bd23182dd6@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolA10Q=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64922>

David Symonds, Wed, Nov 14, 2007 00:53:43 +0100:
> On Nov 14, 2007 10:47 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> > > http://bugzilla.mkgnu.net/show_bug.cgi?id=992
> > >
> > > Git does not offer metadata describing a change on the commit trigger
> > >
> > > The commit trigger seems to be "post-commit" but it supplies no arguments.
> >
> > HEAD?
> 
> That wouldn't be particularly safe if you have a very quick succession
> of commits (say, via a rebase, or automated operations) because HEAD
> could be moved by the time the post-commit hook reads it.

How's that? git-commit waits for its hooks.
