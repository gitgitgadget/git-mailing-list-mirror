From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Sat, 10 Nov 2007 00:31:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711100030090.4362@racer.site>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045040.GC31760@sigill.intra.peff.net>
 <4734EA4E.8070405@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Nov 10 01:32:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqeGf-0003sa-BQ
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 01:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbXKJAby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 19:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbXKJAby
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 19:31:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:50810 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751892AbXKJAbx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 19:31:53 -0500
Received: (qmail invoked by alias); 10 Nov 2007 00:31:51 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp002) with SMTP; 10 Nov 2007 01:31:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18e4OFlgrEecLcBrKgOl4BuJUDBpA97wgr09utjjR
	/zLEw4rRVCX0/t
X-X-Sender: gene099@racer.site
In-Reply-To: <4734EA4E.8070405@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64286>

Hi,

On Sat, 10 Nov 2007, Ren? Scharfe wrote:

> (next)
> $ time git log --pretty=format:"* %cd %cn%n%n%s%n%b" >/dev/null
> 
> real    0m0.631s
> user    0m0.584s
> sys     0m0.040s
> 
> (next+patch)
> $ time git log --pretty=format:"* %cd %cn%n%n%s%n%b" >/dev/null
> 
> real    0m0.570s
> user    0m0.512s
> sys     0m0.044s

Wow.

If you keep going like that, "git log" will be slower than "git log 
--pretty=format:bla" soon.

Ciao,
Dscho
