From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git diff about Objective-C syntax
Date: Wed, 17 Sep 2008 12:06:18 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0809171205430.14329@racer>
References: <1221610063-33610-1-git-send-email-jon.delStrother@bestbefore.tv> <1221648564-56239-1-git-send-email-jon.delStrother@bestbefore.tv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, vmiklos@frugalware.org
To: Jonathan del Strother <jon.delStrother@bestbefore.tv>
X-From: git-owner@vger.kernel.org Wed Sep 17 13:09:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfuuQ-0003jt-H7
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 13:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbYIQLGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 07:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754476AbYIQLGT
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 07:06:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:49280 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754419AbYIQLGS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 07:06:18 -0400
Received: (qmail invoked by alias); 17 Sep 2008 11:06:16 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO racer.local) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 17 Sep 2008 13:06:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+pmMUIpzKpMBzzkDtitsHJNo5G2CI154JqJuP5PZ
	Kys5UEEAYXYIl7
X-X-Sender: gene099@racer
In-Reply-To: <1221648564-56239-1-git-send-email-jon.delStrother@bestbefore.tv>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96091>

Hi,

On Wed, 17 Sep 2008, Jonathan del Strother wrote:

> -			"^[ 	]*\\(\\([ 	]*"
> +			"^[ \t]*\\(\\([ \t]*"

Why?

>  			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
> -			"[ 	]*([^;]*\\)$" },
> +			"[ \t]*([^;]*\\)$" },
> +
> +	{ "objc", "![ \t]*\\(do\\|for\\|if\\|else\\|return\\|switch\\|while\\)\n" /* Negate C statements that can look like functions */
> +			"^[ \t]*\\([-+][ \t]*([ \t]*[A-Za-z_][A-Za-z_0-9]*.*).*\\)$" /* Objective-C methods */

I see you still have these awfully long lines.

Ciao,
Dscho
