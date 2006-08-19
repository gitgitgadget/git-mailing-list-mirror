From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Added support for dropping privileges to git-daemon.
Date: Sat, 19 Aug 2006 15:32:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608191529300.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1155990772.6591@hammerfest>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 19 15:32:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEQvv-00014V-N1
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 15:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWHSNcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 09:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWHSNcN
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 09:32:13 -0400
Received: from mail.gmx.de ([213.165.64.20]:6091 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751295AbWHSNcM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 09:32:12 -0400
Received: (qmail invoked by alias); 19 Aug 2006 13:32:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 19 Aug 2006 15:32:10 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Tilman Sauerbeck <tilman@code-monkey.de>
In-Reply-To: <1155990772.6591@hammerfest>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25721>

Hi,

On Sat, 19 Aug 2006, Tilman Sauerbeck wrote:

>  What do you think?

I think it is a good addition. Note that most people will probably use 
inetd instead, though.

> +	     [--user=u] [--group=g] [directory...]

Since you enforce both --user and --group, this should read

	 [--user=u --group=g]

Ciao,
Dscho
