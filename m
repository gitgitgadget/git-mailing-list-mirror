From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v1 1/3] Introduce config variable "diff.primer"
Date: Sun, 25 Jan 2009 19:17:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901251916010.14855@racer>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Keith Cascio <keith@cs.ucla.edu>
X-From: git-owner@vger.kernel.org Sun Jan 25 19:20:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR9bD-0005k6-7j
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 19:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbZAYSRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 13:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbZAYSRX
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 13:17:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:36138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750705AbZAYSRX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 13:17:23 -0500
Received: (qmail invoked by alias); 25 Jan 2009 18:17:19 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp018) with SMTP; 25 Jan 2009 19:17:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19teNJQmsNt/OABF7Pk7LbVTSKgCRgcJjRPetHMiB
	9uAV8jsb1PFieR
X-X-Sender: gene099@racer
In-Reply-To: <1232904657-31831-2-git-send-email-keith@cs.ucla.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107074>

Hi,

On Sun, 25 Jan 2009, Keith Cascio wrote:

> Introduce config variable "diff.primer".
> Allows user to specify arbitrary options
> to pass to diff on every invocation,
> including internal invocations from other
> programs, e.g. git-gui.

That would break existing scripts using "git diff" rather badly.  We 
already did not allow something like "git config alias.diff ..." from 
changing the behavior of "git diff", so I cannot find a reason why we 
should let diff.primer (a misnomer BTW) override the behavior.

Ciao,
Dscho
