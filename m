From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: [PATCH] Teach the --cover-letter option to format-patch
Date: Tue, 24 Jul 2007 22:12:27 +0200
Message-ID: <200707242212.27837.kumbayo84@arcor.de>
References: <Pine.LNX.4.64.0707100126250.6977@iabervon.org> <Pine.LNX.4.64.0707101300450.6977@iabervon.org> <Pine.LNX.4.64.0707101819350.4047@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 22:14:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDQle-0004QL-Q2
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 22:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbXGXUNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 16:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754541AbXGXUNo
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 16:13:44 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:50450 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751807AbXGXUNm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 16:13:42 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id C636D27ACBE;
	Tue, 24 Jul 2007 22:13:41 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id B53445BD63;
	Tue, 24 Jul 2007 22:13:41 +0200 (CEST)
Received: from fnoheim223.netpark.at (fnoheim223.netpark.at [83.68.151.223])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id DCB401F7046;
	Tue, 24 Jul 2007 22:13:40 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0707101819350.4047@racer.site>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.91.1/3754/Tue Jul 24 15:41:21 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53637>

On Tuesday 10 July 2007 19:20, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 10 Jul 2007, Daniel Barkalow wrote:
> 
> > I think this is missing the ultra-important "extra_headers" stuff, which 
> > is what makes my messages actually reach the right people. That's why 
> > I'd like the code shared for generating headers (except for Subject) for 
> > a rev_info between the code that does it for patch messages and the code 
> > for the cover letter. I think it's also missing making [PATCH 1/N] a 
> > reply to it if the series is set up as replies.
> 
> Ah yes. Both issues should be relatively easy to integrate into my patch.
> 
> > I like the design, in any case. I want the blurb actually stored in the 
> > objects directory somehow, so that I don't have to trawl through my sent 
> > email for it when I send the series again for some reason, but that's a 
> > relatively straightforward extension to your code. (Read an object with 
> > a hash and stick the text in instead of the ***...*** parts.)
> 
> I do not understand. But then, my patch should be a good starting point. 
> Go wild.
> 
> Ciao,
> Dscho
Anybody working on this?
Somebody, *cough* convinced me into working on this.
I already split up the existing patch into logic parts, and will now try to read message / header
from file or a commit.

Greetings Peter
