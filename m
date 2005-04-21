From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Wed, 20 Apr 2005 22:45:20 -0400 (EDT)
Message-ID: <2577.10.10.10.24.1114051520.squirrel@linux1>
References: <20050420205633.GC19112@pasky.ji.cz>   
    <20050420211919.GA20129@kroah.com> <20050420215117.GJ19112@pasky.ji.cz>
       <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>   
    <20050420222815.GM19112@pasky.ji.cz>   
    <Pine.LNX.4.58.0504201710500.2344@ppc970.osdl.org>   
    <Pine.LNX.4.58.0504201809170.2344@ppc970.osdl.org>   
    <20050421033526.GA9404@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Petr Baudis" <pasky@ucw.cz>,
	"Greg KH" <greg@kroah.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 05:40:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOSY9-00043K-Eq
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 05:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVDUDom (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 23:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVDUDom
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 23:44:42 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:30449 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261200AbVDUDoj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 23:44:39 -0400
Received: from linux1 ([67.71.124.169]) by simmts6-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050421034438.WTSL1597.simmts6-srv.bellnexxia.net@linux1>;
          Wed, 20 Apr 2005 23:44:38 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j3L2jI79018841;
	Wed, 20 Apr 2005 22:45:18 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Wed, 20 Apr 2005 22:45:20 -0400 (EDT)
To: "Daniel Jacobowitz" <dan@debian.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
In-Reply-To: <20050421033526.GA9404@nevyn.them.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, April 20, 2005 11:35 pm, Daniel Jacobowitz said:

> My logic: it's a lot more intuitive to say "cg-log | less" to get
paginated output than it is to say "cg-log | cat" to get unpaginated
output.
>

Daniel,

All you'd have to do is:

$ export PAGER=cat

to get the behavior you want.

Sean




