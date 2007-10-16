From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix compilation when NO_CURL is defined
Date: Tue, 16 Oct 2007 01:05:03 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710160104120.25221@racer.site>
References: <20071015234830.GA9694@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 02:22:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhZwY-0006qs-U6
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 02:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763837AbXJPAFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 20:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763843AbXJPAFN
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 20:05:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:40544 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763837AbXJPAFL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 20:05:11 -0400
Received: (qmail invoked by alias); 16 Oct 2007 00:05:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 16 Oct 2007 02:05:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18w6ioZWDkwMidn12FiShZWT+s5io6NEL/GEBtHfJ
	q0uGEYIJz7TOnl
X-X-Sender: gene099@racer.site
In-Reply-To: <20071015234830.GA9694@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61055>

Hi,

On Mon, 15 Oct 2007, Shawn O. Pearce wrote:

> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Hehe, hardly ;-)

> There were a few places which did not cope well without curl.  This
> fixes all of them.  We still need to link against the walker.o part
> of the library as some parts of transport.o still call into there
> even though we don't have HTTP support enabled.
> 
> If compiled with NO_CURL=1 we now get the following useful error
> message:
> 
>   $ git-fetch http://www.example.com/git
>   error: git was compiled without libcurl support.
>   fatal: Don't know how to fetch from http://www.example.com/git
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
> 
>  I think this is a better version of Dscho's original attempt at
>  making NO_CURL=YesPlease actually work again with the builtin
>  fetch series.
> 
>  Makefile    |    6 +++---
>  transport.c |   23 +++++++----------------
>  2 files changed, 10 insertions(+), 19 deletions(-)

Nice!

I like it.

Ciao,
Dscho
