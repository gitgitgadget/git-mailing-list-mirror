From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Wed, 11 May 2005 10:47:07 +0200
Message-ID: <1115801227.22799.13.camel@localhost.localdomain>
References: <20050511012626.GL26384@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 10:40:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVmlG-0005Na-5E
	for gcvg-git@gmane.org; Wed, 11 May 2005 10:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVEKIr3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 04:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVEKIr3
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 04:47:29 -0400
Received: from mx1.suse.de ([195.135.220.2]:59618 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261928AbVEKIrK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2005 04:47:10 -0400
Received: from hermes.suse.de (hermes-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id D1044160FC1E;
	Wed, 11 May 2005 10:47:07 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050511012626.GL26384@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 (2.2.2-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 03:26 +0200, Petr Baudis wrote:
>   Hello,
> 
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
> 
> 	http://www.kernel.org/git/gitweb.cgi?p=cogito%2Fcogito.git;n=contrib
> 
> for the list of the contrib/ directory in the latest Cogito tree.

With the next round I will try to introduce a real browser through the
tree instead of the current damn simple tree-object list. It would be
nice if it can show the the current path and provide a "up to parent"
way. Along with that it should be easy to add the stuff you asked for.

>   I think I would prefer the link from the repository index to go not to
> the log page, but some "summary" page, which would have some short
> information about the repository (owner, description, list of branches
> if gitweb supports that, list of tags, link to the latest tree and link
> to the log).
> 
>   BTW, why are people using ';' in the URIs for separators instead of
> good old '&'s? Hmm, actually it just occurred to me that it might be to
> workaround entity string problems?

Yes, but it's "bad old" not "good". :)
  http://www.w3.org/TR/html4/appendix/notes.html#h-B.2.2

Thanks,
Kay

