From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] strbuf: add strbuf_percentquote_buf
Date: Tue, 12 Jan 2010 17:19:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001121718210.4985@pacific.mpi-cbg.de>
References: <20100112153656.GA24840@coredump.intra.peff.net> <20100112154153.GB24957@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Adam Megacz <adam@megacz.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 12 17:14:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUjNZ-0006Ot-2k
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 17:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114Ab0ALQNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 11:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895Ab0ALQNw
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 11:13:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:48233 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754137Ab0ALQNv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 11:13:51 -0500
Received: (qmail invoked by alias); 12 Jan 2010 16:13:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 12 Jan 2010 17:13:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19LYD17yydLKOUW/E8Z8UsMRs0Pk3XaAP96f5wi/R
	RXeOMckgieafMp
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100112154153.GB24957@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136732>

Hi,

On Tue, 12 Jan 2010, Jeff King wrote:

> This is handy for creating strings which will be fed to
> strbuf_expand or printf.

For printf(), there is always %s%s, so I would not say your patch is 
useful there, but rather adds churn: first you add a percent, then you 
strip it away again.

Ciao,
Dscho
