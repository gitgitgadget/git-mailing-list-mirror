From: Rocco Rutte <pdmef@gmx.net>
Subject: Re: hg2git error
Date: Mon, 25 May 2009 13:34:18 +0200
Message-ID: <20090525113418.GA3259@robert>
References: <alpine.DEB.1.00.0905241932301.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 25 13:34:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8YRu-0000h4-N2
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 13:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbZEYLe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 07:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbZEYLeZ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 07:34:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:36487 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751092AbZEYLeY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 07:34:24 -0400
Received: (qmail invoked by alias); 25 May 2009 11:34:24 -0000
Received: from dslb-094-222-114-239.pools.arcor-ip.net (EHLO robert) [94.222.114.239]
  by mail.gmx.net (mp053) with SMTP; 25 May 2009 13:34:24 +0200
X-Authenticated: #1642131
X-Provags-ID: V01U2FsdGVkX1+pWJ5nHz+pHCYNSbDEAA070OgccQEjtWB103c+wb
	2gO4kEBDS8KIus
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0905241932301.26154@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.19 (2009-05-15)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119923>

Hi,

* Johannes Schindelin wrote:

> Error: repository has at least one unnamed head: hg r533

I'm afraid there's nothing you can do except a) wait until somebody with
push access to the repo merges or b) do that yourself. The error means
that on a branch there's more than one head (i.e. childless
revision). There's no equivalent concept in git which is why I don't
know what to do. Generating fake branch names for git may be a little
messy I think.

Rocco
