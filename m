From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Sun, 6 Apr 2008 22:06:24 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804062204580.12583@eeepc-johanness>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Sun Apr 06 23:07:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jic51-0004Uw-Sj
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 23:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbYDFVG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 17:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753455AbYDFVG2
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 17:06:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:40953 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752934AbYDFVG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 17:06:28 -0400
Received: (qmail invoked by alias); 06 Apr 2008 21:06:26 -0000
Received: from host86-165-92-90.range86-165.btcentralplus.com (EHLO eeepc-johanness.home) [86.165.92.90]
  by mail.gmx.net (mp022) with SMTP; 06 Apr 2008 23:06:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VoNIJ2VDViA+Fa8kAStRLrs+ZcE4+GOuys94071
	j2Td6wyZ3J8cST
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78929>

Hi,

On Sun, 6 Apr 2008, Adam Simpkins wrote:

> diff --git a/graph.h b/graph.h
> new file mode 100644
> index 0000000..fc23bf2
> --- /dev/null
> +++ b/graph.h
> @@ -0,0 +1,57 @@
> +#ifndef GRAPH_H
> +#define GRAPH_H
> +
> +/* A graph is a pointer to this opaque structure */
> +struct git_graph;
> +
> +/* Defined in commit.h */
> +struct commit;
> +/* Defined in strbuf.h */
> +struct strbuf;

You do not need those.

Apart from that, it looks very, very clean to me.  (Except maybe the 
prefix ++ that could have been a postfix ++ in the line before, but that 
is just me.)

Ciao,
Dscho
