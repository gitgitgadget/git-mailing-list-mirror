From: Kyle Hayes <kyle@marchex.com>
Subject: Re: [patch] fixup GECOS handling
Date: Mon, 25 Apr 2005 10:02:17 -0700
Organization: Marchex Inc.
Message-ID: <1114448538.13449.14.camel@axer.marchex.com>
References: <1113820589.16288.5.camel@nosferatu.lan>
	 <1113827713.5286.13.camel@localhost.localdomain>
	 <1114179795.29271.18.camel@nosferatu.lan>
	 <1114186599.31076.409.camel@axer.marchex.com>
	 <20050422233012.GA27638@hexapodia.org>
Reply-To: kyle@marchex.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: azarah@nosferatu.za.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 18:58:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ6ti-0003ip-Tu
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 18:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVDYRC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 13:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVDYRC0
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 13:02:26 -0400
Received: from peer.sef.marchex.com ([66.150.8.204]:64522 "HELO
	nosecone.marchex.com") by vger.kernel.org with SMTP id S262654AbVDYRCT
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 13:02:19 -0400
Received: (qmail 36793 invoked from network); 25 Apr 2005 17:02:18 -0000
Received: from unknown (HELO axer.marchex.com) (10.101.11.64)
  by nosecone.marchex.com with SMTP; 25 Apr 2005 17:02:18 -0000
To: Andy Isaacson <adi@hexapodia.org>
In-Reply-To: <20050422233012.GA27638@hexapodia.org>
X-Mailer: Evolution 2.0.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-22 at 16:30 -0700, Andy Isaacson wrote:
> On Fri, Apr 22, 2005 at 09:16:39AM -0700, Kyle Hayes wrote:
> > if(comma)
> > 	if(semi)
> > 		/* lastname, firstname; room #; phone # format */
> > 		*semi  = 0;
> > 	else
> > 		*comma = 0;
> > else if(semi)
> > 	*semi = 0;
> 
> That's a really complicated way of writing
> 
> if(semi) *semi = 0;
> else if(comma) *comma = 0;
> 
> (The two code fragments are precisely identical.  Mmmm, strength
> reduction.)

Indeed :-)

As someone else noted, this was too complex.  As another person noted,
this (like the SHA1 thread) has been thrashed around more than enough.

Best,
Kyle

-- 
Kyle Hayes <kyle@marchex.com>
Marchex Inc.

