From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH amend] git-config: handle --file option with relative
 pathname properly
Date: Fri, 12 Oct 2007 13:08:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710121308040.25221@racer.site>
References: <20071009124932.1184.qmail@395d4a80f3eafd.315fe32.mid.smarden.org>
 <470B8024.2050106@viscovery.net> <20071012113251.29941.qmail@7584201f340355.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Oct 12 14:10:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgJL5-0004wK-2u
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 14:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbXJLMJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 08:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbXJLMJT
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 08:09:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:44607 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751920AbXJLMJS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 08:09:18 -0400
Received: (qmail invoked by alias); 12 Oct 2007 12:09:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 12 Oct 2007 14:09:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ACdUEcNoAfWzB20Q9rL52GxQdDn2uAyH1AnV12g
	5Ls4qZhB4HqygL
X-X-Sender: gene099@racer.site
In-Reply-To: <20071012113251.29941.qmail@7584201f340355.315fe32.mid.smarden.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60683>

Hi,

On Fri, 12 Oct 2007, Gerrit Pape wrote:

> -	setup_git_directory_gently(&nongit);
> +	const char *file = setup_git_directory_gently(&nongit);

One last nit (because I did not see it earlier): please call the variable 
"prefix", not "file".

Other than that, I think your patch is obviously correct.

Thanks,
Dscho
