From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-apply: apply submodule changes
Date: Fri, 10 Aug 2007 13:34:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708101332240.21857@racer.site>
References: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>
To: Sven Verdoolaege <skimo@kotnet.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 14:35:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJTi5-0003Gr-BY
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 14:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761794AbXHJMfR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 08:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761305AbXHJMfQ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 08:35:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:40489 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760297AbXHJMfO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 08:35:14 -0400
Received: (qmail invoked by alias); 10 Aug 2007 12:35:13 -0000
Received: from ppp-82-135-7-57.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.7.57]
  by mail.gmx.net (mp054) with SMTP; 10 Aug 2007 14:35:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gL68NFJZgKwS1Mwcc3gZZQpf2d/7h1jApqnXFAj
	VXDcMjMiDv9Mhi
X-X-Sender: gene099@racer.site
In-Reply-To: <20070810093049.GA868MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55533>

Hi,

On Fri, 10 Aug 2007, Sven Verdoolaege wrote:

> Apply "Subproject commit HEX" changes produced by git-diff.
> As usual in the current git, only the superproject itself is actually
> modified (possibly creating empty directories for new submodules).

For rebase and cherry-pick, it would be nice if git just ignored the 
changes in the submodules, provided that the submodule commit was not 
affected by the to-be-applied patches.

Hmm?

Ciao,
Dscho
