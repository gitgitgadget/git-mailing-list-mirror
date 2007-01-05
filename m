From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: git-svn throwing assertion on old svn tracking branch
Date: Fri, 5 Jan 2007 10:18:55 +0100
Message-ID: <20070105091855.GA10777@hermes.lan.home.vilz.de>
References: <20061220235551.GA2974@hermes.lan.home.vilz.de> <20061221010520.GB3901@localdomain> <20070101022734.GF7730@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 10:19:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2lEb-0008IQ-2K
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 10:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbXAEJTa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 04:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbXAEJT3
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 04:19:29 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:3705 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965134AbXAEJT2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 04:19:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id E3CF33E6B;
	Fri,  5 Jan 2007 10:19:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZ3frF39tsMx; Fri,  5 Jan 2007 10:18:50 +0100 (CET)
Received: from localhost (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 7BEFF3E57;
	Fri,  5 Jan 2007 10:18:49 +0100 (CET)
To: Eric Wong <normalperson@yhbt.net>
Content-Disposition: inline
In-Reply-To: <20070101022734.GF7730@hand.yhbt.net>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35983>

On Sun, Dec 31, 2006 at 06:27:34PM -0800, Eric Wong wrote:
> Eric Wong <normalperson@yhbt.net> wrote:
> > Nicolas Vilz <niv@iaglans.de> wrote:
> > > hello guys,
> > > 
> > > it has been a while, i tried git in conjunction with svn... i got a nice
> > > history, when working with it. This Work is now a year old.
> > > 
> > > Now I wanted to get on working and got following error message while
> > > fetching from one specific svn tracking branch:
> > > 
> > > $ git-svn fetch -i svn_master
> > > perl: subversion/libsvn_subr/path.c:343: svn_path_remove_component: 
> > > Assertion `is_canonical(path->data, path->len)' failed.
> > > Aborted
> 
> Actually, I just hit upon a weird bug in svm (SVN::Mirror) that was
> similar to this (line 114 of the same file, 1.4.2dfsg1-2 in Debian).
> Can you try taking the trailing slash out of the URL?
> (.git/svn/svn_master/info/url).
> 
> Thanks.


Actually I can fetch the revisions now again. Maybe that that little
trailing slash did it.

Nicolas Vilz
