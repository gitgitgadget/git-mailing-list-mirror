From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 12/13] Build in merge
Date: Fri, 27 Jun 2008 12:56:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806271255240.9925@racer>
References: <cover.1214066798.git.vmiklos@frugalware.org> <0b7ea424b3d5ea18a5a8660c6aead51adcc6a40f.1214066799.git.vmiklos@frugalware.org> <57d8a308fae0012174ed4388baccf1bde8515f2f.1214066799.git.vmiklos@frugalware.org>
 <5cae08d3bf2852a8bbd8dc8cdf741cb4bdfa237e.1214066799.git.vmiklos@frugalware.org> <d5d80c5a068c76810edfa9c0c68de500f02780a0.1214066799.git.vmiklos@frugalware.org> <486270D5.5050204@free.fr> <20080627010609.GJ29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Olivier Marin <dkr+ml.git@free.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 13:59:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCCbm-0006OC-EH
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 13:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbYF0L6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 07:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756628AbYF0L6F
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 07:58:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:57008 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756350AbYF0L6D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 07:58:03 -0400
Received: (qmail invoked by alias); 27 Jun 2008 11:58:00 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp017) with SMTP; 27 Jun 2008 13:58:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2iSlMRy72Rdo4E2yC6hPcvNDVwidrxOi7dSKY35
	FkC3cOKNUG7zfk
X-X-Sender: gene099@racer
In-Reply-To: <20080627010609.GJ29404@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86540>

Hi,

On Fri, 27 Jun 2008, Miklos Vajna wrote:

> diff --git a/builtin-merge.c b/builtin-merge.c
> index cc04d01..77de9e8 100644
> --- a/builtin-merge.c
> +++ b/builtin-merge.c
> @@ -836,9 +836,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		/* Again the most common case of merging one remote. */
>  		struct strbuf msg;
>  		struct object *o;
> +		char hex[41];
> +
> +		memcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV), 41);

Maybe strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV)) would be more 
intuitive?

Ciao,
Dscho
