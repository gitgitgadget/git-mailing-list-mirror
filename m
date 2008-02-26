From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Correct fast-export file mode strings to match fast-import
 standard
Date: Tue, 26 Feb 2008 00:54:39 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0802260054000.3322@eeepc-johanness>
References: <20080225035728.GA26302@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ian Clatworthy <ian.clatworthy@internode.on.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 01:55:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTo6L-0007DV-Ib
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 01:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbYBZAyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 19:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbYBZAyq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 19:54:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:53386 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751152AbYBZAyp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 19:54:45 -0500
Received: (qmail invoked by alias); 26 Feb 2008 00:54:43 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO eeepc-johanness.home) [86.138.198.40]
  by mail.gmx.net (mp015) with SMTP; 26 Feb 2008 01:54:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hFGU6jlWh4PFUGgYNrXp8BGgKCCi6KW0hjrj3SE
	VfXNwBWvYHOePm
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080225035728.GA26302@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75097>

Hi,

On Sun, 24 Feb 2008, Shawn O. Pearce wrote:

> The fast-import file format does not expect leading '0' in front
> of a file mode; that is we want '100644' and '0100644'.

s/and/& not/

> -			printf("M 0%06o :%d %s\n", spec->mode,
> +			printf("M %06o :%d %s\n", spec->mode,

Definitely embarassing.

Thanks,
Dscho
