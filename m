From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Sat, 14 May 2005 04:43:18 +0200
Message-ID: <1116038598.9317.22.camel@dhcp-188.off.vrfy.org>
References: <20050511012626.GL26384@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 04:43:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWmch-00058A-Df
	for gcvg-git@gmane.org; Sat, 14 May 2005 04:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVENCnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 22:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbVENCnW
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 22:43:22 -0400
Received: from soundwarez.org ([217.160.171.123]:44172 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262683AbVENCnS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 22:43:18 -0400
Received: from dhcp-188.off.vrfy.org (c211149.adsl.hansenet.de [213.39.211.149])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 419EA288A7;
	Sat, 14 May 2005 04:43:17 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050511012626.GL26384@pasky.ji.cz>
X-Mailer: Evolution 2.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 03:26 +0200, Petr Baudis wrote:
>   I would be very happy if you could extend the gitweb scripts a little.
> Basically, what I need is to have ability to create a permanent link to
> a given file in the repository, which stays same across revisions (as
> long as the file stays with the given name, obviously).
> 
>   E.g. I would like to have something like
> 
> 	http://www.kernel.org/git/gitweb.cgi?p=cogito%2Fcogito.git;n=contrib/ciabot.pl
> 
> for file contrib/ciabot.pl in the latest Cogito tree, and

http://www.kernel.org/git/gitweb.cgi?p=cogito/cogito.git;a=blob;f=contrib/ciabot.pl

> 	http://www.kernel.org/git/gitweb.cgi?p=cogito%2Fcogito.git;n=contrib
> 
> for the list of the contrib/ directory in the latest Cogito tree.

http://www.kernel.org/git/gitweb.cgi?p=cogito/cogito.git;a=tree;f=contrib

>   I think I would prefer the link from the repository index to go not to
> the log page, but some "summary" page, which would have some short
> information about the repository (owner, description, list of branches
> if gitweb supports that, list of tags, link to the latest tree and link
> to the log).

Sounds reasonable, I will try that with the next round.

Thanks,
Kay

