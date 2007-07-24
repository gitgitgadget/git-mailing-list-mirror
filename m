From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Tue, 24 Jul 2007 15:47:15 +0200
Message-ID: <200707241547.16681.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site> <Pine.LNX.4.64.0707241252040.28577@reaper.quantumfyre.co.uk> <Pine.LNX.4.64.0707241336090.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 15:47:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDKjX-0002AZ-PW
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 15:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848AbXGXNrX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 09:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755129AbXGXNrX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 09:47:23 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:40228 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753212AbXGXNrW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 09:47:22 -0400
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de [131.159.35.46])
	by mail.in.tum.de (Postfix) with ESMTP id D398327BD;
	Tue, 24 Jul 2007 15:47:20 +0200 (MEST)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0707241336090.14781@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53594>

On Tuesday 24 July 2007, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 24 Jul 2007, Julian Phillips wrote:
> 
> > If you were going to avoid symlinks, then probably the cleanest way would be
> > to have an explict way to point at the actual repo - rather than making the
> > working look like a repo if you squint hard enough.  Which sounds rather like
> > it would be an extension to GIT_DIR + GIT_WORK_TREE.
> 
> Almost.  .git/{config,HEAD} are not shared.

.git/index, too. And for .git/config, it would probably be better to merge the
two config's (the one from "realGitDir" with 2nd priority).

> So it would be some extension  
> that is triggered by something like
> 
> 	[core]
> 		realGitDir = /bla/bla/.git/

That is more or less almost exacty the last agreement about how to
implement the lightweight checkouts, a few months ago.

Should this even work recursively?

Josef
