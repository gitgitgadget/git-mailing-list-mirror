From: Alexander Litvinov <lan@academsoft.ru>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Thu, 15 Jun 2006 20:00:42 +0700
Organization: AcademSoft Ltd.
Message-ID: <200606152000.43029.lan@academsoft.ru>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il> <f36b08ee0606150440l544455c7r5c52609b360d0f74@mail.gmail.com> <8aa486160606150549n4b55912ap@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Yakov Lerner" <iler.ml@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 15:01:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqrT4-0002WJ-4K
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 15:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbWFONA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 09:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWFONA7
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 09:00:59 -0400
Received: from gw.ac-sw.com ([81.1.223.2]:25028 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1030378AbWFONA6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 09:00:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP
	id B4B49BD8E; Thu, 15 Jun 2006 20:00:56 +0700 (NOVST)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02073-09; Thu, 15 Jun 2006 20:00:47 +0700 (NOVST)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 7D558BDE3; Thu, 15 Jun 2006 20:00:47 +0700 (NOVST)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 25B698DA2A5C; Thu, 15 Jun 2006 20:00:46 +0700 (NOVST)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 7E0AB8D9ED37;
	Thu, 15 Jun 2006 20:00:43 +0700 (NOVST)
To: Santi <sbejar@gmail.com>
User-Agent: KMail/1.8
In-Reply-To: <8aa486160606150549n4b55912ap@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21892>

> > If so, why can't you
> > use prefix=/home/santi/usr/stow/git both in 'make' and in 'make install'
> > ? Would this work ?
>
> For the few tests I've made it does works, but it is not the
> recommended method from the stow developers, and I suppose they know
> better than me.

I always use make prefix=/usr/local/stow/git-bla-bla and it works. The only 
thing that make break is the case when you install library into such prefix 
and it store it in the pkgconfig file. And when you will compile application 
it will be build with library paths set to /usr/local/stow/lib/libxyz and not 
to /usr/local/lib/libxyz.

But I dont make such big dependences from sources so it works.
