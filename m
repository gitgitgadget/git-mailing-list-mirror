From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix interactive rebase to preserve author email address
Date: Wed, 19 Dec 2007 22:11:01 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712192209350.23902@racer.site>
References: <1197997575-13292-1-git-send-email-hskinnemoen@atmel.com>
 <1197997575-13292-2-git-send-email-hskinnemoen@atmel.com>
 <1197997575-13292-3-git-send-email-hskinnemoen@atmel.com>
 <1197997575-13292-4-git-send-email-hskinnemoen@atmel.com>
 <1197997575-13292-5-git-send-email-hskinnemoen@atmel.com>
 <20071218181019.2af46418@dhcp-252-066.norway.atmel.com>
 <alpine.LFD.0.9999.0712181318300.27475@localhost.localdomain>
 <20071219124008.4945e592@dhcp-252-066.norway.atmel.com>
 <20071219150734.50b1f847@dhcp-252-066.norway.atmel.com>
 <BAYC1-PASMTP13613FE244FF93DC2BF613AE5C0@CEZ.ICE> <20071219220223.7c5b3887@siona>
 <BAYC1-PASMTP022BE21217030117EF2156AE5C0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:11:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J578f-0007Hs-Uw
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 23:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbXLSWLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 17:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752891AbXLSWLT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 17:11:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:51676 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752845AbXLSWLS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 17:11:18 -0500
Received: (qmail invoked by alias); 19 Dec 2007 22:11:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 19 Dec 2007 23:11:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+GLA5Rs92GbOWgbb+7V9SuYshANPmvOKEOuYU+gx
	I7f5z1+cbz+c+N
X-X-Sender: gene099@racer.site
In-Reply-To: <BAYC1-PASMTP022BE21217030117EF2156AE5C0@CEZ.ICE>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68942>

Hi,

On Wed, 19 Dec 2007, Sean wrote:

> -		export GIT_AUTHOR_NAME GIT_AUTHOR_NAME GIT_AUTHOR_DATE &&
> +		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&

Ouch.  My mistake (from July 8).

ACK.

Thanks,
Dscho
