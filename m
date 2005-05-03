From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Tue, 3 May 2005 10:37:37 -0400
Message-ID: <200505031037.38005.mason@suse.com>
References: <200505030657.38309.alonz@nolaviz.org> <200505031013.57476.mason@suse.com> <Pine.LNX.4.62.0505031022340.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Alon Ziv <alonz@nolaviz.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 16:40:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSyYK-0006ZG-QJ
	for gcvg-git@gmane.org; Tue, 03 May 2005 16:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVECOns (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 10:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVECOkF
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 10:40:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:20903 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261637AbVECOhl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 10:37:41 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 72C129CF1;
	Tue,  3 May 2005 16:37:40 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 239921506F1; Tue,  3 May 2005 16:37:40 +0200 (CEST)
To: Nicolas Pitre <nico@cam.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.62.0505031022340.14033@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tuesday 03 May 2005 10:24, Nicolas Pitre wrote:
> On Tue, 3 May 2005, Chris Mason wrote:
> > Hmmm, something is strange here, am I using this wrong?
> >
> > coffee:~/git/linus.orig # ./test-delta -d foo foo2 delta1
> > coffee:~/git/linus.orig # ./test-delta -p foo delta1 out
> > *** glibc detected *** free(): invalid next size (fast): 0x0804b008 ***
> > Aborted
>
> Can you send me your foo and delta2 files?
>
Sorry, thought I had the whole command history in there.  I went for something 
small to start ;)

coffee:~/git/linus.orig # echo foo > foo
coffee:~/git/linus.orig # echo foo2 > foo2
coffee:~/git/linus.orig # ./test-delta -d foo foo2 delta1
coffee:~/git/linus.orig # ls -la delta1
-rw-r--r--  1 root root 14 2005-05-03 10:36 delta1
coffee:~/git/linus.orig # ./test-delta -p foo delta1 out
*** glibc detected *** free(): invalid next size (fast): 0x0804b008 ***

-chris
