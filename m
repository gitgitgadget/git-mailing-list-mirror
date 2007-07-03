From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Add core.pager config variable.
Date: Tue, 3 Jul 2007 21:42:06 +0200
Message-ID: <200707032142.07154.robin.rosenberg.lists@dewire.com>
References: <20070703181811.GA17966@Hermes.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 21:41:16 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5oFQ-00059D-Hr
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 21:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756197AbXGCTlL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 15:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756020AbXGCTlK
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 15:41:10 -0400
Received: from [83.140.172.130] ([83.140.172.130]:29904 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755805AbXGCTlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 15:41:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 289D58026CF;
	Tue,  3 Jul 2007 21:34:12 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28020-01; Tue,  3 Jul 2007 21:34:11 +0200 (CEST)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id C4DD1800199;
	Tue,  3 Jul 2007 21:34:11 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070703181811.GA17966@Hermes.local>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51527>

tisdag 03 juli 2007 skrev Brian Gernhardt:
> This adds a configuration variable that performs the same function as,
> but is overridden by, GIT_PAGER.
[...]
> diff --git a/pager.c b/pager.c
> index 5f280ab..3bfed02 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -32,6 +32,8 @@ void setup_pager(void)
>  	if (!isatty(1))
>  		return;
>  	if (!pager)
> +		pager = pager_program;
> +	if (!pager)
>  		pager = getenv("PAGER");
>  	if (!pager)
>  		pager = "less";

Nak.

PAGER cannot override core.pager with this.

-- robin
