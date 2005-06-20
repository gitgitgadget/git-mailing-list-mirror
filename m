From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list: "--bisect" flag
Date: Mon, 20 Jun 2005 13:30:57 +1000
Message-ID: <2cfc40320506192030290187af@mail.gmail.com>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org>
	 <2cfc403205061817181e4d6d5e@mail.gmail.com>
	 <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org>
	 <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org>
	 <2cfc403205061903155a6090db@mail.gmail.com>
	 <2cfc40320506190741409f3a5@mail.gmail.com>
	 <Pine.LNX.4.58.0506190951330.2268@ppc970.osdl.org>
	 <2cfc4032050619125537dee354@mail.gmail.com>
	 <Pine.LNX.4.58.0506192002240.2268@ppc970.osdl.org>
	 <2cfc403205061920272ee47166@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 05:25:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkCuQ-0004eB-I6
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 05:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVFTDbA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 23:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVFTDbA
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 23:31:00 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:55169 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261193AbVFTDa5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 23:30:57 -0400
Received: by rproxy.gmail.com with SMTP id i8so553692rne
        for <git@vger.kernel.org>; Sun, 19 Jun 2005 20:30:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QDALoxggbU2EPrtfFip3ih0+C7wIMDMgl0h+YThIPirXpomzGYzY45o+rlyHlTGzDOmHhFLN2l1JmpgSowGEUCyrlFNSv5UK4uQBEJXVrXNNEPhOACOYkB7t8iwceQlVj7Eh8RNmaT59jnwT5WsPEDRw3CXiGGxYfb9BLgto958=
Received: by 10.38.79.33 with SMTP id c33mr2010556rnb;
        Sun, 19 Jun 2005 20:30:57 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sun, 19 Jun 2005 20:30:57 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <2cfc403205061920272ee47166@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> 1. count all visible nodes [ i.e. nodes that git-rev-list would print
> ], call this value N
> 2. at the top node inject N units of mass
> 3. traverse the visible graph, in topological order
> 4. at each node, send all the mass received from parents minus 1 unit
> onto visible parents. Record how much mass you have sent downstream.
> Keep a record of the nodes that have seen nearest to half of that
> mass.

Correction - at each node, send all mass received from _children_
