From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Replace instances of export VAR=VAL with VAR=VAL; export
 VAR
Date: Wed, 28 Nov 2007 14:36:32 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281435470.27959@racer.site>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com> 
 <Pine.LNX.4.64.0711261340470.27959@racer.site>  <97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com>
  <7vir3m94ku.fsf@gitster.siamese.dyndns.org>  <50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com>
  <7v1waa7lcv.fsf@gitster.siamese.dyndns.org>  <1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com>
  <Pine.LNX.4.64.0711281355460.27959@racer.site> 
 <fcaeb9bf0711280619j3479ea6csa74f4b0d907f2a65@mail.gmail.com> 
 <85lk8ia1nw.fsf@lola.goethe.zz> <fcaeb9bf0711280627h1ac216bbr98dc986b82a54423@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:38:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxO36-0002w2-HD
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 15:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761494AbXK1Ogm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 09:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758621AbXK1Ogm
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 09:36:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:50451 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761480AbXK1Ogl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 09:36:41 -0500
Received: (qmail invoked by alias); 28 Nov 2007 14:36:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 28 Nov 2007 15:36:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tebhhguYtfRwr+nc2jFkceoJSokVJQWdY7zEwkR
	9oRxPzDw8ABK6H
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0711280627h1ac216bbr98dc986b82a54423@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66346>



On Wed, 28 Nov 2007, Nguyen Thai Ngoc Duy wrote:

> > how about starting the basic tests by testing for shell features that 
> > are known and accepted to be used in git?
> >
> > That way, we get direct feedback when feature assumptions are 
> > problematic with some shells.
> 
> Uh.. I meant there are "export VAL=VAL" usage in test scripts and they 
> should be fixed as well. Anyway your idea is nice.

I have an even better idea: how about getting rid of all shell scripts, 
making them builtins? ;-)

Ciao,
Dscho
