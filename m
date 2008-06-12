From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git bugs
Date: Thu, 12 Jun 2008 08:12:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806120811440.1783@racer>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com> <20080612031723.GJ11793@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ben Lynn <benlynn@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 09:14:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6h11-0006Va-L4
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 09:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbYFLHNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 03:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbYFLHNm
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 03:13:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:32882 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752638AbYFLHNl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 03:13:41 -0400
Received: (qmail invoked by alias); 12 Jun 2008 07:13:39 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 12 Jun 2008 09:13:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DAiUdHosDih4L5TAf5n0OiURJx0cywYErOcuxiR
	n+YA/JDXUpt5U3
X-X-Sender: gene099@racer
In-Reply-To: <20080612031723.GJ11793@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84728>

Hi,

On Wed, 11 Jun 2008, Shawn O. Pearce wrote:

> diff --git a/builtin-fast-export.c b/builtin-fast-export.c
> index 1dfc01e..d0a462f 100644
> --- a/builtin-fast-export.c
> +++ b/builtin-fast-export.c
> @@ -188,6 +188,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
>  	mark_object(&commit->object);
>  	if (!is_encoding_utf8(encoding))
>  		reencoded = reencode_string(message, "UTF-8", encoding);
> +	if (!commit->parents)
> +		printf("reset %s\n", (const char*)commit->util);
>  	printf("commit %s\nmark :%d\n%.*s\n%.*s\ndata %u\n%s",
>  	       (const char *)commit->util, last_idnum,
>  	       (int)(author_end - author), author,

Deemed-obviously-correct-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ciao,
Dscho
