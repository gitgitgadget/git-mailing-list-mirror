From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/25] parse-options: make some arguments optional, add
 callbacks.
Date: Tue, 16 Oct 2007 14:18:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161417440.25221@racer.site>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org>
 <1192523998-19474-1-git-send-email-madcoder@debian.org>
 <1192523998-19474-2-git-send-email-madcoder@debian.org>
 <1192523998-19474-3-git-send-email-madcoder@debian.org>
 <1192523998-19474-4-git-send-email-madcoder@debian.org>
 <1192523998-19474-5-git-send-email-madcoder@debian.org>
 <1192523998-19474-6-git-send-email-madcoder@debian.org>
 <1192523998-19474-7-git-send-email-madcoder@debian.org> <20071016084510.GI6919@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 15:18:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhmJd-0004tm-5T
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 15:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbXJPNSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 09:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbXJPNSX
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 09:18:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:56021 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932307AbXJPNSW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 09:18:22 -0400
Received: (qmail invoked by alias); 16 Oct 2007 13:18:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 16 Oct 2007 15:18:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+CrW4/YAqCgS390PubNNErw/YIuVzlxzCLqf8MCd
	77LGWhXSxt9aPf
X-X-Sender: gene099@racer.site
In-Reply-To: <20071016084510.GI6919@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61168>

Hi,

On Tue, 16 Oct 2007, Pierre Habouzit wrote:

> This bit is to allow to aggregate options with arguments together when
> the argument is numeric.
> 
>     +#if 0
>     +		/* can be used to understand -A1B1 like -A1 -B1 */
>     +		if (flag & OPT_SHORT && opt->opt && isdigit(*opt->opt)) {
>     +			*(int *)opt->value = strtol(opt->opt, (char **)&opt->opt, 10);
>     +			return 0;
>     +		}
>     +#endif
> 
> I'm not a huge fan, but people may like it. Feel free to keep the
> chunk, drop it, or enable it to your liking.

FWIW I like it.  It allows me to aggregate options such as -M30 with other 
short options.

Ciao,
Dscho
