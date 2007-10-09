From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-config: respect other options after -l, most notably
 --file
Date: Tue, 9 Oct 2007 14:15:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710091414590.4174@racer.site>
References: <20071009125024.1259.qmail@d8e601127fe8d0.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 15:17:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEwi-0000F0-A6
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 15:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbXJINQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 09:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbXJINQJ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 09:16:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:50423 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750739AbXJINQI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 09:16:08 -0400
Received: (qmail invoked by alias); 09 Oct 2007 13:16:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 09 Oct 2007 15:16:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX183yScabSo3YRC4UvnuRGzHwTZP6S+E0jmhqbMC04
	FDSUlhpEiiMevp
X-X-Sender: gene099@racer.site
In-Reply-To: <20071009125024.1259.qmail@d8e601127fe8d0.315fe32.mid.smarden.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60408>

Hi,

On Tue, 9 Oct 2007, Gerrit Pape wrote:

> @@ -234,6 +235,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		argv++;
>  	}
>  
> +	if (show_all)
> +		return git_config(show_all_config);
>  	switch (argc) {
>  	case 2:
>  		return get_value(argv[1], NULL);

Shouldn't this somehow check if argc == 1 when show_all is set, and die 
otherwise?

Ciao,
Dscho
