From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Tue, 3 May 2005 12:54:43 -0400
Message-ID: <200505031254.43952.mason@suse.com>
References: <200505030657.38309.alonz@nolaviz.org> <200505031037.38005.mason@suse.com> <Pine.LNX.4.62.0505031104080.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Alon Ziv <alonz@nolaviz.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 18:49:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT0ZT-0005f4-Bl
	for gcvg-git@gmane.org; Tue, 03 May 2005 18:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVECQys (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 12:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVECQys
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 12:54:48 -0400
Received: from mx1.suse.de ([195.135.220.2]:1244 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261357AbVECQyr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 12:54:47 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 4A003160E91A;
	Tue,  3 May 2005 18:54:46 +0200 (CEST)
To: Nicolas Pitre <nico@cam.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.62.0505031104080.14033@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 03 May 2005 11:04, Nicolas Pitre wrote:
> On Tue, 3 May 2005, Chris Mason wrote:

> > coffee:~/git/linus.orig # echo foo > foo
> > coffee:~/git/linus.orig # echo foo2 > foo2
> > coffee:~/git/linus.orig # ./test-delta -d foo foo2 delta1
> > coffee:~/git/linus.orig # ls -la delta1
> > -rw-r--r--  1 root root 14 2005-05-03 10:36 delta1
> > coffee:~/git/linus.orig # ./test-delta -p foo delta1 out
> > *** glibc detected *** free(): invalid next size (fast): 0x0804b008 ***
>
> OK, doh!

Thanks, this one works ;)  I'll kick off a run with this replacing zdelta, 
should be around 3 hours.  For my small tree run with 300 patches, its faster 
than zdelta with about the same space savings.

-chris
