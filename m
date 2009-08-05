From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3 v3] Use an external program to implement fetching
 with curl
Date: Wed, 5 Aug 2009 12:05:09 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908051203550.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0907310112400.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 12:04:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYdMY-0008Uw-KC
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 12:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934131AbZHEKEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 06:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934108AbZHEKEq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 06:04:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:44280 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933243AbZHEKEp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 06:04:45 -0400
Received: (qmail invoked by alias); 05 Aug 2009 10:04:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 05 Aug 2009 12:04:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18iq5cQAAwif8Acn8p0ak54bw9m0Yskdnjsc+WUE/
	3ODYX+cJynDN4s
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0907310112400.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124894>

Hi,

On Fri, 31 Jul 2009, Daniel Barkalow wrote:

> Use the transport native helper mechanism to fetch by http (and ftp, etc).
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> Note that the bulk of remote-curl is code moved verbatim from transport.c; 
> cleaning it up is a separate topic.
> 
>  Makefile      |    5 ++
>  remote-curl.c |  139 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  transport.c   |  136 +-------------------------------------------------------
>  3 files changed, 145 insertions(+), 135 deletions(-)
>  create mode 100644 remote-curl.c

I wanted to suggest using the -C option so that the patch would consist of 
mostly deleted lines (easier to verify then that it was a code move), but 
transport.c is over 1000 lines, so that would not have worked!

So I do like the patch, and you're obviously correct about the clean up.

Ciao,
Dscho
