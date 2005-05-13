From: Edgar Toernig <froese@gmx.de>
Subject: Re: [PATCH 3/4] Pull refs by HTTP
Date: Fri, 13 May 2005 13:15:31 +0200
Message-ID: <20050513131531.4317677b.froese@gmx.de>
References: <Pine.LNX.4.21.0505130245260.30848-100000@iabervon.org>
	<Pine.LNX.4.21.0505130256150.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 13 13:08:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWY1Y-0001uC-6p
	for gcvg-git@gmane.org; Fri, 13 May 2005 13:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVEMLPj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 07:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbVEMLPj
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 07:15:39 -0400
Received: from imap.gmx.net ([213.165.64.20]:49838 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262317AbVEMLPf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 07:15:35 -0400
Received: (qmail invoked by alias); 13 May 2005 11:15:34 -0000
Received: from p50907369.dip.t-dialin.net (EHLO dialup) [80.144.115.105]
  by mail.gmx.net (mp002) with SMTP; 13 May 2005 13:15:34 +0200
X-Authenticated: #271361
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505130256150.30848-100000@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow wrote:
>
> +	url = xmalloc(strlen(base) + 7 + strlen(dir) + strlen(name));
> +	strcpy(url, base);
> +	posn = url + strlen(base);
> +	strcpy(posn, "refs/");
> +	posn += 5;
> +	strcpy(posn, dir);
> +	posn += strlen(dir);
> +	*(posn++) = '/';
> +	strcpy(posn, name);

Have you ever heard of sprintf & co?

	sprintf(url, "%srefs/%s/%s", base, dir, name);

Ciao, ET.
