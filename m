From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Sat, 14 May 2005 04:39:30 +0200
Message-ID: <1116038370.9317.17.camel@dhcp-188.off.vrfy.org>
References: <20050511012626.GL26384@pasky.ji.cz>
	 <20050511093015.GK8176@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 04:39:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWmZ7-0004sC-JF
	for gcvg-git@gmane.org; Sat, 14 May 2005 04:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbVENCjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 22:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbVENCjn
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 22:39:43 -0400
Received: from soundwarez.org ([217.160.171.123]:29068 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262682AbVENCja (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 22:39:30 -0400
Received: from dhcp-188.off.vrfy.org (c211149.adsl.hansenet.de [213.39.211.149])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 59CAD288A7;
	Sat, 14 May 2005 04:39:29 +0200 (CEST)
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20050511093015.GK8176@lug-owl.de>
X-Mailer: Evolution 2.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 11:30 +0200, Jan-Benedict Glaw wrote:
> On Wed, 2005-05-11 03:26:26 +0200, Petr Baudis <pasky@ucw.cz> wrote:
> >   I would be very happy if you could extend the gitweb scripts a little.
> > Basically, what I need is to have ability to create a permanent link to
> > a given file in the repository, which stays same across revisions (as
> > long as the file stays with the given name, obviously).
> 
> I've got another one. I'd like to see st_mtime on the file lists to see
> when a file was last touched...

We don't have that information in the trees. The date is only available
in the commits and reading all commits or storing that information in a
index or a database is beyond the scope of that simple cgi.

Thanks,
Kay

