From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Wed, 17 Oct 2007 19:10:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710171906280.25221@racer.site>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
 <20071017073538.GB13801@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 20:11:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiDMA-0004QT-6y
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 20:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756678AbXJQSKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 14:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756067AbXJQSKs
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 14:10:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:46652 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755813AbXJQSKr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 14:10:47 -0400
Received: (qmail invoked by alias); 17 Oct 2007 18:10:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 17 Oct 2007 20:10:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2jpYoCP627skn2n3BCdPl8/QY5DkpZPkWQOi9Ig
	0A+eNj1kzKqe1N
X-X-Sender: gene099@racer.site
In-Reply-To: <20071017073538.GB13801@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61403>

Hi,

On Wed, 17 Oct 2007, Shawn O. Pearce wrote:

> Christian Couder <chriscool@tuxfamily.org> wrote:
> > Here is my bisect dunno patch series again.
> > The changes since last time are the following:
> 
> I now have this series queued in my pu branch.  It passes the tests
> it comes with, and doesn't appear to break anything, but apparently
> there is also still some debate about what a dunno should be called
> ("unknown", "void", "ugly", "dunno", "skip" ...).

AFAICT these are all bikeshed painting arguments, not technical arguments.  
I was initially opposed to having --bisect-all, wanting to have 
--bisect-dunno <ref>...

But in the end, the people doing the work decide, and therefore I am fine 
with --bisect-all, especially since it seems clean enough for me.

As for all those "dunno is no English"...  I'd first merge the technical 
part (i.e. what you have now in pu), and then let the discussion about 
which synonyms to choose continue, until a consensus is formed about other 
names (if there is a consensus at all!).

IMHO there is no reason to hold of the fine work of Christian, just 
because there are non-technical arguments still in the air.

I want bisect dunno.  Even if there is another name later.

Ciao,
Dscho
