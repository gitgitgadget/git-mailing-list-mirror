From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Small cache_tree_write refactor.
Date: Tue, 25 Sep 2007 11:38:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251135530.28395@racer.site>
References: <20070925082341.DF412BDBCF@madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 12:39:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia7pT-0003Ah-66
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 12:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbXIYKjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 06:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbXIYKjW
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 06:39:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:37545 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751822AbXIYKjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 06:39:21 -0400
Received: (qmail invoked by alias); 25 Sep 2007 10:39:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 25 Sep 2007 12:39:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/l2ENiYjLlGK006d40nHm6RX166vdRLp7eR8ftLq
	NaUBbyXr+aJg4E
X-X-Sender: gene099@racer.site
In-Reply-To: <20070925082341.DF412BDBCF@madism.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59111>

Hi,

On Tue, 25 Sep 2007, Pierre Habouzit wrote:

> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -369,10 +369,8 @@ int cache_tree_update(struct cache_tree *it,
>  	return 0;
>  }
>  
> -static void write_one(struct cache_tree *it,
> -		       char *path,
> -		       int pathlen,
> -			   struct strbuf *buffer)
> +static void write_one(struct strbuf *buffer, struct cache_tree *it,
> +                      const char *path, int pathlen)

I don't know... is this really needed?  In some other projects, the coding 
standard prefers the parameters in "in"..."out" order.

Ciao,
Dscho
