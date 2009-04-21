From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] graph API: Use horizontal lines for more compact
 graphs
Date: Tue, 21 Apr 2009 02:56:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904210255280.10279@pacific.mpi-cbg.de>
References: <20090421004027.GA12330@linux.vnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 02:56:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4Hj-0005Eo-SR
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 02:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbZDUAyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 20:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754394AbZDUAyy
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 20:54:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:43572 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754217AbZDUAyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 20:54:54 -0400
Received: (qmail invoked by alias); 21 Apr 2009 00:54:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp027) with SMTP; 21 Apr 2009 02:54:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18yUG4N66UybF3sW1dDqJmumbKQSwlxqCurz9amIy
	f2B19nB0CIng7t
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090421004027.GA12330@linux.vnet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117059>

Hi,

On Mon, 20 Apr 2009, Allan Caffee wrote:

> diff --git a/graph.c b/graph.c
> index d4571cf..597e545 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -47,20 +47,6 @@ static void graph_show_strbuf(struct git_graph *graph, struct strbuf const *sb);
>   * - Limit the number of columns, similar to the way gitk does.
>   *   If we reach more than a specified number of columns, omit
>   *   sections of some columns.
> - *
> - * - The output during the GRAPH_PRE_COMMIT and GRAPH_COLLAPSING states
> - *   could be made more compact by printing horizontal lines, instead of
> - *   long diagonal lines.  For example, during collapsing, something like
> - *   this:          instead of this:
> - *   | | | | |      | | | | |
> - *   | |_|_|/       | | | |/
> - *   |/| | |        | | |/|
> - *   | | | |        | |/| |
> - *                  |/| | |
> - *                  | | | |
> - *
> - *   If there are several parallel diagonal lines, they will need to be
> - *   replaced with horizontal lines on subsequent rows.

I like it!

> +				for (j = (target * 2)+3; j < (i - 2); j += 2)

This (target*2)+3 is a bit too magical for me to understand.  But maybe I 
am just too tired?

Ciao,
Dscho
