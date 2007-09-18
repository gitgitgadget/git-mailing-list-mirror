From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Tue, 18 Sep 2007 13:29:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709181319050.28586@racer.site>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com> 
 <11900461843997-git-send-email-hjemli@gmail.com>  <20070918005013.GA6368@muzzle>
  <8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com> 
 <7v4phsxy55.fsf@gitster.siamese.dyndns.org>  <46EF7EA1.6020402@vilain.net>
 <46EF9687.6070304@vilain.net> <8c5c35580709180419i4500a2d4s8a997d45dd31944e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Andreas Ericsson <ae@op5.se>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 14:30:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXcDc-0004z5-28
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 14:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199AbXIRMaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 08:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755933AbXIRMaP
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 08:30:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:51428 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755860AbXIRMaO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 08:30:14 -0400
Received: (qmail invoked by alias); 18 Sep 2007 12:30:11 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 18 Sep 2007 14:30:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cghAEDkUcfuzo+frg9BdIv9brYJtgIZrUVFeoKJ
	m2sVToUW+dkBNk
X-X-Sender: gene099@racer.site
In-Reply-To: <8c5c35580709180419i4500a2d4s8a997d45dd31944e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58594>

Hi,

On Tue, 18 Sep 2007, Lars Hjemli wrote:

> Sidenote: this might be slightly controversial, but I've sometimes 
> missed a --no-ff option to 'git merge' when working on plain git 
> repositories; IMHO preserving the 'logical' merge history when the merge 
> of a topic branch results in a fast-forward can be interesting.

Linus explained a lot of times why this is wrong.  It encourages 
upstream-downstream thinking.  We should really turn this into a FAQ.

Ciao,
Dscho
