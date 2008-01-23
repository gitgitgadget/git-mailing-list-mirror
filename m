From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Wed, 23 Jan 2008 11:12:36 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801231111310.5731@racer.site>
References: <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
 <47908CAF.90101@viscovery.net> <alpine.LSU.1.00.0801181948060.5731@racer.site> <alpine.LSU.1.00.0801182055340.5731@racer.site> <20080121044632.GH24004@spearce.org> <alpine.LSU.1.00.0801211034040.5731@racer.site> <20080123044428.GK24004@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: paulus@samba.org, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 12:13:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHdXh-0000UU-Gp
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 12:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbYAWLMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 06:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbYAWLMq
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 06:12:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:37024 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752050AbYAWLMo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 06:12:44 -0500
Received: (qmail invoked by alias); 23 Jan 2008 11:12:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp044) with SMTP; 23 Jan 2008 12:12:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+7fg1/kXK7cse8dHskiJxjUEa5u8n2I3XxhcQYIq
	Z1HyzXZLpx/6eL
X-X-Sender: gene099@racer.site
In-Reply-To: <20080123044428.GK24004@spearce.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71531>

Hi,

On Tue, 22 Jan 2008, Shawn O. Pearce wrote:

> diff --git a/Makefile b/Makefile
> index 1baf4b0..5f1023e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -198,6 +198,9 @@ ifdef NO_MSGFMT
>  	MSGFMT ?= $(TCL_PATH) po/po2msg.sh
>  else
>  	MSGFMT ?= msgfmt
> +	ifeq ($(shell $(MSGFMT) >/dev/null 2>&1 || echo $$?),127)
> +		MSGFMT := $(TCL_PATH) po/po2msg.sh
> +	endif
>  endif
>  
>  msgsdir     = $(gg_libdir)/msgs
> 

Thanks!

Paul, you might want to do something like that for gitk, too.  I imagine 
that the diff even applies as-is...

Ciao,
Dscho
