From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] Add platform-independent .git "symlink"
Date: Mon, 18 Feb 2008 13:35:18 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181334010.30505@racer.site>
References: <1203331463-13857-1-git-send-email-hjemli@gmail.com>  <1203331463-13857-2-git-send-email-hjemli@gmail.com>  <1203331463-13857-3-git-send-email-hjemli@gmail.com>  <alpine.LSU.1.00.0802181217580.30505@racer.site>
 <8c5c35580802180518x5c392bddya21c48ea4db9a7cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 14:36:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR6AA-00087D-9m
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 14:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbYBRNfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 08:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbYBRNfb
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 08:35:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:48256 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751311AbYBRNfa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 08:35:30 -0500
Received: (qmail invoked by alias); 18 Feb 2008 13:35:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 18 Feb 2008 14:35:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19j/es6//Vj0YuH581BDKUVGsyc3jOSPpNcBNVC3J
	ncs78ffVp+Tg9h
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580802180518x5c392bddya21c48ea4db9a7cd@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74287>

Hi,

On Mon, 18 Feb 2008, Lars Hjemli wrote:

> On Feb 18, 2008 1:34 PM, Johannes Schindelin 
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > [* snip *]
> >
> > So maybe we can just scratch all that, and I agree that an invalid 
> > .git file means "no repository" (as opposed to "no valid repository").
> >
> > In that case, you might want to test for that, too...
> 
> I think I do, did you find a loophole in the testing?

I meant writing a readable, but invalid .git file.  Then testing that Git 
die()s with the correct message.

> > Speaking about tests:
> >
> > > +test_expect_success 'setup' '
> > > +       REAL="$(pwd)/.real" &&
> > > +       mv .git "$REAL" &&
> > > +       echo "gitdir: $REAL" >.git
> > > +'
> >
> > Let's not do this.  It would clutter the t/ directory unnecessarily.
> 
> What do you mean? The test just moves t/trash/.git to t/trash/.real...

Oh, well.  I'll go and buy me some new glasses.

Thanks,
Dscho
