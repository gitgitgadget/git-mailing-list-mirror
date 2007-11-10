From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Sat, 10 Nov 2007 16:07:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711101605560.4362@racer.site>
References: <4733AEA6.1040802@lsrfire.ath.cx> <20071109045040.GC31760@sigill.intra.peff.net>
 <4734EA4E.8070405@lsrfire.ath.cx> <20071110004635.GA14992@sigill.intra.peff.net>
 <47359221.7090707@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Nov 10 17:07:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqss7-0006Yc-9b
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 17:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbXKJQHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 11:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbXKJQHY
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 11:07:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:59605 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751844AbXKJQHX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 11:07:23 -0500
Received: (qmail invoked by alias); 10 Nov 2007 16:07:22 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp016) with SMTP; 10 Nov 2007 17:07:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191ecwl4et1ofCtis0yVcXxJ+eQahq6yT1u01o54z
	1/SkNB/MYeEMlz
X-X-Sender: gene099@racer.site
In-Reply-To: <47359221.7090707@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64356>

Hi,

On Sat, 10 Nov 2007, Ren? Scharfe wrote:

> [...] have cooked up a different one on top of a cleaned up version of 
> mine.  It plays the dirty trick of reading expansions of repeated 
> placeholders from the strbuf..

... which would not work (likely even segfault) if you work with the same 
private data on different strbufs.

But I guess it will not matter much in practice.

Ciao,
Dscho
