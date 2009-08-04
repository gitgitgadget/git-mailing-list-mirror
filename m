From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/3] sequencer: add "--reset-hard" option to "git
 sequencer--helper"
Date: Tue, 4 Aug 2009 19:09:23 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908041719060.2147@iabervon.org>
References: <20090803024023.3794.44226.chriscool@tuxfamily.org> <alpine.LNX.2.00.0908041111550.2147@iabervon.org> <200908042317.26408.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 01:09:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYT8P-0008Ne-46
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 01:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933070AbZHDXJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 19:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755271AbZHDXJY
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 19:09:24 -0400
Received: from iabervon.org ([66.92.72.58]:34852 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753569AbZHDXJY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 19:09:24 -0400
Received: (qmail 12668 invoked by uid 1000); 4 Aug 2009 23:09:23 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Aug 2009 23:09:23 -0000
In-Reply-To: <200908042317.26408.chriscool@tuxfamily.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124831>

On Tue, 4 Aug 2009, Christian Couder wrote:

> On Tuesday 04 August 2009, Daniel Barkalow wrote:
> > On Mon, 3 Aug 2009, Christian Couder wrote:
> > > This new option uses the "reset_almost_hard()" function to perform
> > > a reset.
> >
> > Shouldn't it make it possible to do an almost-hard reset (that is, keep a
> > dirty working tree's changes while changing the index and HEAD to a
> > different commit)?
> 
> Yeah, I will improve the documentation of this function as Junio requested.

It's not just the documentation; AFAICT, there's no way to get allow_dirty 
set, which in turn makes a bunch of this code unreachable. It would be 
good to expose that from the start, even if nothing uses it immediately, 
so that people to see whether it behaves as expected.

	-Daniel
*This .sig left intentionally blank*
