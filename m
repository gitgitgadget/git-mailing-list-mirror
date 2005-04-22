From: Andy Isaacson <adi@hexapodia.org>
Subject: Re: [patch] fixup GECOS handling
Date: Fri, 22 Apr 2005 16:30:12 -0700
Message-ID: <20050422233012.GA27638@hexapodia.org>
References: <1113820589.16288.5.camel@nosferatu.lan> <1113827713.5286.13.camel@localhost.localdomain> <1114179795.29271.18.camel@nosferatu.lan> <1114186599.31076.409.camel@axer.marchex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: azarah@nosferatu.za.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 01:26:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP7Wq-00060N-5d
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 01:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVDVXaR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 19:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVDVXaR
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 19:30:17 -0400
Received: from pirx.hexapodia.org ([199.199.212.25]:42040 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261319AbVDVXaN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 19:30:13 -0400
Received: by pirx.hexapodia.org (Postfix, from userid 22448)
	id CBF94440; Fri, 22 Apr 2005 16:30:12 -0700 (PDT)
To: Kyle Hayes <kyle@marchex.com>
Content-Disposition: inline
In-Reply-To: <1114186599.31076.409.camel@axer.marchex.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 22, 2005 at 09:16:39AM -0700, Kyle Hayes wrote:
> if(comma)
> 	if(semi)
> 		/* lastname, firstname; room #; phone # format */
> 		*semi  = 0;
> 	else
> 		*comma = 0;
> else if(semi)
> 	*semi = 0;

That's a really complicated way of writing

if(semi) *semi = 0;
else if(comma) *comma = 0;

(The two code fragments are precisely identical.  Mmmm, strength
reduction.)

-andy
