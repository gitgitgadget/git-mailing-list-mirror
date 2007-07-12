From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Installation failure caused by CDPATH environment variable
Date: Thu, 12 Jul 2007 12:37:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707121234390.4516@racer.site>
References: <9693D8E9-6F11-4AA1-AFCA-7E8456FA6420@wincent.com>
 <Pine.LNX.4.64.0707111807470.4516@racer.site> <86sl7u12m3.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 13:37:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8wz9-0005Re-OH
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 13:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757674AbXGLLhZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 07:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753257AbXGLLhZ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 07:37:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:39088 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752004AbXGLLhY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 07:37:24 -0400
Received: (qmail invoked by alias); 12 Jul 2007 11:37:22 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 12 Jul 2007 13:37:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UmgpbeepUxt7Sat3T5VpicWnn6NMmF6EAhptt+u
	LWg0uk/pWJn4eb
X-X-Sender: gene099@racer.site
In-Reply-To: <86sl7u12m3.fsf@lola.quinscape.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52268>

Hi,

[please Cc' me if you already quote me and answer directly to my message]

On Thu, 12 Jul 2007, David Kastrup wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 11 Jul 2007, Wincent Colaiuta wrote:
> >
> >> [describes the typical CDPATH problem]
> >
> > You exported CDPATH.  You're guaranteed to run into problems with 
> > that.  I doubt that your patch catches all problems in git, and even 
> > if we tried to avoid breakage, you can only do so much about that.
> >
> > It is _wrong_ to export CDPATH.
> 
> But it is not our job to educate people about that.  So I'd just add
> something like
> 
> [ "X" = "X$CDPATH" ] || unset CDPATH # ignore braindamaged exports
> 
> to the top of possibly affected scripts and be done.

We have that already, and we're not done.

> A one-liner that makes this somebody else's problem (if at all) is worth 
> its weight in gold.

That is right.  And a one-liner that pretends to be a solve-all, but is 
not, is worth its weight in lead.

I bet that in ten years we find yet another instance where exporting 
CDPATH, which you should not have done in the first place, breaks Git.

Ciao,
Dscho "who chants wrong, wrong, wrong"
