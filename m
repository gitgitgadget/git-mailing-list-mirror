From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deprecate git-fetch-pack?
Date: Mon, 12 Nov 2007 19:08:51 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711121905300.4362@racer.site>
References: <Pine.LNX.4.64.0711101752490.29952@iabervon.org> 
 <7v4pftip42.fsf@gitster.siamese.dyndns.org>  <74415967-7F49-426C-8BF5-1A0210C337AB@develooper.com>
  <Pine.LNX.4.64.0711111103240.4362@racer.site>  <7vd4ugcwkm.fsf@gitster.siamese.dyndns.org>
  <20071111222117.GA7392@thunk.org>  <7vabpkbebj.fsf@gitster.siamese.dyndns.org>
  <Pine.LNX.4.64.0711112247350.4362@racer.site>  <20071111235819.GB7392@thunk.org>
 <fh8609$umn$1@ger.gmane.org>  <1194888565.1335.1.camel@ld0161-tx32> 
 <Pine.LNX.4.64.0711121732000.4362@racer.site> <1194893799.1335.4.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 20:09:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ireey-0003cm-UY
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 20:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbXKLTJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 14:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbXKLTJI
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 14:09:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:33384 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751913AbXKLTJG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 14:09:06 -0500
Received: (qmail invoked by alias); 12 Nov 2007 19:09:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 12 Nov 2007 20:09:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18n/c1/pCsnlQ3qRuV0YZ1iC8o/luziFUA/0nTZ+j
	ogR92xcUcRRIpe
X-X-Sender: gene099@racer.site
In-Reply-To: <1194893799.1335.4.camel@ld0161-tx32>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64687>

Hi,

On Mon, 12 Nov 2007, Jon Loeliger wrote:

> On Mon, 2007-11-12 at 11:33, Johannes Schindelin wrote:
> 
> > Jon wrote:
> >
> > > It [git show-branch] is a very useful command, and usable on systems 
> > > where GUI isn't an option.
> > 
> > Yes, and those systems are the majority nowadays.  Oh, wait...
> 
> I remotely log into my server machines frequently.

Okay, sorry.  I was in a bad mood (you know why, I guess), and I was a 
little tongue-in-cheek here.  I apologise.

The thing is, show-branch might be mighty useful for you, but I agree with 
another poster that its output is not for the faint of heart, if it goes 
without an explanation.

So I vote for keeping relatively quiet about it in the output of "git 
help" which is -- according to some people -- the first thing new git 
users see.

Power users, such as yourself, will read in the user manual or in the FAQ 
about the existence of this nice tool, and do not need to be reminded of 
it by git-help.

Fair enough?
Dscho
