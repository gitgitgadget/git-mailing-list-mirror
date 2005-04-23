From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 14:14:57 -0400 (EDT)
Message-ID: <1242.10.10.10.24.1114280097.squirrel@linux1>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org>
    <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com>
    <426A4669.7080500@ppp0.net>
    <1114266083.3419.40.camel@localhost.localdomain>
    <426A5BFC.1020507@ppp0.net>
    <1114266907.3419.43.camel@localhost.localdomain>
    <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
    <2646.10.10.10.24.1114278656.squirrel@linux1>
    <20050423190257.GA4194@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"David Woodhouse" <dwmw2@infradead.org>,
	"Jan Dittmer" <jdittmer@ppp0.net>, "Greg KH" <greg@kroah.com>,
	"Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 21:10:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPQ0p-0006q4-2C
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 21:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVDWTOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 15:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVDWTOa
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 15:14:30 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:18827 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261720AbVDWTOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 15:14:19 -0400
Received: from linux1 ([67.71.124.169]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050423191418.LXUY1623.simmts8-srv.bellnexxia.net@linux1>;
          Sat, 23 Apr 2005 15:14:18 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j3NIEvUd022461;
	Sat, 23 Apr 2005 14:14:57 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sat, 23 Apr 2005 14:14:57 -0400 (EDT)
In-Reply-To: <20050423190257.GA4194@cip.informatik.uni-erlangen.de>
To: "Thomas Glanzmann" <sithglan@stud.uni-erlangen.de>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, April 23, 2005 3:02 pm, Thomas Glanzmann said:
> Hello,
>
>> Why not leave tags open to being signed or unsigned?
>
> I think that this is the idea anyway.
>
>> For presentation in the log or whatever, the script can look inside the
>> clear text message, grab the SHA1 and display it in the header area;
>> even
>> though it's not really in the header, always just in the clear text
>> area.
>
> Having the SHA1 signature twice in would be confusing and error-prone
> when checking is done automated.
>
> So establishing the infrastructure is a good thing. To use it for every
> commit is another issue.


There's no need to have the SHA1 object reference twice.  It will only be 
in the clear text, nowhere else.  Of course scripts that display the log,
could show the object reference in the header area for aesthetics. 
Another nice thing is that this works no matter cleartext signing methods
emerge in the future.

Sean



