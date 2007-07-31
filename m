From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] Fix allocation of "int*" instead of "int".
Date: Tue, 31 Jul 2007 15:56:16 -0400
Message-ID: <20070731195616.GA6329@sigill.intra.peff.net>
References: <20070731144829.ea83d43d.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 21:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFxpN-0002UQ-Ql
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 21:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbXGaT4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 15:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754606AbXGaT4S
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 15:56:18 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3867 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbXGaT4R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 15:56:17 -0400
Received: (qmail 5352 invoked from network); 31 Jul 2007 19:56:19 -0000
Received: from unknown (HELO sigill.intra.peff.net) (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 31 Jul 2007 19:56:19 -0000
Received: (qmail 6424 invoked by uid 1000); 31 Jul 2007 19:56:16 -0000
Content-Disposition: inline
In-Reply-To: <20070731144829.ea83d43d.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54370>

On Tue, Jul 31, 2007 at 02:48:29PM +0200, Christian Couder wrote:

> -	weights = xcalloc(on_list, sizeof(int*));
> +	weights = xcalloc(on_list, sizeof(int));

How about the correct-by-definition sizeof(*weights)?

-Peff
