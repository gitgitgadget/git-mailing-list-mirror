From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] Eradicate yet-another-buffer implementation in
 buitin-rerere.c
Date: Thu, 6 Sep 2007 15:05:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709061504521.28586@racer.site>
References: <20070902224213.GB431@artemis.corp> <11890776114037-git-send-email-madcoder@debian.org>
 <118907761140-git-send-email-madcoder@debian.org>
 <11890776111843-git-send-email-madcoder@debian.org>
 <11890776112292-git-send-email-madcoder@debian.org>
 <11890776111670-git-send-email-madcoder@debian.org>
 <11890776112309-git-send-email-madcoder@debian.org>
 <11890776112641-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 16:06:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITHza-0003uM-1h
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 16:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbXIFOFw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 10:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbXIFOFw
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 10:05:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:38045 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751321AbXIFOFv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 10:05:51 -0400
Received: (qmail invoked by alias); 06 Sep 2007 14:05:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 06 Sep 2007 16:05:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196LZJCtTh6zeTS8xuUT70atVb/3ixaiSIQVxg0Wc
	VEmexeI3kMnlbe
X-X-Sender: gene099@racer.site
In-Reply-To: <11890776112641-git-send-email-madcoder@debian.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57879>

Hi,

On Thu, 6 Sep 2007, Pierre Habouzit wrote:

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  builtin-rerere.c |   56 +++++++++++++++++------------------------------------
>  1 files changed, 18 insertions(+), 38 deletions(-)

I like that one very much, but ...

>  	FILE *f = fopen(path, "r");
>  	FILE *out;
>  
> +        strbuf_init(&minus);
> +        strbuf_init(&plus);
> +

You used spaces instead of tabs here.

Ciao,
Dscho
