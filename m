From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Fri, 20 May 2005 19:58:52 +0200
Message-ID: <1116611932.12975.22.camel@dhcp-188>
References: <20050511012626.GL26384@pasky.ji.cz>
	 <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
	 <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 20:01:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZBm2-0007KS-C0
	for gcvg-git@gmane.org; Fri, 20 May 2005 19:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVETR7f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 13:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVETR70
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 13:59:26 -0400
Received: from soundwarez.org ([217.160.171.123]:56025 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261524AbVETR7L (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 13:59:11 -0400
Received: from dhcp-188.off.vrfy.org (d027239.adsl.hansenet.de [80.171.27.239])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 67CC66835;
	Fri, 20 May 2005 19:59:06 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>
X-Mailer: Evolution 2.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-20 at 09:54 -0700, Linus Torvalds wrote:
> 
> On Wed, 18 May 2005, Kay Sievers wrote:
> > 
> > I did this now. The top-link shows now the repository listing with a
> > nice "last change" field. The default link points to an overview page
> > which also list the tags.
> 
> In the summary page, could we get authorship information too? Right now it 
> looks like
> 
> 	recent commits
> 
> 	15 minutes ago	[PATCH] Add tests for diff-tree
> 	31 minutes ago	diff-tree: use new base_name_compare() helper function
> 	34 minutes ago	Introduce "base_name_compare()" helper function 
> 	...
> 
> and wouldn't it be nice if it told you who had written these things, like
> 
> 	recent commits
> 
> 	15 minutes ago	Junio C Hamano	[PATCH] Add tests for diff-tree
> 	31 minutes ago	Linus Torvalds	diff-tree: use new base_name_compare() helper function
> 	34 minutes ago	Linus Torvalds	Introduce "base_name_compare()" helper function 
> 	...
> 
> (limit the name to the first 20 characters or something to make things 
> line up).

Something like that: :)
  http://www.kernel.org/git/?p=cogito/cogito.git;a=summary

Kay

