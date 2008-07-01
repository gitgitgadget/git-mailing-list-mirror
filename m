From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach "git apply" to prepend a prefix with
 "--root=<root>"
Date: Tue, 1 Jul 2008 18:36:06 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807011835090.32725@wbgn129.biozentrum.uni-wuerzburg.de>
References: <alpine.DEB.1.00.0807010043440.9925@racer> <7vvdzqnemk.fsf@gitster.siamese.dyndns.org> <486A55B0.9050404@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 18:37:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDiqq-0001Am-8V
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 18:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbYGAQgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 12:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbYGAQgK
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 12:36:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:32794 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751181AbYGAQgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 12:36:09 -0400
Received: (qmail invoked by alias); 01 Jul 2008 16:36:08 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp017) with SMTP; 01 Jul 2008 18:36:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+WZ9FWNwOWW48/yY73VLbvldTY0MtQ+Q78sbgUJo
	qBihu3eubohVm/
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <486A55B0.9050404@zytor.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87050>

Hi,

On Tue, 1 Jul 2008, H. Peter Anvin wrote:

> Junio C Hamano wrote:
> > 
> > The -p<num> came from patch where it is also called --strip=num.  
> > This new option --root is about the reverse operation and it is about 
> > inserting at the beginning --- it is rerooting, in other words, but 
> > then --root is good enough and shorter.  mkisofs uses the word "graft" 
> > when it allows tree shifting (enabled with --graft-points), but the 
> > word "graft" means a totally different thing to us, so we would not 
> > want to use that word.
> > 
> > I am not complaining (--root is fine by me), but just thinking aloud, 
> > hoping somebody's brainwave is provoked while reading this babbling 
> > and comes up with a better wording ;-).
> > 
> 
> There is an analogous concept in patch(1), it's just implemented by 
> cd'ing to a subdirectory first.  ;)

Hey, "--cd=" is free!  And it would make explaining easier why -p is 
applied first.

Ciao,
Dscho
