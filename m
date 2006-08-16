From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remove unused pager_in_use
Date: Wed, 16 Aug 2006 02:09:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608160206510.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608151348310.2687@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 02:09:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD8y8-0000OA-CQ
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 02:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWHPAJH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 20:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWHPAJG
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 20:09:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:10154 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750713AbWHPAJF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 20:09:05 -0400
Received: (qmail invoked by alias); 16 Aug 2006 00:09:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 16 Aug 2006 02:09:03 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: David Rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608151348310.2687@chino.corp.google.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25492>

Hi,

On Tue, 15 Aug 2006, David Rientjes wrote:

> There's no need to honor pager_in_use because it's unused.
>
> [...]
>
> -			if (isatty(1) || (pager_in_use && pager_use_color)) {
> +			if (isatty(1) || pager_use_color) {

Well, it _was_ in use, before you removed it.

Ciao,
Dscho
