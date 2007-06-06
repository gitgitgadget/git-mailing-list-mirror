From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: also don't fail in map() if a commit
 cannot be mapped
Date: Wed, 6 Jun 2007 18:50:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706061850220.4046@racer.site>
References: <Pine.LNX.4.64.0706051537360.4046@racer.site>
 <1181144191777-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Jun 06 19:52:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvzgm-0003Kq-HF
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 19:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbXFFRwr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 13:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbXFFRwr
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 13:52:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:60912 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751272AbXFFRwq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 13:52:46 -0400
Received: (qmail invoked by alias); 06 Jun 2007 17:52:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 06 Jun 2007 19:52:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18K3n19O0gKYoCjzKJSKPVUnVmhZOETXimvIXu0xw
	FSGFDI4eT8V6mv
X-X-Sender: gene099@racer.site
In-Reply-To: <1181144191777-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49298>

Hi,

On Wed, 6 Jun 2007, Johannes Sixt wrote:

> -	[ -r "$workdir/../map/$1" ] || return 1
> +	# if it was not rewritten, take the original
> +	[ -r "$workdir/../map/$1" ] || echo "$1"

Maybe "test" instead of "["? Otherwise, ACK from me.

Ciao,
Dscho
